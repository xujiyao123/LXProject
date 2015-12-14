//
//  PKResManager.m
//  TestResManager
//
//  Created by zhong sheng on 12-7-13.
//  Copyright (c) 2012年 . All rights reserved.
//

#import "PKResManager.h"
#import "PKResManagerKit.h"

static const void* RetainNoOp(CFAllocatorRef allocator, const void *value) { return value; }
static void ReleaseNoOp(CFAllocatorRef allocator, const void *value) { }
NSMutableArray* CreateNonRetainingArray() {
    CFArrayCallBacks callbacks = kCFTypeArrayCallBacks;
    callbacks.retain = RetainNoOp;
    callbacks.release = ReleaseNoOp;
    return (NSMutableArray*)CFBridgingRelease(CFArrayCreateMutable(nil, 0, &callbacks));
}

@interface PKResManager (/*private*/)
@property (nonatomic, strong) NSMutableArray *styleChangedHandlers; // delegates
@property (nonatomic, strong) NSMutableArray *resObjectsArray;
@property (nonatomic, strong) NSMutableArray *defaultStyleArray;
@property (nonatomic, strong) NSMutableArray *customStyleArray;

- (NSString *)getDocumentsDirectoryWithSubDir:(NSString *)subDir;
- (BOOL)isBundleURL:(NSString *)URL;
- (BOOL)isDocumentsURL:(NSString *)URL;
- (void)saveCustomStyleArray;
- (NSMutableArray*)getSavedStyleArray;
@end

@implementation PKResManager

// public
@synthesize
commonStyleBundle = _commonStyleBundle,
styleBundle = _styleBundle,
defaultResOtherCache = _defaultResOtherCache,
resImageCache = _resImageCache,
resOtherCache = _resOtherCache,
allStyleArray = _allStyleArray,
styleId = _styleId,
styleType = _styleType,
isLoading = _isLoading;

// private
@synthesize
styleChangedHandlers = _styleChangedHandlers,
resObjectsArray = _resObjectsArray,
defaultStyleArray = _defaultStyleArray,
customStyleArray = _customStyleArray;

- (void)dealloc
{
    [self.styleChangedHandlers removeAllObjects];
    if (_allStyleArray.count>0) {
        [_allStyleArray removeAllObjects];
        _allStyleArray= nil;
    }
}

- (void)addChangeStyleObject:(id)object
{
    @synchronized(self.resObjectsArray){
        if (![self.resObjectsArray containsObject:object]){
            [self.resObjectsArray addObject:object];
        }
    }
}

- (BOOL)containsStyleById:(NSString *)rid;
{
    __block BOOL exist = NO;
    NSArray *allStyle = [self allStyleArray];
    [allStyle enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *styleDict = obj;
        NSString *sid = [styleDict objectForKey:kStyleID];
        if ([sid isEqualToString: rid]) {
            exist = YES;
            *stop = YES;
        }
    }];
    return exist;
}

- (void)removeChangeStyleObject:(id)object
{
    if ([self.resObjectsArray containsObject:object])
    {
        @synchronized(self.resObjectsArray)
        {
            [self.resObjectsArray removeObject:object];
        }
    }
}

- (void)swithToStyle:(NSString *)sid
{
    [self swithToStyle:sid onComplete:^(BOOL finished, NSError *error) {
        return ;
    }];
}

- (void)swithToStyle:(NSString *)sid onComplete:(ResStyleCompleteBlock)block
{
    if ([_styleId isEqualToString:sid] || sid == nil){
        NSError *error = [NSError errorWithDomain:PK_ERROR_DOMAIN code:PKErrorCodeUnavailable userInfo:nil];
        block(YES,error);
        return;
    }else if (_isLoading) {
        block(NO,nil);
        return;
    }

    _isLoading = YES;
    block(NO,nil);
    
    _styleId = [sid copy];
    
    // read resource bundle
    _styleBundle = [self bundleByStyleId:sid];
    if (self.styleBundle == nil) {
        NSError *error = [NSError errorWithDomain:PK_ERROR_DOMAIN code:PKErrorCodeBundleName userInfo:nil];
        block(YES,error);
        _isLoading = NO;
        return;
    }
    
    // remove cache
    [_resImageCache removeAllObjects];
    [_resOtherCache removeAllObjects];
    
    // get plist dict
    NSString *plistPath=[self.styleBundle pathForResource:CONFIG_PLIST_PATH ofType:@"plist"];
    self.resOtherCache = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];

    NSMutableArray *holdResObjectArray = [NSMutableArray array];

    if (_resObjectsArray && _resObjectsArray.count > 0) {
        for (int i = _resObjectsArray.count - 1; i >= 0 ; i--) {
            [holdResObjectArray addObject:[_resObjectsArray objectAtIndex:i]];
        }
    }

    // change style
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        [holdResObjectArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (obj != nil && [obj respondsToSelector:@selector(changeSkinStyle:)]){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [obj changeSkinStyle:self];
                });
            }else{
                //DLog(@" change style failed ! => %@",obj);
            }

            __block double progress = (double)(idx+1) / (double)(holdResObjectArray.count);
            for(ResStyleProgressBlock progressBlock in self.styleChangedHandlers){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    progressBlock(progress);
                });
                
            }
        }];
        _isLoading = NO;
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_styleId];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:kNowResStyle];
            block(YES,nil);
        });
    });
    
    while (!_isLoading) {
        return;
    }
    
}
- (BOOL)containsStyle:(NSString *)sid
{
    if ([self styleTypeIndexById:sid] != NSNotFound) {
        return YES;
    }
    return NO;
}
- (void)changeStyleOnProgress:(ResStyleProgressBlock)progressBlock
{
    ResStyleProgressBlock tempBlock = [progressBlock copy];
    [self.styleChangedHandlers addObject:tempBlock];
}

- (BOOL)deleteStyle:(NSString *)sid
{
    NSUInteger index = [self styleTypeIndexById:sid];
    // default style ,can not delete
    if (index < self.defaultStyleArray.count
        || index == NSNotFound)
    {
        return NO;
    }
    
    NSDictionary *styleDict = (self.allStyleArray)[index];
    NSString *bundleName = [(NSString *)styleDict[kStyleURL]
                            substringFromIndex:DOCUMENTS_PREFIX.length];
    BOOL isDir=NO;
    NSError *error = nil;
    NSString *stylePath = [[self getDocumentsDirectoryWithSubDir:nil]
                           stringByAppendingFormat:@"/%@",bundleName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:stylePath isDirectory:&isDir] && isDir){
        DLog(@" No such file or directory");
    }
    if (![fileManager removeItemAtPath:stylePath error:&error]){
        DLog(@" delete file error:%@",error);
    }
    
    [_allStyleArray removeObjectAtIndex:index];
    [self saveCustomStyleArray];

    if ([_styleId isEqualToString:sid]) {
        [self resetStyle];
    }
    
    return YES;
}

- (BOOL)saveStyle:(NSString *)styleId name:(NSString *)name title:(NSString *)title version:(NSNumber *)version withBundle:(NSBundle *)bundle
{
    NSString *bundlePath = bundle.resourcePath;
    NSArray *elementArray = [bundlePath componentsSeparatedByString:@"/"];
    NSString *bundleName = [elementArray lastObject];
    if (bundleName != nil)
    {
        NSUInteger index = [self styleTypeIndexById:styleId];
        NSDictionary *styleDict = [NSDictionary dictionaryWithObjects:@[styleId,
                                                                       name,
                                                                       title,
                                                                       [NSString stringWithFormat:@"%@%@/%@",DOCUMENTS_PREFIX,SAVED_STYLE_DIR,bundleName],
                                                                       version]
                                                              forKeys:@[kStyleID,
                                                                       kStyleName,
                                                                       kStyleTitle,
                                                                       kStyleURL,
                                                                       kStyleVersion]];
        if (index != NSNotFound){
            _allStyleArray[index] = styleDict;
        }
        else{
            [_allStyleArray addObject:styleDict];
        }
        [self saveCustomStyleArray];
        
        NSError *error = nil;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *customStylePath = [[self getDocumentsDirectoryWithSubDir:SAVED_STYLE_DIR]
                                     stringByAppendingFormat:@"/%@",bundleName];

        if ([fileManager fileExistsAtPath:customStylePath]){
            NSError *updateError = nil;
            if (![fileManager removeItemAtPath:customStylePath error:&updateError]){
            }
        }
        if (![fileManager copyItemAtPath:bundlePath toPath:customStylePath error:&error]){
            return NO;
        }
        else{
            //将源文件删除
            [fileManager removeItemAtPath:bundlePath error:nil];
        }
        return YES;
    }
    return NO;
}

- (void)clearImageCache
{
    [_resImageCache removeAllObjects];
}

- (void)resetStyle
{
    // swith to default style
    _isLoading = NO;
    NSDictionary *defalutStyleDict = _defaultStyleArray[0];
    NSString *styleId = defalutStyleDict[kStyleID];
    [self swithToStyle:styleId];
}

- (UIImage *)previewImage
{
    return [self previewImageByStyleId:_styleId];
}

- (UIImage *)previewImageByStyleId:(NSString *)sid
{
    UIImage *image = nil;
    NSBundle *bundle = [self bundleByStyleId:sid];
    if (bundle != nil) {
        NSString *imagePath = [bundle pathForResource:PREVIEW_PATH ofType:@"png"];
        image = [UIImage imageWithContentsOfFile:imagePath];
    }
    return image;
}

- (NSMutableDictionary *)defaultResOtherCache
{
    if (!_defaultResOtherCache)
    {
        NSString *plistPath=[self.commonStyleBundle pathForResource:CONFIG_PLIST_PATH ofType:@"plist"];
        _defaultResOtherCache = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    }
    return _defaultResOtherCache;
}

#pragma mark - Private

- (BOOL)isBundleURL:(NSString *)URL
{
    return [URL hasPrefix:BUNDLE_PREFIX];
}

- (BOOL)isDocumentsURL:(NSString *)URL
{
    return [URL hasPrefix:DOCUMENTS_PREFIX];
}

- (void)saveCustomStyleArray
{
    self.customStyleArray = [NSMutableArray arrayWithArray:self.allStyleArray];
    NSRange range;
    range.location = 0;
    range.length = self.defaultStyleArray.count;
    [self.customStyleArray removeObjectsInRange:range];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.customStyleArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kAllResStyle];
}

//初始化并获取存储的主题
- (NSMutableArray*)getSavedStyleArray
{
    if (!_defaultStyleArray) {
        NSDictionary *lightDict = [NSDictionary dictionaryWithObjects:@[SYSTEM_STYLE_ID,
                                                                       SYSTEM_STYLE_NAME,
                                                                       SYSTEM_STYLE_TITLE,
                                                                       SYSTEM_STYLE_URL,
                                                                       SYSTEM_STYLE_VERSION]
                                                              forKeys:@[kStyleID,
                                                                       kStyleName,
                                                                       kStyleTitle,
                                                                       kStyleURL,
                                                                       kStyleVersion]];

        _defaultStyleArray = [[NSMutableArray alloc] initWithObjects: lightDict,nil];
    }

    NSMutableArray *retArray = [NSMutableArray arrayWithArray:self.defaultStyleArray];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kAllResStyle];
    NSArray *customStyleArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [retArray addObjectsFromArray:customStyleArray];
    return retArray;
}

- (NSUInteger)styleTypeIndexById:(NSString *)sid
{
    __block NSUInteger styleIndex = NSNotFound;
    [_allStyleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         NSDictionary *styleDict = (NSDictionary *)obj;
         NSString *styleId = styleDict[kStyleID];
         if ([styleId isEqualToString:sid])
         {
             styleIndex = idx;
             *stop = YES;
         }
     }];

    return styleIndex;
}

- (NSString *)getDocumentsDirectoryWithSubDir:(NSString *)subDir
{
    NSString *newDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    if (subDir)
    {
        newDirectory = [newDirectory stringByAppendingPathComponent:subDir];
    }
    
    BOOL isDir = NO;
	BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:newDirectory isDirectory:&isDir];
    NSError *error;
	if(!isDir){
		[[NSFileManager defaultManager] removeItemAtPath:newDirectory error:nil];
	}
	if(!isExist || !isDir){
        if(![[NSFileManager defaultManager] createDirectoryAtPath:newDirectory
                                      withIntermediateDirectories:NO attributes:nil error:&error])
        {
            //DLog(@"create file error：%@",error);
        }
	}
    return newDirectory;
}

- (NSBundle *)bundleByStyleId:(NSString *)sid
{
    NSInteger index = [self styleTypeIndexById:sid];
    if (index == NSNotFound) {
        return nil;
    }
    
    NSDictionary *styleDict = (self.allStyleArray)[index];
    NSString *bundleURL = styleDict[kStyleURL];
    NSString *filePath = nil;
    NSString *bundlePath = nil;
    
    BOOL changeStyle = NO;
    if ([self.styleId isEqualToString:sid]){
        changeStyle = YES;
    }

    if ([self isBundleURL:bundleURL])
    {
        if (changeStyle)
        {
            _styleType = ResStyleType_System;
        }
        
        filePath = [[NSBundle mainBundle] bundlePath];
        bundlePath = [NSString stringWithFormat:@"%@/%@",filePath,[bundleURL substringFromIndex:BUNDLE_PREFIX.length]];
    }
    else if([self isDocumentsURL:bundleURL])
    {
        if (changeStyle)
        {
            _styleType = ResStyleType_Custom;
        }
        filePath = [self getDocumentsDirectoryWithSubDir:nil];
        bundlePath = [NSString stringWithFormat:@"%@/%@",filePath,[bundleURL substringFromIndex:DOCUMENTS_PREFIX.length]];
    }
    else
    {
        //DLog(@"na ni !!! bundleName:%@",bundleURL);
        if (changeStyle)
        {
            _styleType = ResStyleType_Unknow;
        }
        return nil;
    }
    
    return [NSBundle bundleWithPath:bundlePath];
}

- (NSBundle *)getCommonBundle
{
    NSString *filePath = [[NSBundle mainBundle] bundlePath];
    NSString *bundlePath = [NSString stringWithFormat:@"%@/%@",filePath,[SYSTEM_STYLE_COMMON_BUNDLE substringFromIndex:BUNDLE_PREFIX.length]];
    return [NSBundle bundleWithPath:bundlePath];
}

#pragma mark - Singeton
- (id)init{
    self = [super init];
    if (self) {
        _commonStyleBundle = [self getCommonBundle];
        _styleChangedHandlers = [[NSMutableArray alloc] init];
        _resObjectsArray = CreateNonRetainingArray(); // 不retain的数组
        _resImageCache = [[NSMutableDictionary alloc] init];
        _resOtherCache = [[NSMutableDictionary alloc] init];

        // get all style ( will get defalut style array)
#warning 主题
//        _allStyleArray = [self getSavedStyleArray];
        
        // read
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kNowResStyle];
        if (data!=nil) {
            _isLoading = NO;
            NSString *nowStyleId = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self swithToStyle:nowStyleId];
        }else{
            [self resetStyle];
        }

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearImageCache)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
        
    }
    return self;
}

+ (PKResManager*)getInstance{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

#pragma mark - 通过key直接设置控件属性
- (void)setLabel:(UILabel *)label forKey:(NSString *)key {
    // 对类型容错
    if (![label isKindOfClass:[UILabel class]]) {
        return;
    }

    label.font = [UIFont fontForKey:key];
    label.textColor = [UIColor colorForKey:key];
    label.shadowColor = [UIColor shadowColorForKey:key];
    label.backgroundColor = [UIColor clearColor];
}

- (void)setButton:(UIButton *)button forKey:(NSString *)key andHightlighted:(BOOL)hightlighted {
    // 对类型容错
    if (![button isKindOfClass:[UIButton class]]) {
        return;
    }

    UIControlState state = hightlighted ? UIControlStateHighlighted : UIControlStateNormal;
    [button setTitleColor:[UIColor colorForKey:key] forState:state];
    [button setTitleShadowColor:[UIColor shadowColorForKey:key] forState:state];
    button.titleLabel.font = [UIFont fontForKey:key];
}


@end

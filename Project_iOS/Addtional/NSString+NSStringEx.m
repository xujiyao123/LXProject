//
//  NSString+NSStringEx.m
//  xiaonei
//
//  Created by citydeer on 09-4-15.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NSString+NSStringEx.h"
#import <CommonCrypto/CommonDigest.h>
#import "CJSONSerializer.h"
#import "GTMBase64.h"

@implementation NSString(NSStringEx)
static char encodingTable[64] =
{
    'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
    'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
    'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
    'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/'
};

NSInteger strCompare(id str1, id str2, void *context)
{
    return [((NSString*)str1) compare:str2 options:NSLiteralSearch];
}

#pragma mark -
- (NSString *)base64Encoding
{
    return [self base64EncodingWithLineLength:0];
}

- (NSString *)base64EncodingWithLineLength:(NSUInteger)lineLength
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    const unsigned char *bytes = [data bytes];
    NSMutableString *result = [NSMutableString stringWithCapacity:self.length];
    unsigned long ixtext = 0;
    unsigned long lentext = self.length;
    long ctremaining = 0;
    unsigned char inbuf[3], outbuf[4];
    unsigned short i = 0;
    unsigned short charsonline = 0, ctcopy = 0;
    unsigned long ix = 0;
    
    while( YES )
    {
        ctremaining = lentext - ixtext;
        if( ctremaining <= 0 ) break;
        
        for( i = 0; i < 3; i++ )
        {
            ix = ixtext + i;
            if( ix < lentext ) inbuf[i] = bytes[ix];
            else inbuf [i] = 0;
        }
        
        outbuf [0] = (inbuf [0] & 0xFC) >> 2;
        outbuf [1] = ((inbuf [0] & 0x03) << 4) | ((inbuf [1] & 0xF0) >> 4);
        outbuf [2] = ((inbuf [1] & 0x0F) << 2) | ((inbuf [2] & 0xC0) >> 6);
        outbuf [3] = inbuf [2] & 0x3F;
        ctcopy = 4;
        
        switch( ctremaining )
        {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for( i = 0; i < ctcopy; i++ )
            [result appendFormat:@"%c", encodingTable[outbuf[i]]];
        
        for( i = ctcopy; i < 4; i++ )
            [result appendString:@"="];
        
        ixtext += 3;
        charsonline += 4;
        
        if( lineLength > 0 )
        {
            if( charsonline >= lineLength )
            {
                charsonline = 0;
                [result appendString:@"\n"];
            }
        }
    }
    
    return [NSString stringWithString:result];
}
#pragma mark -
//SSO SecretKey AES 加密
//- (NSString *)AES128EncryptWithKey:(NSString *)key
//{
//    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *encryptedData = [plainData AES128EncryptWithKey:key];
//    
//    NSString *encryptedString = [encryptedData base64EncodedString];
//    
//    return encryptedString;
//}

//SSO SecretKey AES解密
//- (NSString *)AES128DecryptWithKey:(NSString *)key
//{
//    NSData *encryptedData = [NSData dataFromBase64String:self];
//    NSData *plainData = [encryptedData AES128DecryptWithKey:key];
//    
//    NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
//    
//    return [plainString autorelease];
//}

// TODO, need fix bug.
- (NSString *) getParameter:(NSString *)parameterName {
    NSRange nameRange = [self rangeOfString:parameterName];
    if (nameRange.location == NSNotFound) {
        return nil;
    }
    NSRange andRange = [self rangeOfString:@"&"
                                   options:0
                                     range:NSMakeRange(nameRange.location + nameRange.length,
                                                       self.length - (nameRange.location + nameRange.length))];
    if (andRange.location == NSNotFound) {
        return [self substringFromIndex:nameRange.location + nameRange.length + 1];
    } else {
        return [self substringWithRange:NSMakeRange(nameRange.location + nameRange.length + 1,
                                                    andRange.location - (nameRange.location + nameRange.length + 1))];
    }
}

+ (NSString *)formatStringWithCountNum:(long long int)count{
    NSString *result = nil;
    if (count>=0 && count<10000) {
        result = [NSString stringWithFormat:@"%lld",count];
    } else if (count>=10000 && count < 100000) {
        if(count%10000){
            result = [NSString stringWithFormat:@"%2.1f万",(float)count/10000];
        }else{
            result = [NSString stringWithFormat:@"%1.0f万",(float)count/10000];
        }
    } else if (count >= 100000 && count < 1000000) {
        result = [NSString stringWithFormat:@"%2.0f万",(float)count/10000];
    } else if (count >= 1000000 && count < 10000000) {
        result = [NSString stringWithFormat:@"%1.0f百万",(float)count/1000000];
    } else if (count >= 10000000 && count < 100000000) {
        result = [NSString stringWithFormat:@"%1.0f千万",(float)count/10000000];
    } else if (count >= 100000000 && count <= 9900000000) {
        result = [NSString stringWithFormat:@"%2.0f亿",(float)count/100000000];
    }else if (count >= 9900000000) {
        result = [NSString stringWithFormat:@"99亿＋"];
    }
    return result;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
//- (NSString*)escapeForPost {
//	NSArray *escapeChars = [NSArray arrayWithObjects:@"&", nil];
//
//	NSArray *replaceChars = [NSArray arrayWithObjects:@"\\&", nil];
//
//	int len = [escapeChars count];
//
//	NSString *tempStr = self;
//
//	if (tempStr == nil) {
//		return nil;
//	}
//
//	NSMutableString *temp = [tempStr mutableCopy];
//
//	int i;
//	for (i = 0; i < len; i++) {
//
//		[temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
//							  withString:[replaceChars objectAtIndex:i]
//								 options:NSLiteralSearch
//								   range:NSMakeRange(0, [temp length])];
//	}
//
//	NSString *outStr = [NSString stringWithString: temp];
//
//	[temp release];
//
//	return outStr;
//}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*) urlEncode:(NSStringEncoding)stringEncoding {
    
    //	NSArray *escapeChars = [NSArray arrayWithObjects:/*@";", */@"/", /*@"?", */@":",
    //							/*@"@", /*@"&", @"=", */@"+", /*@"$", @",", @"!",
    //							@"'", @"(", @")", @"*", */@"-", nil];
    
    //	NSArray *replaceChars = [NSArray arrayWithObjects:/*@"%3B", */@"%2F", /*@"%3F", */@"%3A",
    //							 /*@"%40", /*@"%26", @"%3D",*/@"%2B", /*@"%24", @"%2C", @"%21",
    //							@"%27", @"%28", @"%29", @"%2A", */@"%2D", nil];
    NSArray *escapeChars = [NSArray arrayWithObjects:@"/", @":", @"+", @"-", nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%2F", @"%3A", @"%2B", @"%2D", nil];
    
    int len = [escapeChars count];
    
    NSString *tempStr = [self stringByAddingPercentEscapesUsingEncoding:stringEncoding];
    
    if (tempStr == nil) {
        return nil;
    }
    
    NSMutableString *temp = [tempStr mutableCopy];
    
    int i;
    for (i = 0; i < len; i++) {
        
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *outStr = [NSString stringWithString: temp];
    return outStr;
}
- (NSString *)stringByReplaceString:(NSString *)rs withCharacter:(char)c {
    NSMutableString *ms = [NSMutableString stringWithCapacity:[self length]];
    
    int l = [self length];
    NSRange range;
    NSString *tmps;
    for (int i = 0; i<l; ) {
        tmps = [self substringFromIndex:i];
        range = [tmps rangeOfString:rs];
        if (range.length > 0) {
            [ms appendFormat:@"%@%c",[tmps substringToIndex:range.location],c];
            i += range.location + range.length;
        }else {
            [ms appendString:tmps];
            break;
        }
        
    }
    //	CJSONSerializer *js = [[CJSONSerializer alloc] init];
    //	[js serializeObject:rs];
    return ms;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*) urlEncode2:(NSStringEncoding)stringEncoding
{
    
    NSArray *escapeChars = [NSArray arrayWithObjects:@";", @"/", @"?", @":",
                            @"@", @"&", @"=", @"+", @"$", @",", @"!",
                            @"'", @"(", @")", @"*", @"-", @"~", @"_", nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B", @"%2F", @"%3F", @"%3A",
                             @"%40", @"%26", @"%3D", @"%2B", @"%24", @"%2C", @"%21",
                             @"%27", @"%28", @"%29", @"%2A", @"%2D", @"%7E", @"%5F", nil];
    
    int len = [escapeChars count];
    
    NSString *tempStr = [self stringByAddingPercentEscapesUsingEncoding:stringEncoding];
    
    if (tempStr == nil) {
        return nil;
    }
    
    NSMutableString *temp = [tempStr mutableCopy];
    
    int i;
    for (i = 0; i < len; i++) {
        
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *outStr = [NSString stringWithString: temp];

    return outStr;
}

- (NSString*) urlDecode:(NSStringEncoding)stringEncoding
{
    
    NSArray *escapeChars = [NSArray arrayWithObjects:@";", @"/", @"?", @":",
                            @"@", @"&", @"=", @"+", @"$", @",", @"!",
                            @"'", @"(", @")", @"*", @"-", @"~", @"_", nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B", @"%2F", @"%3F", @"%3A",
                             @"%40", @"%26", @"%3D", @"%2B", @"%24", @"%2C", @"%21",
                             @"%27", @"%28", @"%29", @"%2A", @"%2D", @"%7E", @"%5F", nil];
    
    int len = [escapeChars count];
    
    NSMutableString *temp = [self mutableCopy];
    
    if (temp == nil) {
        return nil;
    }
    
    int i;
    for (i = 0; i < len; i++) {
        
        [temp replaceOccurrencesOfString:[replaceChars objectAtIndex:i]
                              withString:[escapeChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    NSString *outStr = [NSString stringWithString: temp];
    return [outStr stringByReplacingPercentEscapesUsingEncoding:stringEncoding];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*) md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    if(cStr)
    {
        CC_MD5( cStr, strlen(cStr), result );
        return [[NSString stringWithFormat:
                 @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                 result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                 result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
                 ] lowercaseString];
    }
    else {
        return nil;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*) queryIdentifier {
    NSString* str = [self stringByReplacingOccurrencesOfString:@"&" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"=" withString:@""];
    str = [NSString stringWithFormat:@"%@", [str urlEncode:NSUTF8StringEncoding]];
    return str;
}
+ (NSString*) queryStringWithSignature:(NSDictionary *)query
                           opSecretKey:(NSString *)opSecretKey {
    return [self queryStringWithSignature:query
                              opSecretKey:opSecretKey
                            valueLenLimit:0];
}
///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString*) queryStringWithSignature:(NSDictionary *)query
                           opSecretKey:(NSString *)opSecretKey
                         valueLenLimit:(NSInteger)valueLenLimit {
    if (!query) {
        return nil;
    }
    
    if (!opSecretKey) {
        return [NSString queryStringFromQueryDictionary:query withURLEncode:YES];
    }
    
    // 计算Signature.
    NSString *changeKey,*changeValue;
    BOOL NeedChange = FALSE;
    NSMutableArray* unsorted = [NSMutableArray arrayWithCapacity:query.count];
    for (id key in query) {
        NSString *value = [query objectForKey:key];
        NSString *value2 = value;
        if (valueLenLimit > 0) {
            if (value2
                && [value2 isKindOfClass:[NSString class]]
                && value2.length > 50) {
                NSString* strTemp = [NSString stringWithUTF8String:[value2 UTF8String]];
                value2 = [strTemp substringToIndex:50];
                
                // 如果编码失败,修改内容值.
                if ([value2 lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 0) {
                    changeKey = key;
                    changeValue = [NSString stringWithFormat:@" %@",value];
                    NeedChange = TRUE;
                    strTemp = [NSString stringWithUTF8String:[changeValue UTF8String]];
                    value = [strTemp substringToIndex:50];
                }
                else {
                    value = value2;
                }
            }
        }
        [unsorted addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
    }
    
    if( NeedChange ){
        [query setValue:changeValue forKey:changeKey];
    }
    
    NSArray *sortedArray = [unsorted
                            sortedArrayUsingFunction:strCompare context:NULL];
    NSMutableString *buffer = [[NSMutableString alloc] initWithCapacity:0];
    NSEnumerator *i = [sortedArray objectEnumerator];
    id theObject;
    while (theObject = [i nextObject]) {
        [buffer appendString:theObject];
    }
    [buffer appendString:opSecretKey];
    
    //    NSMutableArray* unsorted2 = [NSMutableArray arrayWithCapacity:query.count];
    //    char* charTemp = malloc(10240);
    //    memset(charTemp, 0, 10240);
    //    for (id key in query) {
    //		NSString *value = [query objectForKey:key];
    //		[unsorted2 addObject:[NSString stringWithFormat:@"%@", key]];
    //	}
    //	NSArray *sortedArray2 = [unsorted2
    //							sortedArrayUsingFunction:strCompare context:NULL];
    
    //	NSMutableString *buffer = [[NSMutableString alloc] initWithCapacity:0];
    //	NSEnumerator *i2 = [sortedArray2 objectEnumerator];
    //	id theObject2;
    //    int strLenth = 0;
    //	while (theObject2 = [i2 nextObject]) {
    //        id idvalue = [query objectForKey:theObject2];
    //        NSString *value;
    //        if ([idvalue isKindOfClass:[NSNumber class]]) {
    //            value = [idvalue stringValue];
    //        }
    //        else if( [idvalue isKindOfClass:[NSString class]] ){
    //            value = idvalue;
    //        }
    //
    //        // 先写入key
    //        NSString *strKey = [NSString stringWithFormat:@"%@=",theObject2];
    //        const char* cKey = [strKey UTF8String];
    //        memcpy(charTemp+strLenth, cKey, strlen(cKey));
    //        strLenth+=strlen(cKey);
    //
    //        const char* cValue = [value UTF8String];
    //        int nLenth = strlen(cValue);
    //        if (value.length>50) {
    //
    //            NSString *str50 = [value substringToIndex:50];
    //            int nnnnn = [str50 lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    //            if (nnnnn > 0) {
    //                nLenth = nnnnn;
    //            }
    //            else {
    //                // 针对emoji做特殊处理
    //                NSString *str49 = [value substringToIndex:49];
    //                int nn = [str49 lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    //                nLenth = nn+2;
    //            }
    //        }
    //        memcpy(charTemp+strLenth, cValue, nLenth);
    //        strLenth+=nLenth;
    //	}
    //    NSLog(@"1111111111--------%@",[NSString stringWithCString:charTemp encoding:NSUTF8StringEncoding]);
    //    const char* cOp = [opSecretKey UTF8String];
    //
    //    memcpy(charTemp+strLenth, cOp, strlen(cOp));
    //	int chaconst = strlen(charTemp);
    //    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //    CC_MD5( charTemp, strlen(charTemp), result );
    //        NSString* signature = [[NSString stringWithFormat:
    //                 @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
    //                 result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
    //                 result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
    //                 ] lowercaseString];
    //
    //
    //    free(charTemp);
    // [buffer appendString:opSecretKey];
    NSString* signature = [buffer md5]; // 签名.
    
    // 将查询字典参数拼接成字符串,URL Encode,然后附带上Signature.
    [buffer deleteCharactersInRange:NSMakeRange(0, buffer.length)];
    for (id key in query) {
        NSString* value = [NSString stringWithFormat:@"%@",[query objectForKey:key]];
        value = [value urlEncode2:NSUTF8StringEncoding];
        [buffer appendString:[NSString stringWithFormat:@"&%@=%@", key, value]];
    }
    [buffer appendString:[NSString stringWithFormat:@"&sig=%@", signature]];
    NSString* ret = [buffer substringFromIndex:1]; // 去掉第一个'&'

    if(signature)
    {
    }
    
    return ret;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString*)signature:(NSDictionary*)query opSecretKey:(NSString *)opSecretKey valueLenLimit:(NSInteger)valueLenLimit
{
    if (!query) {
        return @"aaaaaaaaaaaaaa";
    }
    
    if (!opSecretKey) {
        return [NSString queryStringFromQueryDictionary:query withURLEncode:YES];
    }
    
    // 计算Signature.
    NSString *changeKey,*changeValue;
    BOOL NeedChange = FALSE;
    NSMutableArray* unsorted = [NSMutableArray arrayWithCapacity:query.count];
    for (id key in query) {
        NSString *value = [query objectForKey:key];
        NSString *value2 = value;
        if (valueLenLimit > 0) {
            if (value2
                && [value2 isKindOfClass:[NSString class]]
                && value2.length > 50) {
                NSString* strTemp = [NSString stringWithUTF8String:[value2 UTF8String]];
                value2 = [strTemp substringToIndex:50];
                
                // 如果编码失败,修改内容值.
                if ([value2 lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 0) {
                    changeKey = key;
                    changeValue = [NSString stringWithFormat:@" %@",value];
                    NeedChange = TRUE;
                    strTemp = [NSString stringWithUTF8String:[changeValue UTF8String]];
                    value = [strTemp substringToIndex:50];
                }
                else {
                    value = value2;
                }
            }
        }
        [unsorted addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
    }
    
    if( NeedChange ){
        [query setValue:changeValue forKey:changeKey];
    }
    
    NSArray *sortedArray = [unsorted sortedArrayUsingFunction:strCompare context:NULL];
    NSMutableString *buffer = [[NSMutableString alloc] initWithCapacity:0];
    NSEnumerator *i = [sortedArray objectEnumerator];
    
    id theObject;
    while (theObject = [i nextObject]) {
        [buffer appendString:theObject];
    }
    
    [buffer appendString:opSecretKey];
    
    NSString *signature = [NSString stringWithFormat:@"%@",[buffer md5]];
    //    NSString* signature = [buffer md5]; // 签名.
    return signature;
}


///////////////////////////////////////////////////////////////////////////////////////////////////

+ (NSString *)queryStringFromQueryDictionary:(NSDictionary *)query withURLEncode:(BOOL)doURLEncode{
    if (!query) {
        return nil;
    }
    
    NSMutableString *buffer = [[NSMutableString alloc] initWithCapacity:0];
    // 将查询字典参数拼接成字符串,URL Encode
    for (id key in query) {
        NSString* value = [NSString stringWithFormat:@"%@",[query objectForKey:key]];
        if (doURLEncode) {
            value = [value urlEncode2:NSUTF8StringEncoding];
        }
        [buffer appendString:[NSString stringWithFormat:@"&%@=%@", key, value]];
    }
    
    NSString* ret = [buffer substringFromIndex:1]; // 去掉第一个'&'
    return ret;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString*)componentsJoinedByDictionary:(NSDictionary *)dic
                                seperator:(NSString *)seperator {
    if (!dic || dic.count == 0) {
        return nil;
    }
    NSArray *allkeys = [dic allKeys];
    NSMutableString *ms = [NSMutableString string];
    for (NSString *key in allkeys) {
        [ms appendFormat:@"%@%@=%@", seperator, key, [dic objectForKey:key]];
    }
    return [ms substringFromIndex:1];
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*) queryAppendSignature:(NSString *)opSecretKey {
    NSString *opSecretKeyStr = [NSString stringWithString:opSecretKey];
    NSArray* unsorted = [self componentsSeparatedByString:@"&"];
    
    NSArray *sortedArray = [unsorted
                            sortedArrayUsingFunction:strCompare context:NULL];
    
    NSMutableString *buffer = [[NSMutableString alloc] initWithCapacity:0];
    
    NSEnumerator *i = [sortedArray objectEnumerator];
    
    id theObject;
    
    while (theObject = [i nextObject]) {
        [buffer appendString:theObject];
    }
    
    [buffer appendString:opSecretKeyStr];
    
    
    NSString* ret = [buffer md5];

    ret = [NSString stringWithFormat:@"%@&sig=%@", self, ret];
    
    return ret;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*) queryAppendSignatureForMap {
    NSArray* unsorted = [self componentsSeparatedByString:@"&"];
    
    NSArray *sortedArray = [unsorted
                            sortedArrayUsingFunction:strCompare context:NULL];
    
    NSMutableString *buffer = [[NSMutableString alloc] initWithCapacity:0];
    
    NSEnumerator *i = [sortedArray objectEnumerator];
    
    id theObject;
    
    while (theObject = [i nextObject]) {
        [buffer appendString:theObject];
    }
    
    [buffer appendString:@"android_secretkey"];
    
    NSString* ret = [buffer md5];

    ret = [NSString stringWithFormat:@"%@&sig=%@", self, ret];
    
    return ret;
}

/*
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 + (NSString*) queryStringWithSignature:(NSDictionary*)query
 opSecretKey:(NSString *)opSecretKey {
 if (!query) {
 return nil;
 }
 
 // 计算Signature.
 NSMutableArray* unsorted = [NSMutableArray arrayWithCapacity:query.count];
 for (id key in query) {
 [unsorted addObject:[NSString stringWithFormat:@"%@=%@", key, [query objectForKey:key]]];
 }
 NSArray *sortedArray = [unsorted
 sortedArrayUsingFunction:strCompare context:NULL];
 NSMutableString *buffer = [[NSMutableString alloc] initWithCapacity:0];
 NSEnumerator *i = [sortedArray objectEnumerator];
 id theObject;
 while (theObject = [i nextObject]) {
 [buffer appendString:theObject];
 }
 [buffer appendString:opSecretKey];
 NSString* signature = [buffer md5]; // 签名.
 
 // 将查询字典参数拼接成字符串,URL Encode,然后附带上Signature.
 [buffer deleteCharactersInRange:NSMakeRange(0, buffer.length)];
 for (id key in query) {
 NSString* value = [query objectForKey:key];
 value = [value urlEncode2:NSUTF8StringEncoding];
 [buffer appendString:[NSString stringWithFormat:@"&%@=%@", key, value]];
 }
 [buffer appendString:[NSString stringWithFormat:@"&sig=%@", signature]];
 NSString* ret = [buffer substringFromIndex:1]; // 去掉第一个'&'
 [buffer release];
 
 return ret;
 }
 */

//- (NSString*) des3:(NSString*)key encrypt:(BOOL)isEncrypt
//{
//	if (key == nil)
//		return [NSString stringWithString:self];
//
//	NSUInteger length = [self length];
//	char* buf = (char*)malloc(length);
//	bool type = isEncrypt ? ENCRYPT: DECRYPT;
//	NSData* ret = self;
//
//	if (DoDES(buf, (char*)[self bytes], length, [key UTF8String], [key length], type)) {
//		ret = [NSData dataWithBytes:buf length:length];
//	}
//
//	free(buf);
//
//	return ret;
//	return nil;
//}


// 根据人人网新鲜事日期的格式将字符串解析为NSDate
// 格式形如: 06-17 15:07
- (NSDate*) dateFromFeedFormat
{
    NSArray* se = [self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- :"]];
    if ([se count] == 4)
    {
        int month = [[se objectAtIndex:0] intValue];
        int day = [[se objectAtIndex:1] intValue];
        int hour = [[se objectAtIndex:2] intValue];
        int minute = [[se objectAtIndex:3] intValue];
        NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
        NSDate* date = [NSDate date];
        NSDateComponents* comps = [gregorian components:unitFlags fromDate:date];
        int year = [comps year];
        if (([comps month] < month) || ([comps month] == month && [comps day] < day))
            year--;
        
        NSDateComponents *comps1 = [[NSDateComponents alloc] init];
        [comps1 setYear:year];
        [comps1 setMonth:month];
        [comps1 setDay:day];
        [comps1 setHour:hour];
        [comps1 setMinute:minute];
        [comps1 setSecond:0];
        NSDate* ret = [gregorian dateFromComponents:comps1];
        return ret;
    }
    return nil;
}


// 根据人人网状态日期的格式将字符串解析为NSDate
// 格式形如: 2009-06-17 15:07:49
- (NSDate*) dateFromStatusFormat
{
    NSArray* se = [self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- :"]];
    if ([se count] == 6)
    {
        NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        
        [comps setYear:[[se objectAtIndex:0] intValue]];
        [comps setMonth:[[se objectAtIndex:1] intValue]];
        [comps setDay:[[se objectAtIndex:2] intValue]];
        [comps setHour:[[se objectAtIndex:3] intValue]];
        [comps setMinute:[[se objectAtIndex:4] intValue]];
        [comps setSecond:[[se objectAtIndex:5] intValue]];
        
        NSDate* ret = [gregorian dateFromComponents:comps];
        
        return ret;
    }
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSDate*)dateFromStringyyyyMMddHHmmss {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    
    NSDate* d = [formatter dateFromString:self];
    return d;
}

- (NSDate*)dateFromStringyyyyMMdd{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];

    NSDate* d = [formatter dateFromString:self];
    return d;
}

// 根据人人网相册日期的格式将字符串解析为NSDate
// 格式形如: 2009-06-17
- (NSDate*) dateFromAlbumFormat
{
    NSArray* se = [self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
    if ([se count] == 3)
    {
        NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        
        [comps setYear:[[se objectAtIndex:0] intValue]];
        [comps setMonth:[[se objectAtIndex:1] intValue]];
        [comps setDay:[[se objectAtIndex:2] intValue]];
        [comps setHour:0];
        [comps setMinute:0];
        [comps setSecond:0];
        
        NSDate* ret = [gregorian dateFromComponents:comps];
        return ret;
    }
    return nil;
}


// 转为base64编码
//- (NSString*) base64Encode
//{
//	static char* encodingTable = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
//	const char* pStr = [self UTF8String];
//	int l = strlen(pStr);
//
//	NSMutableData* buf;
//
//	int modulus = l % 3;
//	if (modulus == 0)
//	{
//		buf = [[NSMutableData alloc] initWithCapacity:4*l/3];
//	}
//	else
//	{
//		buf = [[NSMutableData alloc] initWithCapacity:4*((l/3)+1)];
//	}
//
//	int dataLength = (l - modulus);
//
//	char b1, b2, b3, b4;
//
//	for (int i=0; i<dataLength; i+=3)
//	{
//		int a1 = pStr[i] & 0xff;
//		int a2 = pStr[i+1] & 0xff;
//		int a3 = pStr[i+2] & 0xff;
//		b1 = encodingTable[(a1 >> 2) & 0x3f];
//		b2 = encodingTable[((a1 << 4) | (a2 >> 4)) & 0x3f];
//		b3 = encodingTable[((a2 << 2) | (a3 >> 6)) & 0x3f];
//		b4 = encodingTable[a3 & 0x3f];
//
//		[buf appendBytes:(void*)&b1 length:1];
//		[buf appendBytes:(void*)&b2 length:1];
//		[buf appendBytes:(void*)&b3 length:1];
//		[buf appendBytes:(void*)&b4 length:1];
//	}
//
//	int d1, d2;
//	switch (modulus) {
//		case 0:
//			break;
//		case 1:
//			d1 = pStr[l-1] & 0xff;
//			b1 = encodingTable[(d1 >> 2) & 0x3f];
//			b2 = encodingTable[(d2 << 4) & 0x3f];
//			b3 = '=';
//			b4 = '=';
//			[buf appendBytes:(void*)&b1 length:1];
//			[buf appendBytes:(void*)&b2 length:1];
//			[buf appendBytes:(void*)&b3 length:1];
//			[buf appendBytes:(void*)&b4 length:1];
//			break;
//		case 2:
//			d1 = pStr[l-2] & 0xff;
//			d2 = pStr[l-1] & 0xff;
//			b1 = encodingTable[(d1 >> 2) & 0x3f];
//			b2 = encodingTable[((d1 << 4) | (d2 >> 4)) & 0x3f];
//			b3 = encodingTable[(d2 << 2) & 0x3f];
//			b4 = '=';
//			[buf appendBytes:(void*)&b1 length:1];
//			[buf appendBytes:(void*)&b2 length:1];
//			[buf appendBytes:(void*)&b3 length:1];
//			[buf appendBytes:(void*)&b4 length:1];
//			break;
//	}
//
//	NSString* ret = [[[NSString alloc] initWithData:buf encoding:NSUTF8StringEncoding] autorelease];
//
//	[buf release];
//
//	return ret;
//}



// AzDG加密
//- (NSString*) AzDGCrypt:(NSString*)key
//{
//    if (self == nil || key == nil)
//        return nil;
//    
//    // 先找个随机数对原串加密
//    int rand = ((int)[NSDate timeIntervalSinceReferenceDate]) % 3200;
//    NSString* encryptKey = [[NSString stringWithFormat:@"%d", rand] md5];
//    
//    const char* pRandomKey = [encryptKey UTF8String];
//    int rKeyLength = strlen(pRandomKey);
//    
//    const char* pStr = [self UTF8String];
//    int dataLength = strlen(pStr);
//    
//    //NSMutableData* buf = [[NSMutableData alloc] initWithCapacity:2*dataLength];
//    
//    char* buf = malloc(2*dataLength);
//    
//    for (int i=0; i<dataLength; ++i)
//    {
//        char tmp1 = pRandomKey[i % rKeyLength];
//        char tmp2 = (char) (pStr[i] ^ tmp1);
//        buf[i*2] = tmp1;
//        buf[i*2+1] = tmp2;
//        //		[buf appendBytes:(void*)&tmp1 length:1];
//        //		[buf appendBytes:(void*)&tmp2 length:1];
//    }
//    
//    // 然后再用密钥key对一次加密后的串加密
//    //	NSString* text = [[[NSString alloc] initWithData:buf encoding:NSUTF8StringEncoding] autorelease];
//    
//    //	[buf release];
//    
//    const char* pEncryptKey = [[key md5] UTF8String];
//    int eKeyLength = strlen(pEncryptKey);
//    
//    //	const char* pText = [text UTF8String];
//    //	int textLength = strlen(pText);
//    int textLength = 2*dataLength;
//    
//    //	buf = [[NSMutableData alloc] initWithCapacity:textLength];
//    for (int i=0; i<textLength; ++i)
//    {
//        char c = (char) (buf[i] ^ pEncryptKey[i % eKeyLength]);
//        //		[buf appendBytes:(void*)&c length:1];
//        buf[i] = c;
//    }
//    
//    //	NSString* ret = [[[NSString alloc] initWithData:buf encoding:NSUTF8StringEncoding] autorelease];
//    NSData* ret = [NSData dataWithBytes:buf length:textLength];
//    
//    free(buf);
//    
//    return [ret base64Encode];
//}

// Trim whitespace
- (NSString *)trim {
    NSInteger len = [self length];
    if (len == 0) {
        return self;
    }
    const char *data = [self UTF8String];
    NSInteger start;
    for (start = 0; start < len && data[start] <= 32; ++start) {
        // just advance
    }
    NSInteger end;
    for (end = len - 1; end > start && data[end] <= 32; --end) {
        // just advance
    }
    return [self substringWithRange:NSMakeRange(start, end - start + 1)];
}

- (NSString *) stringTrimAsNewsfeed {
    // 去掉换行.
    NSString *content = self;
    content = [content stringByReplacingOccurrencesOfString:@"\r\n" withString:@" "];
    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
//    // 去掉空格
//    while ([content rangeOfString:@"  "].location != NSNotFound) {
//        content = [content stringByReplacingOccurrencesOfString:@"  " withString:@" "];
//    };
    content = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return content;
}

- (NSNumber*) stringToNumber
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [numberFormatter numberFromString:self];
    return number;
}

- (NSNumber *)stringToLongLongNumber{
    long long value = self.longLongValue;
    NSNumber *number = [NSNumber numberWithLongLong:value];
    return number;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)stringByFilterForStatusFromRest {
    NSString* dest = [self stringByReplacingOccurrencesOfString:@"&shy;" withString:@""];
    
    NSMutableCharacterSet* cs = [[NSMutableCharacterSet alloc] init];
    [cs addCharactersInRange:NSMakeRange(0x00ad, 1)];
    dest = [dest stringByTrimmingCharactersInSet:cs];
    return dest;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)stringByTrimmingWhitespace {
    
    NSMutableString* ms = [NSMutableString stringWithString:self];
    unichar preChar; // 前一个字符.
    unichar ch;
    int size = self.length;
    for (int i = 0; i < size;) {
        ch = [ms characterAtIndex:i];
        if (' ' == preChar && ' ' == ch) {
            [ms deleteCharactersInRange:NSMakeRange(i, 1)];
            size--;
        } else if ('\n' == ch) {
            [ms deleteCharactersInRange:NSMakeRange(i, 1)];
            size--;
        } else {
            i++;
            preChar = ch;
        }
    }
    return ms;
}

//- (NSString*) stringByDecodeAes{
//    //NSMutableString* ms = [NSMutableString stringWithString:self];
//    //NSString *tempS = @"Ifcf6Vk7ECyThur3Hfz1kQ==";
//    NSData *tempD = [self dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *temp64 = [GTMBase64 decodeData:tempD];
//    NSData *tempDataE = [temp64 AES128DecryptWithKey:@"pjyBIYZG6THGxfdQg0+mOw=="];
//    
//    NSString *res1 = [[[NSString alloc] initWithData:tempDataE encoding:NSASCIIStringEncoding] autorelease];
//    //NSLog(res1);
//    
//    return res1;
//    
//}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *) preParseER:(NSString*)string {
    if (TRUE) {
        //return string;
    }
    NSMutableString *ms = [[NSMutableString alloc] init];
    int length = string.length;
    unichar ch;
    for (int i = 0; i < length; i++) {
        ch = [string characterAtIndex:i];
        //        if ('<' == ch) {
        //            [ms appendFormat:@"&lt;", @"%@"];
        //        } else if ('>' == ch) {
        //            [ms appendFormat: @"&gt;",@"%@"];
        //        } else if ('"' == ch) {
        //            [ms appendFormat:@"&quot;", @"%@"];
        //        } else if ('&' == ch) {
        //            [ms appendFormat:@"&amp;", @"%@"];
        //        }else if('\'' == ch){
        //            [ms appendFormat:@"&apos;",@"%@"];
        //        } else {
        //            [ms appendFormat:@"%C", ch];
        //        }
        if ('<' == ch) {
            [ms appendFormat: @"%@", @"&lt;"];
        } else if ('>' == ch) {
            [ms appendFormat: @"%@", @"&gt;"];
        } else if ('"' == ch) {
            [ms appendFormat: @"%@", @"&quot;"];
        } else if ('&' == ch) {
            [ms appendFormat: @"%@", @"&amp;"];
        }else if('\'' == ch){
            [ms appendFormat:@"%@", @"&apos;"];
        } else {
            [ms appendFormat:@"%C", ch];
        }
    }
    NSString *restring = [NSString stringWithString:ms];
    return restring;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *) preParseERNotAt:(NSString*)string {
    if (TRUE) {
        //return string;
    }
    if (!string) {
        return string;
    }
    NSMutableString *ms = [NSMutableString stringWithCapacity:255];
    int length = string.length;
    unichar ch;
    for (int i = 0; i < length; i++) {
        ch = [string characterAtIndex:i];
        if ('<' == ch) {
            [ms appendFormat:@"%@",@"&lt;"];
            //            [ms appendFormat:@"&lt;", @"%@"];
        }
        else if ('>' == ch) {
            [ms appendFormat:@"%@",@"&gt;"];
            //            [ms appendFormat: @"&gt;",@"%@"];
        } else
            if ('"' == ch) {
                [ms appendFormat:@"%@",@"&quot;"];
                //                [ms appendFormat:@"&quot;", @"%@"];
            } else if ('&' == ch) {
                [ms appendFormat:@"%@",@"&amp;"];
                //                [ms appendFormat:@"&amp;", @"%@"];
            } else {
                [ms appendFormat:@"%C", ch];
            }
    }
    return [NSString stringWithString:ms];
}

+ (NSString *) afterParseER:(NSString*)string {
    if ((NSNull*)string == [NSNull null]) {
        return string;
    }
    NSString *string1 = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    NSString *string2 = [string1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    NSString *string3 = [string2 stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    NSString *string4 = [string3 stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    NSString *string5 = [string4 stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    return string5;
}


// 判断字符串是否为空
+ (BOOL)stringIsNull:(NSString *)string
{
    if (!string) {
        return YES;
    } else if ([string isEqualToString:@""] || [string isEqualToString:@"(null)"]){
        return YES;
    }
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    string = [string stringByTrimmingCharactersInSet:whitespace];
    if (string && ![string isEqualToString:@""] && ![string isEqualToString:@"(null)"]) {
        return NO;
    } else {
        return YES;
    }
}

-(NSInteger)CountWord{
    //不进行区分，英文，数字，中文，就直接用系统的计算个数
    //    int i,n=[self length],l=0,a=0,b=0;
    //    unichar c;
    //    for(i=0;i<n;i++){
    //        c=[self characterAtIndex:i];
    //        if(isblank(c)){
    //            b++;
    //        }else if(isascii(c)){
    //            a++;
    //        }else{
    //            l++;
    //        }
    //    }
    //    if(a==0 && l==0) return 0;
    //    return l+(NSInteger)ceilf((float)(a+b)/2.0);
    return [self length];
}


#pragma mark - Scale

- (void)enumerateRegexMatches:(NSString *)regex usingBlock:(void (^)(NSString *match, NSInteger index, NSRange matchRange, BOOL *stop))block {
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSArray *matches = [pattern matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    if (matches.count > 0) {
        [matches enumerateObjectsUsingBlock: ^(NSTextCheckingResult *result, NSUInteger idx, BOOL *stop) {
            block([self substringWithRange:result.range], idx, result.range, stop);
        }];
    }
}

- (NSString *)stringByAppendingNameScale:(CGFloat)scale {
    if (scale - 1 <= __FLT_EPSILON__ || self.length == 0 || [self hasSuffix:@"/"]) return self.copy;
    return [self stringByAppendingFormat:@"@%@x", @(scale)];
}

- (NSString *)stringByAppendingPathScale:(CGFloat)scale {
    if (scale - 1 <= __FLT_EPSILON__ || self.length == 0 || [self hasSuffix:@"/"]) return self.copy;
    NSString *ext = self.pathExtension;
    NSRange extRange = NSMakeRange(self.length - ext.length, 0);
    if (ext.length > 0) extRange.location -= 1;
    NSString *scaleStr = [NSString stringWithFormat:@"@%@x", @(scale)];
    return [self stringByReplacingCharactersInRange:extRange withString:scaleStr];
}

- (CGFloat)pathScale {
    if (self.length == 0 || [self hasSuffix:@"/"]) return 1;
    NSString *name = self.stringByDeletingPathExtension;
    __block CGFloat scale = 1;
    [name enumerateRegexMatches:@"@[0-9]+\\.?[0-9]*x$" usingBlock: ^(NSString *match, NSInteger index, NSRange matchRange, BOOL *stop) {
        scale = [match substringWithRange:NSMakeRange(1, match.length - 2)].doubleValue;
    }];
    return scale;
}

@end

@implementation NSMutableAttributedString (OHCommodityStyleModifiers)

-(void)setFont:(UIFont*)font {
    [self setFontName:font.fontName size:font.pointSize];
}
-(void)setFont:(UIFont*)font range:(NSRange)range {
    [self setFontName:font.fontName size:font.pointSize range:range];
}
-(void)setFontName:(NSString*)fontName size:(CGFloat)size {
    [self setFontName:fontName size:size range:NSMakeRange(0,[self length])];
}
-(void)setFontName:(NSString*)fontName size:(CGFloat)size range:(NSRange)range {
    // kCTFontAttributeName
    CTFontRef aFont = CTFontCreateWithName((CFStringRef)fontName, size, NULL);
    if (!aFont) return;
    [self removeAttribute:(NSString*)kCTFontAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:(NSString*)kCTFontAttributeName value:(__bridge id)aFont range:range];
    CFRelease(aFont);
}
-(void)setFontFamily:(NSString*)fontFamily size:(CGFloat)size bold:(BOOL)isBold italic:(BOOL)isItalic range:(NSRange)range {
    // kCTFontFamilyNameAttribute + kCTFontTraitsAttribute
    CTFontSymbolicTraits symTrait = (isBold?kCTFontBoldTrait:0) | (isItalic?kCTFontItalicTrait:0);
    NSDictionary* trait = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:symTrait] forKey:(NSString*)kCTFontSymbolicTrait];
    NSDictionary* attr = [NSDictionary dictionaryWithObjectsAndKeys:
                          fontFamily,kCTFontFamilyNameAttribute,
                          trait,kCTFontTraitsAttribute,nil];
    
    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((CFDictionaryRef)attr);
    if (!desc) return;
    CTFontRef aFont = CTFontCreateWithFontDescriptor(desc, size, NULL);
    CFRelease(desc);
    if (!aFont) return;
    
    [self removeAttribute:(NSString*)kCTFontAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:(NSString*)kCTFontAttributeName value:(__bridge id)aFont range:range];
    CFRelease(aFont);
}

-(void)setTextColor:(UIColor*)color {
    [self setTextColor:color range:NSMakeRange(0,[self length])];
}
-(void)setTextColor:(UIColor*)color range:(NSRange)range {
    // kCTForegroundColorAttributeName
    [self removeAttribute:(NSString*)kCTForegroundColorAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)color.CGColor range:range];
}

-(void)setTextIsUnderlined:(BOOL)underlined {
    [self setTextIsUnderlined:underlined range:NSMakeRange(0,[self length])];
}
-(void)setTextIsUnderlined:(BOOL)underlined range:(NSRange)range {
    int32_t style = underlined ? (kCTUnderlineStyleSingle|kCTUnderlinePatternSolid) : kCTUnderlineStyleNone;
    [self setTextUnderlineStyle:style range:range];
}
-(void)setTextUnderlineStyle:(int32_t)style range:(NSRange)range {
    [self removeAttribute:(NSString*)kCTUnderlineStyleAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:(NSString*)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:style] range:range];
}

-(void)setTextBold:(BOOL)isBold range:(NSRange)range {
    NSUInteger startPoint = range.location;
    NSRange effectiveRange;
    do {
        // Get font at startPoint
        CTFontRef currentFont = (__bridge CTFontRef)[self attribute:(NSString*)kCTFontAttributeName atIndex:startPoint effectiveRange:&effectiveRange];
        // The range for which this font is effective
        NSRange fontRange = NSIntersectionRange(range, effectiveRange);
        // Create bold/unbold font variant for this font and apply
        CTFontRef newFont = CTFontCreateCopyWithSymbolicTraits(currentFont, 0.0, NULL, (isBold?kCTFontBoldTrait:0), kCTFontBoldTrait);
        if (newFont) {
            [self removeAttribute:(NSString*)kCTFontAttributeName range:fontRange]; // Work around for Apple leak
            [self addAttribute:(NSString*)kCTFontAttributeName value:(__bridge id)newFont range:fontRange];
            CFRelease(newFont);
        } else {
//            NSString* fontName = [(NSString*)CTFontCopyFullName(currentFont) autorelease];
        }
        ////[self removeAttribute:(NSString*)kCTFontWeightTrait range:fontRange]; // Work around for Apple leak
        ////[self addAttribute:(NSString*)kCTFontWeightTrait value:(id)[NSNumber numberWithInt:1.0f] range:fontRange];
        
        // If the fontRange was not covering the whole range, continue with next run
        startPoint = NSMaxRange(effectiveRange);
    } while(startPoint<NSMaxRange(range));
}

-(void)setTextAlignment:(CTTextAlignment)alignment lineBreakMode:(CTLineBreakMode)lineBreakMode {
    [self setTextAlignment:alignment lineBreakMode:lineBreakMode range:NSMakeRange(0,[self length])];
}
-(void)setTextAlignment:(CTTextAlignment)alignment lineBreakMode:(CTLineBreakMode)lineBreakMode range:(NSRange)range {
    // kCTParagraphStyleAttributeName > kCTParagraphStyleSpecifierAlignment
    CTParagraphStyleSetting paraStyles[2] = {
        {.spec = kCTParagraphStyleSpecifierAlignment, .valueSize = sizeof(CTTextAlignment), .value = (const void*)&alignment},
        {.spec = kCTParagraphStyleSpecifierLineBreakMode, .valueSize = sizeof(CTLineBreakMode), .value = (const void*)&lineBreakMode},
    };
    CTParagraphStyleRef aStyle = CTParagraphStyleCreate(paraStyles, 2);
    [self removeAttribute:(NSString*)kCTParagraphStyleAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:(NSString*)kCTParagraphStyleAttributeName value:(__bridge id)aStyle range:range];
    CFRelease(aStyle);
}

@end

@implementation NSAttributedString (OHCommodityConstructors)
+(id)attributedStringWithString:(NSString*)string {
    return string ? [[self alloc] initWithString:string] : nil;
}
+(id)attributedStringWithAttributedString:(NSAttributedString*)attrStr {
    return attrStr ? [[self alloc] initWithAttributedString:attrStr] : nil;
}

-(CGSize)sizeConstrainedToSize:(CGSize)maxSize {
    return [self sizeConstrainedToSize:maxSize fitRange:NULL];
}
-(CGSize)sizeConstrainedToSize:(CGSize)maxSize fitRange:(NSRange*)fitRange {
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);
    CFRange fitCFRange = CFRangeMake(0,0);
    CGSize sz = CTFramesetterSuggestFrameSizeWithConstraints(framesetter,CFRangeMake(0,0),NULL,maxSize,&fitCFRange);
    if (framesetter) CFRelease(framesetter);
    if (fitRange) *fitRange = NSMakeRange(fitCFRange.location, fitCFRange.length);
    return CGSizeMake( floorf(sz.width+1) , floorf(sz.height+1) ); // take 1pt of margin for security
}
@end
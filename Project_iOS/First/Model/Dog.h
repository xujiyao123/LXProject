//
//  Dog.h
//  Project_iOS
//
//  Created by 刘旭 on 15/12/24.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import <Realm/Realm.h>

@class Person;

@interface Dog : RLMObject
@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) Person *owner;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Dog>
RLM_ARRAY_TYPE(Dog)

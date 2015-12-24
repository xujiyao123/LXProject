//
//  Person.h
//  Project_iOS
//
//  Created by 刘旭 on 15/12/24.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import <Realm/Realm.h>
#import "Dog.h"

@interface Person : RLMObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) NSDate *birthdate;
@property(nonatomic, strong) RLMArray<Dog *><Dog> *dogs;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Person>
RLM_ARRAY_TYPE(Person)

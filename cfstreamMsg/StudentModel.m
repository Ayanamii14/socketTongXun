//
//  StudentModel.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/18.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import "StudentModel.h"
#import <objc/runtime.h>

@implementation StudentModel

//字典转模型
+ (instancetype)yj_initWithDictionary:(NSDictionary *)dic
{
    id myObj = [[self alloc] init];
    
    unsigned int outCount;
    
    //获取类中的所有成员属性
    objc_property_t *arrPropertys = class_copyPropertyList([self class], &outCount);
    
    for (NSInteger i = 0; i < outCount; i ++) {
        objc_property_t property = arrPropertys[i];
        
        //获取属性名字符串
        //model中的属性名
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        id propertyValue = dic[propertyName];
        
        if (propertyValue != nil) {
            [myObj setValue:propertyValue forKey:propertyName];
        }
    }
    
    free(arrPropertys);
    
    return myObj;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.isLogin = [aDecoder decodeBoolForKey:@"isLogin"];
        self.isLogout = [aDecoder decodeBoolForKey:@"isLogout"];
        self.age = [aDecoder decodeObjectForKey:@"age"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.studentID = [aDecoder decodeObjectForKey:@"studentID"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:self.isLogin forKey:@"isLogin"];
    [aCoder encodeBool:self.isLogout forKey:@"isLogout"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.studentID forKey:@"studentID"];
    [aCoder encodeObject:self.age forKey:@"age"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
}

@end

//
//  StudentModel.h
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/18.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *studentID;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *gender;

+ (instancetype)yj_initWithDictionary:(NSDictionary *)dic;

@end

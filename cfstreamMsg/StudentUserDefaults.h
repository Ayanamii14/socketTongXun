//
//  StudentUserDefaults.h
//  cfstreamMsg
//
//  Created by lyhao on 2017/10/19.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudentModel.h"

@interface StudentUserDefaults : NSObject

+ (instancetype)sharedInstance;

- (void)saveStudent:(StudentModel *)student;
- (StudentModel *)student;
- (BOOL)isLogin;

@end

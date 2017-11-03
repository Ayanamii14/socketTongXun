//
//  StudentUserDefaults.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/10/19.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import "StudentUserDefaults.h"


@interface StudentUserDefaults ()

@property (strong, nonatomic) NSUserDefaults *userDefaults;

@end

@implementation StudentUserDefaults

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static StudentUserDefaults *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[StudentUserDefaults alloc] init];
    });
    return instance;
}

- (void)saveStudent:(StudentModel *)student {
    [self.userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:student] forKey:@"student"];
    [self.userDefaults synchronize];
}

- (StudentModel *)student {
    return [NSKeyedUnarchiver unarchiveObjectWithData:[self.userDefaults objectForKey:@"student"]];
}

- (BOOL)isLogin {
    BOOL status = NO;
    StudentModel *student = [self student];
    if (student != nil) {
        if (student.isLogin) {
            status = YES;
        }
    }
    return status;
}

#pragma mark - lazy
- (NSUserDefaults *)userDefaults {
    if (!_userDefaults) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}

@end

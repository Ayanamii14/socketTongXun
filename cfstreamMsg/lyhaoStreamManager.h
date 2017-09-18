//
//  lyhaoStreamManager.h
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/18.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lyhaoStreamManager : NSObject

+ (instancetype)shareInstance;
- (void)sendMsg:(NSString *)msg;

@end

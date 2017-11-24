//
//  LyhaoTools.h
//  cfstreamMsg
//
//  Created by lyhao on 2017/11/14.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LyhaoTools : NSObject

- (NSString *)dictionaryToJsonString:(NSDictionary *)dictionary;
- (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString;

- (NSArray *)atStringToArray:(NSString *)atString;
+ (NSString *)ctos:(char *)s length:(int)l;

@end

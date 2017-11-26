//
//  LyhaoTools.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/11/14.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import "LyhaoTools.h"

@implementation LyhaoTools

/**
 字典转json
 
 @param dictionary 字典
 @return json字符串
 */
- (NSString *)dictionaryToJsonString:(NSDictionary *)dictionary {
    if (dictionary == nil || dictionary.count == 0) {
        return nil;
    }
    NSError *error;
    NSData *data=[NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return jsonStr;
}

/**
 json 转 字典
 
 @param jsonString json字符串
 @return 字典
 */
- (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) {
//        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return dic;
}

- (NSArray *)atStringToArray:(NSString *)atString {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    if (atString) {
        NSArray *arr = [atString componentsSeparatedByString:@"#"];
        for (int i = 0;i < arr.count;i ++) {
            NSMutableArray *tempArr = [NSMutableArray array];
            [tempArr addObjectsFromArray:[arr[i] componentsSeparatedByString:@"@"]];
            [tempArr removeObjectAtIndex:0];
            if (tempArr.count != 0) {
                [result addObject:tempArr];
            }
        }
    }
    return result;
}

+ (NSString *)ctos:(char *)s length:(int)l{
    NSString *cts = @"";
    BOOL beginsort = NO;
    for (int i = 0;i < l;i ++) {
        if (s[i] == '\0') {
            if (s[i + 1] == '\0') {
                //已经有连续两个'\0'了，代表整个数组结束了（也不会说连续几个'\0'后，再接数据了的吧，那岂不是睿智的很）
                beginsort = NO;
                break;
            }
            else {
                beginsort = YES;
            }
        }
        if (beginsort) {
            s[i] = s[i + 1];
            if(s[i + 1] == '\0') {
                break;
            }
        }
    }
    cts = [NSString stringWithFormat:@"%s", s];
    return cts;
}

@end

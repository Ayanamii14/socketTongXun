//
//  lyhaoStreamManager.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/18.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import "lyhaoStreamManager.h"

@interface lyhaoStreamManager()<NSStreamDelegate>
{
    NSInputStream *_inputStream;
    NSOutputStream *_outputStream;
}



@end

@implementation lyhaoStreamManager

+ (instancetype)shareInstance {
    static lyhaoStreamManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        [manager initNetworkCommucation];
    });
    return manager;
}

- (void)initNetworkCommucation {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    //分配输入输出流的内存空间
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"127.0.0.1", 6666, &readStream, &writeStream);
    //把C语言的输入输出流转成OC对象
    _inputStream = (__bridge_transfer NSInputStream *)readStream;
    _outputStream = (__bridge_transfer NSOutputStream *)writeStream;
    
    [_inputStream setDelegate:self];
    [_outputStream setDelegate:self];
    
    //把输入输入流添加到主运行循环(RunLoop)
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [_inputStream open];
    [_outputStream open];
}

- (void)sendMsg:(NSString *)msg {
    //按照NSData *data的形式，传递NSData数据，注意这里传递的数据的长度也是[data length]+1
    //传递的数据类型是[data bytes]
    //这里将字符串转化为 nsdata
    NSData *data = [[NSData alloc] initWithData:[msg dataUsingEncoding:NSUTF8StringEncoding]];
    [_outputStream write:[data bytes] maxLength:[data length]+1];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    NSString *event;
    switch (eventCode) {
        case NSStreamEventNone:
            event = @"无事";
            break;
        case NSStreamEventOpenCompleted:
            event = @"成功连接建立，形成输入输出流的传输通道";
            break;
        case NSStreamEventHasBytesAvailable:
            event = @"有数据可读";
            if (aStream == _inputStream) {
                NSMutableData *input = [[NSMutableData alloc] init];
                uint8_t buffer[1024000];
                long len;
                //是否数据可读。如果可读那么执行循环读取。
                while([_inputStream hasBytesAvailable]) {
                    len = [_inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len >0) {
                        //如果数据有效，那么将数据追加到input中。
                        [input appendBytes:buffer length:len];
                    }
                }
                NSLog(@"input length = %ld",[input length]);
                //将Data进行解码转化为字符串。
                NSString *resultstring = [[NSString alloc] initWithData:input encoding:NSUTF8StringEncoding];
                NSLog(@"接收:%@",resultstring);
            }
            break;
        case NSStreamEventHasSpaceAvailable:
            event = @"可以发送数据";
            break;
        case NSStreamEventErrorOccurred:
            event = @"有错误发生，连接失败";
            [self streamClose];
            break;
        case NSStreamEventEndEncountered:
            event = @"流结束,正常的断开连接";
            NSLog(@"Error:%ld:%@",[[aStream streamError] code], [[aStream streamError] localizedDescription]);
            break;
        default:
            [self streamClose];
            event = @"未知错误";
            break;
    }
    NSLog(@"event---%@",event);
}

- (void)streamClose {
    [_inputStream close];
    [_outputStream close];
    [_inputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

@end

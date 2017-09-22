//
//  lyhaoSocketManager.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/18.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import "lyhaoSocketManager.h"
#import <sys/types.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

static const char *server_ip = "127.0.0.1";
static short server_port = 7777;

@interface lyhaoSocketManager(){
    BOOL _isSucc;
    NSString *_cMsg;
}
@property (assign, nonatomic) int clientSocket;

@end

@implementation lyhaoSocketManager

+ (instancetype)shareInstance {
    static lyhaoSocketManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        [manager initWithSocket];
        [manager pullMsg];
    });
    return manager;
}

- (void)connectAndPull {
    [self initWithSocket];
    [self pullMsg];
}

- (void)initWithSocket {
    if (_clientSocket != 0) {
        [self disConnect];
        _clientSocket = 0;
    }
    
    //创建socket
    _clientSocket = CreateClinetSocket();
    if (ConnectionToServer(_clientSocket, server_ip, server_port) == 0) {
        NSLog(@"conncet to server error!!!");
        _isSucc = NO;
        return;
    }
    
    NSLog(@"connect to server success!!!");
    _isSucc = YES;
}

- (void)pullMsg {
    if (_isSucc) {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(recieveAction) object:nil];
        [thread start];
    }
}

- (void)connect {
    [self initWithSocket];
}

- (void)disConnect {
    close(_clientSocket);
}

- (void)sendMsg:(NSString *)msg {
    const char *send_Msg = [msg UTF8String];
    send(_clientSocket, send_Msg, strlen(send_Msg) + 1, 0);
}

//收取服务端发送的消息
- (void)recieveAction{
    while (1) {
        char recv_Msg[1024] = {0};
        recv(_clientSocket, recv_Msg, sizeof(recv_Msg), 0);
        NSString *s = [NSString stringWithFormat:@"%s",recv_Msg];
        if ([self jsonStringToDictionary:s]) {
            NSMutableArray *ma = [NSMutableArray arrayWithArray:[[self jsonStringToDictionary:s] objectForKey:@"data"]];
            if (_delegate && [_delegate respondsToSelector:@selector(recvMsg:)]) {
                [_delegate recvMsg:ma];
            }
        }
        else {
            continue;
        }
    }
}

static int CreateClinetSocket() {
    int ClientSocket = 0;
    /*
     第一个参数addressFamily IPv4(AF_INET) 或 IPv6(AF_INET6);
     第二个参数 type 表示 socket 的类型，通常是流stream(SOCK_STREAM) 或数据报文datagram(SOCK_DGRAM);
     第三个参数 protocol 参数通常设置为0，以便让系统自动为选择我们合适的协议。
     对于 stream socket 来说会是 TCP 协议(IPPROTO_TCP)，而对于 datagram来说会是 UDP 协议(IPPROTO_UDP)。
     */
    ClientSocket = socket(AF_INET, SOCK_STREAM, 0);
    return ClientSocket;
}

static int ConnectionToServer(int clientSocket, const char *serverIP, unsigned short serverPort) {
    struct sockaddr_in socketAddr = {0};
    socketAddr.sin_len = sizeof(socketAddr);
    socketAddr.sin_family = AF_INET;
    //inet_aton是一个改进的方法来将一个字符串IP地址转换为一个32位的网络序列IP地址
    //如果这个函数成功，函数的返回值非零，如果输入地址不正确则会返回零。
    inet_aton(serverIP, &socketAddr.sin_addr);
    
    //htons是将整型变量从主机字节顺序转变成网络字节顺序，赋值端口号
    socketAddr.sin_port = htons(serverPort);
    
    //用scoket和服务端地址，发起连接。
    //客户端向特定网络地址的服务器发送连接请求，连接成功返回0，失败返回 -1。
    //注意：该接口调用会阻塞当前线程，直到服务器返回。
    if (connect(clientSocket, (struct sockaddr *)&socketAddr, sizeof(socketAddr)) == 0) {
        return clientSocket;
    }
    return 0;
}

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

- (NSString *)arrayToJsonString:(NSArray *)array {
    if (array == nil || array.count == 0) {
        return nil;
    }
    NSError *error;
    NSData *data=[NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return jsonStr;
}

- (void)dealloc {
    
}

@end

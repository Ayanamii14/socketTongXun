//
//  ViewController.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/15.
//  Copyright © 2017年 lyhao. All rights reserved.
// 

#import "ViewController.h"
#import "lyhaoSocketManager.h"
#import "lyhaoStreamManager.h"

@interface ViewController ()<NSStreamDelegate>
{
    NSInputStream *_inputStream;
    NSOutputStream *_outputStream;
}
@property (weak, nonatomic) IBOutlet UILabel *revMsgLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [lyhaoSocketManager shareInstance];
//    [lyhaoStreamManager shareInstance];
}

- (IBAction)sendMsgAction:(UIButton *)sender {
    [[lyhaoSocketManager shareInstance] sendMsg:@"SELECT * FROM studentListTable"];
//    [[lyhaoStreamManager shareInstance] sendMsg:self.inputTextField.text];
}

@end

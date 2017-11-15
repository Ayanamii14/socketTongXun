//
//  StudentLoginRegisterViewController.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/10/19.
//  Copyright © 2017年 lyhao. All rights reserved.
//
/*
     从未登录过，注册，发消息告诉服务器注册，返回注册信息（注册成功，用户名，密码，端口），保存在本地。
     登陆过，读取本地信息，登录，发消息告诉服务器，返回登录信息（登陆成功，用户名，密码，端口），更新本地信息
 */

#import "StudentLoginRegisterViewController.h"
#import "StudentModel.h"
#import "StudentUserDefaults.h"
#import "StudentListViewController.h"

@interface StudentLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *headView;

@end

@implementation StudentLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",NSHomeDirectory());
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(UIButton *)sender {
    StudentModel *s = [[StudentModel alloc] init];
    s.isLogout = NO;
    s.isLogin = YES;
    s.name = @"1";
    s.studentID = @"1";
    s.age = @"1";
    s.gender = @"1";
    [[StudentUserDefaults sharedInstance] saveStudent:s];
    if (self.f) {
        self.f();
    }
}

@end

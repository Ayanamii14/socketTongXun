//
//  AddViewController.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/19.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import "AddViewController.h"
#import "lyhaoSocketManager.h"

@interface AddViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *studentIDTextField;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
}

- (void)initData {
    //添加student sql语句
    [[lyhaoSocketManager shareInstance] sendMsg:@""];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addAction:(UIButton *)sender {
    
}

@end

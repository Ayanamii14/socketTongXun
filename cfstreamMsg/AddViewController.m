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
    if (self.nameTextField.text == nil || [self.nameTextField.text isEqualToString:@""]) {
        [self alertWithMsg:@"姓名不能为空"];
    }
    else if (self.genderTextField.text == nil || [self.genderTextField.text isEqualToString:@""]) {
        [self alertWithMsg:@"性别不能为空"];
    }
    else if (self.ageTextField.text == nil || [self.ageTextField.text isEqualToString:@""]) {
        [self alertWithMsg:@"年龄不能为空"];
    }
    else if (self.studentIDTextField.text == nil || [self.studentIDTextField.text isEqualToString:@""]) {
        [self alertWithMsg:@"学号不能为空"];
    }
    else {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO tableName VALUES('%@','%@','%@','%@')", self.nameTextField.text, self.genderTextField.text, self.ageTextField.text, self.studentIDTextField.text];
        [[lyhaoSocketManager shareInstance] sendMsg:sql];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addAction:(UIButton *)sender {
    
}

- (void)alertWithMsg:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *queding = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:queding];
    [self presentViewController:alert animated:YES completion:nil];
}

@end

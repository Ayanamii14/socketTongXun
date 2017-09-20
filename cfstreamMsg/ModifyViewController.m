//
//  ModifyViewController.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/19.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import "ModifyViewController.h"
#import "lyhaoSocketManager.h"

@interface ModifyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UILabel *studentIDLabel;
@property (weak, nonatomic) IBOutlet UITextField *studentIDTextField;

@end

@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
}

- (void)initData {
    self.nameLabel.text = self.name;
    self.genderLabel.text = self.gender;
    self.ageLabel.text = self.age;
    self.studentIDLabel.text = self.studentID;
}

- (IBAction)modifyAction:(UIButton *)sender {
    //修改student sql语句
    if (self.nameTextField.text == nil || [self.nameTextField.text isEqualToString:@""]) {
        
    }
    [[lyhaoSocketManager shareInstance] sendMsg:@"UPDATE student SET "];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

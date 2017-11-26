//
//  ModifyViewController.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/19.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import "ModifyViewController.h"
#import "lyhaoSocketManager.h"

@interface ModifyViewController ()<UITextFieldDelegate> {
    CGRect _namerect;
    CGRect _genderrect;
    CGRect _agerect;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UILabel *studentIDLabel;
@property (weak, nonatomic) IBOutlet UIView *idView;
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *genderView;
@property (weak, nonatomic) IBOutlet UIView *ageView;
@end

@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTextField.delegate = self;
    self.nameTextField.tag = 1001;
    self.genderTextField.delegate = self;
    self.genderTextField.tag = 1002;
    self.ageTextField.delegate = self;
    self.ageTextField.tag = 1003;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(modifyAction:)];
    self.navigationItem.rightBarButtonItem = right;
    
    [self initData];
}

- (void)initData {
    self.nameLabel.text = [NSString stringWithFormat:@"姓名: %@", self.sname];
    self.genderLabel.text = [NSString stringWithFormat:@"性别: %@", self.sgender];
    self.ageLabel.text = [NSString stringWithFormat:@"年龄: %@", self.sage];
    self.studentIDLabel.text = [NSString stringWithFormat:@"学号: %@", self.sid];
}

- (void)modifyAction:(UIButton *)sender {
    //修改student sql语句
    NSString *name;
    NSString *gender;
    NSString *age;
    NSString *studentID = self.sid;
    
    //默认值
    (self.nameTextField.text == nil || [self.nameTextField.text isEqualToString:@""]) ? (name = self.sname) : (name = self.nameTextField.text);
    (self.genderTextField.text == nil || [self.genderTextField.text isEqualToString:@""]) ? (gender = self.sgender) : (gender = self.genderTextField.text);
    (self.ageTextField.text == nil || [self.ageTextField.text isEqualToString:@""]) ? (age = self.sage) : (age = self.ageTextField.text);
    
    NSString *sql = [NSString stringWithFormat:@"@update@%@@%@@%@@%@#",studentID,name,gender,age];
    [[lyhaoSocketManager shareInstance] sendMsg:sql];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 1001:
            _namerect = self.nameLabel.frame;
            self.nameLabel.frame = CGRectMake(15, 0, self.nameLabel.frame.size.width, self.nameLabel.frame.size.height);
            break;
        case 1002:
            _genderrect = self.genderLabel.frame;
            self.genderLabel.frame = CGRectMake(15, 0, self.genderLabel.frame.size.width, self.genderLabel.frame.size.height);
            break;
        case 1003:
            _agerect = self.ageLabel.frame;
            self.ageLabel.frame = CGRectMake(15, 0, self.ageLabel.frame.size.width, self.ageLabel.frame.size.height);
            break;
        default:
            break;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 1001:
            if (self.nameTextField.text == nil || [self.nameTextField.text isEqualToString:@""]) {
                self.nameLabel.frame = _namerect;
            }
            break;
        case 1002:
            if (self.genderTextField.text == nil || [self.genderTextField.text isEqualToString:@""]) {
                self.genderLabel.frame = _genderrect;
            }
            break;
        case 1003:
            if (self.ageTextField.text == nil || [self.ageTextField.text isEqualToString:@""]) {
                self.ageLabel.frame = _agerect;
            }
            break;
        default:
            break;
    }
}


@end

//
//  AddViewController.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/19.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import "AddViewController.h"
#import "lyhaoSocketManager.h"

static const NSInteger up = 30;

@interface AddViewController ()<UITextFieldDelegate> {
    BOOL _isMove;
}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *studentIDTextField;

@end

@implementation AddViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isMove = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addAction:(UIButton *)sender {
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
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO `studentListTable`(`name`, `gender`, `age`, `studentID`) VALUES (%@,%@,%@,%@)", self.nameTextField.text, self.genderTextField.text, self.ageTextField.text, self.studentIDTextField.text];
        NSLog(@"%@",sql);
        [[lyhaoSocketManager shareInstance] sendMsg:sql];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)alertWithMsg:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *queding = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:queding];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
//    if (_isMove) {
//        [UIView animateWithDuration:0.3 animations:^{
//            CGPoint p = self.view.center;
//            p.y += up;
//            self.view.center = p;
//        }];
//        _isMove = NO;
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
//    [UIView animateWithDuration:0.3 animations:^{
//        CGPoint p = self.view.center;
//        p.y += up;
//        self.view.center = p;
//    }];
//    _isMove = NO;
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    if (!_isMove) {
//        [UIView animateWithDuration:0.3 animations:^{
//            CGPoint p = self.view.center;
//            p.y -= up;
//            self.view.center = p;
//        }];
//        _isMove = YES;
//    }
//    NSLog(@"====%f", textField.frame.origin.y);
    return YES;
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
//    NSDictionary *userInfo = [aNotification userInfo];
//    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    int height = [aValue CGRectValue].size.height;
//    NSLog(@"----%d", height);
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
    
}

@end

//
//  ModifyViewController.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/19.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import "ModifyViewController.h"
#import "lyhaoSocketManager.h"
#import "ModifyTableViewCell.h"

static NSString *kModifyTableViewCellID = @"kModifyTableViewCellID";

@interface ModifyViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.tableView.rowHeight = 60;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UIAccessibilityTraitNone;
}

- (IBAction)modifyAction:(UIButton *)sender {
    //修改student sql语句
    NSString *name;
    NSString *gender;
    NSString *age;
    NSString *studentID;
    
//    (self.nameTextField.text == nil || [self.nameTextField.text isEqualToString:@""]) ? (name = self.name) : (name = self.nameTextField.text);
//    (self.genderTextField.text == nil || [self.genderTextField.text isEqualToString:@""]) ? (gender = self.gender) : (gender = self.genderTextField.text);
//    (self.ageTextField.text == nil || [self.ageTextField.text isEqualToString:@""]) ? (name = self.age) : (name = self.ageTextField.text);
//    (self.studentIDTextField.text == nil || [self.studentIDTextField.text isEqualToString:@""]) ? (name = self.name) : (name = self.studentIDTextField.text);
    
    NSString *sql = [NSString stringWithFormat:@"@update@%@@%@@%@@%@#",studentID,name,gender,age];
    [[lyhaoSocketManager shareInstance] sendMsg:sql];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ModifyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kModifyTableViewCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ModifyTableViewCell" owner:nil options:nil] firstObject];
    }
    
    [cell refreshViewWithData:self.dataArr withIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.row);
}

#pragma mark -touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end

//
//  StudentListViewController.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/18.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import "StudentListViewController.h"
#import "StudentDetailTableViewCell.h"
#import "ModifyViewController.h"
#import "AddViewController.h"
#import "lyhaoSocketManager.h"
#import "LyhaoTools.h"

static NSString *kStudentDetailTableViewCellID = @"kStudentDetailTableViewCellID";

@interface StudentListViewController ()<UITableViewDelegate, UITableViewDataSource,lyhaoSocketManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (strong, nonatomic) LyhaoTools *lyhaotools;

@end

@implementation StudentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[lyhaoSocketManager shareInstance] setDelegate:self];
    if ([[lyhaoSocketManager shareInstance] initWithSocket]) {
        [[lyhaoSocketManager shareInstance] pullMsg];
        [[lyhaoSocketManager shareInstance] sendMsg:@"@getall"];
    }
    [self initUI];
}

/**
 初始化UI
 */
- (void)initUI {
    self.title = @"Student List";
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem = right;
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(leftAction:)];
    self.navigationItem.leftBarButtonItem = left;
    
    self.tableView.rowHeight = 77;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)rightAction:(UIBarButtonItem *)sender {
    AddViewController *addVC = [[AddViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)leftAction:(UIBarButtonItem *)sender {
    [self.dataArr removeAllObjects];
    if ([[lyhaoSocketManager shareInstance] initWithSocket]) {
        [[lyhaoSocketManager shareInstance] pullMsg];
        [[lyhaoSocketManager shareInstance] sendMsg:@"@getall"];
    }
    [self.tableView reloadData];
}

#pragma mark - lyhaoSocketManagerDelegate
/**
 lyhaoSocketManager的代理方法，接收返回的消息

 @param msg 消息
 */
- (void)recvMsg:(NSString *)msg {
    /*
     0 : ID
     1 : NAME
     2 : SEX
     3 : AGE
     */
    NSArray *arr = [self.lyhaotools atStringToArray:msg];
    if (arr != nil || arr.count != 0) {
        self.dataArr = [NSMutableArray arrayWithArray:arr];
    }
    //回主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)socketAlertMsg:(NSString *)msg {
    [self alertWithMsgAndRefresh:msg];
}

#pragma mark - tableview datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StudentDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStudentDetailTableViewCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StudentDetailTableViewCell" owner:nil options:nil] firstObject];
    }
//    [cell refreshViewWithData:[StudentModel yj_initWithDictionary:self.dataArr[indexPath.row]]];
    [cell refreshViewWithArray:self.dataArr[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

//可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSString *sql = [NSString stringWithFormat:@"@delete@%@@%@@%@@%@#", self.dataArr[indexPath.row][0], self.dataArr[indexPath.row][1], self.dataArr[indexPath.row][2], self.dataArr[indexPath.row][3]];
        [[lyhaoSocketManager shareInstance] sendMsg:sql];
        [self.tableView reloadData];
    }];
    UITableViewRowAction *modifyAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        ModifyViewController *modifyVC = [[ModifyViewController alloc] init];
        modifyVC.dataArr = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:modifyVC animated:YES];
    }];
    
    return @[deleteAction, modifyAction];
}

- (void)alertWithMsg:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *queding = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:queding];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alertWithMsgAndRefresh:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *refresh = [UIAlertAction actionWithTitle:@"重连" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[lyhaoSocketManager shareInstance] initWithSocket]) {
            [[lyhaoSocketManager shareInstance] pullMsg];
            [[lyhaoSocketManager shareInstance] sendMsg:@"@getall"];
        }
    }];
    [alert addAction:refresh];
    [self presentViewController:alert animated:YES completion:nil];
}

- (LyhaoTools *)lyhaotools {
    if (!_lyhaotools) {
        _lyhaotools = [[LyhaoTools alloc] init];
    }
    return _lyhaotools;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

@end

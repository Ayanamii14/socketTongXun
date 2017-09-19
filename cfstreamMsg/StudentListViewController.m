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
#import "YYModel.h"

static NSString *kStudentDetailTableViewCellID = @"kStudentDetailTableViewCellID";

@interface StudentListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation StudentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@{
                                                            @"name":@"张三",
                                                            @"gender":@"1",
                                                            @"age":@"23",
                                                            @"studentID":@"217388439121",
                                                            },@{
                                                                @"name":@"李四",
                                                                @"gender":@"1",
                                                                @"age":@"20",
                                                                @"studentID":@"217386557671",
                                                                },@{
                                                                    @"name":@"王五",
                                                                    @"gender":@"1",
                                                                    @"age":@"22",
                                                                    @"studentID":@"217388873121",
                                                                    },@{
                                                                        @"name":@"赵六",
                                                                        @"gender":@"0",
                                                                        @"age":@"21",
                                                                        @"studentID":@"217388643321",
                                                                        }, nil];
    [self initUI];
}

- (void)initUI {
    self.title = @"Student List";
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem = right;
    
    self.tableView.rowHeight = 77;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)rightAction:(UIBarButtonItem *)sender {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StudentDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStudentDetailTableViewCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StudentDetailTableViewCell" owner:nil options:nil] firstObject];
    }

//    [cell refreshViewWithData:[StudentModel yj_initWithDictionary:self.dataArr[indexPath.row]]];
    [cell refreshViewWithData:[StudentModel yy_modelWithDictionary:self.dataArr[indexPath.row]]];
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
        NSLog(@"删除");
    }];
    UITableViewRowAction *modifyAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        ModifyViewController *modifyVC = [[ModifyViewController alloc] init];
        [self.navigationController pushViewController:modifyVC animated:YES];
    }];
    
    return @[deleteAction, modifyAction];
}

@end

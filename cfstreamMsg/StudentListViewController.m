//
//  StudentListViewController.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/18.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import "StudentListViewController.h"
#import "StudentDetailTableViewCell.h"
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
    self.tableView.rowHeight = 77;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StudentDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStudentDetailTableViewCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StudentDetailTableViewCell" owner:nil options:nil] firstObject];
    }
    
    [cell refreshViewWithData:[StudentModel yy_modelWithDictionary:self.dataArr[indexPath.row]]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

@end

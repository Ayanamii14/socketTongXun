//
//  StudentDetailTableViewCell.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/18.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import "StudentDetailTableViewCell.h"

@interface StudentDetailTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentIDLabel;

@end

@implementation StudentDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshViewWithData:(StudentModel *)studentModel {
    self.nameLabel.text = studentModel.name;
    if ([studentModel.gender intValue] == 1) {
        self.genderLabel.text = @"♂";
    }
    else {
        self.genderLabel.text = @"♀";
    }
    self.ageLabel.text = [NSString stringWithFormat:@"%@岁",studentModel.age];
    self.studentIDLabel.text = studentModel.studentID;
}

@end

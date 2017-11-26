//
//  ModifyTableViewCell.m
//  cfstreamMsg
//
//  Created by LiuYuHao on 2017/11/26.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import "ModifyTableViewCell.h"

@interface ModifyTableViewCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nTextField;
@property (weak, nonatomic) IBOutlet UILabel *nLabel;

@end

@implementation ModifyTableViewCell

- (void)refreshViewWithData:(NSArray *)arr withIndexPath:(NSIndexPath *)indexPath{
    self.nTextField.delegate = self;
    self.nLabel.text = arr[indexPath.row];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGPoint newCenter = self.nLabel.center;
    [UIView animateWithDuration:0.5 animations:^{
        self.nLabel.center = CGPointMake(newCenter.x, 14);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.nTextField resignFirstResponder];
    return YES;
}

@end

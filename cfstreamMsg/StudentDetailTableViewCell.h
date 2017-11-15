//
//  StudentDetailTableViewCell.h
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/18.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentModel.h"

@interface StudentDetailTableViewCell : UITableViewCell

- (void)refreshViewWithData:(StudentModel *)studentModel;

/*
 0 : ID
 1 : NAME
 2 : SEX
 3 : AGE
 */
- (void)refreshViewWithArray:(NSArray *)array;

@end

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

@end

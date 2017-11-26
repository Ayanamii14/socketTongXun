//
//  ModifyTableViewCell.h
//  cfstreamMsg
//
//  Created by LiuYuHao on 2017/11/26.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyTableViewCell : UITableViewCell

- (void)refreshViewWithData:(NSArray *)arr withIndexPath:(NSIndexPath *)indexPath;

@end

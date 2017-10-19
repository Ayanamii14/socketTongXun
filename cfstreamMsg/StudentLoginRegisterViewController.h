//
//  StudentLoginRegisterViewController.h
//  cfstreamMsg
//
//  Created by lyhao on 2017/10/19.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^finish)(void);

@interface StudentLoginRegisterViewController : UIViewController

@property (copy, nonatomic) finish f;

@end

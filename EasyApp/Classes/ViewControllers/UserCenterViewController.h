//
//  UserCenterViewController.h
//  EasyApp
//
//  Created by liudonghuan on 15/9/25.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterViewController : UIViewController

@end

@interface UserCenterLabelView : UIButton
- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title Image:(NSString *)imageName;
@end
//
//  ManageTableViewController.h
//  EasyApp
//
//  Created by liudonghuan on 15/9/28.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
- (instancetype)initWithType:(MainTableViewControllerType)type;
@end

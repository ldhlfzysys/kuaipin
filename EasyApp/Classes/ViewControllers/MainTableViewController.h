//
//  MainTableViewController.h
//  EasyApp
//
//  Created by liudonghuan on 15/8/22.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
#import "EASingleLineInputView.h"
typedef enum{
    MainTableViewControllerTypeFindJob = 0,
    MainTableViewControllerTypeFindServer = 1,
}MainTableViewControllerType;

@interface MainTableViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,EAAreaSelectDelegate>
- (instancetype)initWithType:(MainTableViewControllerType)type;
@end


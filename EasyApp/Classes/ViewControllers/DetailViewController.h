//
//  DetailViewController.h
//  EasyApp
//
//  Created by liudonghuan on 15/8/23.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableViewController.h"
@interface DetailViewController : UIViewController<UIAlertViewDelegate,UIActionSheetDelegate>

- (instancetype)initWithDictionary:(NSDictionary *)dict Type:(MainTableViewControllerType)type;
@end

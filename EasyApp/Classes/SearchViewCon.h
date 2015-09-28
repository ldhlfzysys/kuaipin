//
//  SearchViewCon.h
//  tuannimei
//
//  Created by liudonghuan on 15/1/29.
//  Copyright (c) 2015年 liudonghuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewCon : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (id)initWithType:(MainTableViewControllerType)type;
@end

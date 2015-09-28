//
//  SearchView.h
//  tuannimei
//
//  Created by liudonghuan on 15/1/29.
//  Copyright (c) 2015年 liudonghuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UITextField *mainText;
@property(nonatomic,strong)UIButton *deleteBtn;
@property(nonatomic,strong) void (^deleteBtnBlock)(void);




@end

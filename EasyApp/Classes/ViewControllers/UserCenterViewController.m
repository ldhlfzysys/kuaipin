//
//  UserCenterViewController.m
//  EasyApp
//
//  Created by liudonghuan on 15/9/25.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "UserCenterViewController.h"
#import "ManageTableViewController.h"
@interface UserCenterViewController ()
@property (nonatomic, strong) UserCenterLabelView *resetInfo;
@property (nonatomic, strong) UserCenterLabelView *resetPassoword;
@property (nonatomic, strong) UserCenterLabelView *workManage;
@property (nonatomic, strong) UserCenterLabelView *workerManage;
@end

@implementation UserCenterViewController

- (instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = UIColorFromRGB(0xe8e8e8);
        UIButton *btn = [Tools getBackBarBtn];
        [btn addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *testItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = testItem;
        self.navigationItem.titleView = [Tools getTitleLab:@"个人中心"];
        
        _resetInfo = [[UserCenterLabelView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 40) Title:@"修改信息" Image:@"usercenter_resetinfo"];
        [_resetInfo addTarget:self action:@selector(resetInfoClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_resetInfo];
        _resetPassoword = [[UserCenterLabelView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 40) Title:@"修改密码" Image:@"usercenter_resetpassword"];
        [_resetPassoword addTarget:self action:@selector(resetPassowordClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_resetPassoword];
        _workManage = [[UserCenterLabelView alloc]initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 40) Title:@"工作管理" Image:@"usercenter_workmanage"];
        [_workManage addTarget:self action:@selector(workManageClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_workManage];
        _workerManage = [[UserCenterLabelView alloc]initWithFrame:CGRectMake(0, 152, SCREEN_WIDTH, 40) Title:@"劳工管理" Image:@"usercenter_workermanage"];
        [_workerManage addTarget:self action:@selector(workerManageClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_workerManage];
    }
    return self;
}

- (void)resetInfoClick{
    
}

- (void)resetPassowordClick{
    
}

- (void)workManageClick{
    ManageTableViewController *manageVC = [[ManageTableViewController alloc]initWithType:MainTableViewControllerTypeFindJob];
    [self.navigationController pushViewController:manageVC animated:YES];
}

- (void)workerManageClick{
    ManageTableViewController *manageVC = [[ManageTableViewController alloc]initWithType:MainTableViewControllerTypeFindServer];
    [self.navigationController pushViewController:manageVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

@end

@interface UserCenterLabelView()
@property (nonatomic, strong)UILabel *textLabel;
@property (nonatomic, strong)UIImageView *iconImageView;
@end

@implementation UserCenterLabelView

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title Image:(NSString *)imageName{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = frame;
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 280, 40)];
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.text = title;
        [self addSubview:_textLabel];
        
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
        _iconImageView.image = [UIImage imageNamed:imageName];
        [self addSubview:_iconImageView];
        
    }
    return self;
}

@end

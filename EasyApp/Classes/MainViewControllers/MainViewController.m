//
//  MainViewController.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/9.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "MainViewController.h"
#import "EALoginViewController.h"
#import "RegisterWorkerViewController.h"
#import "IssueTaskViewController.h"
#import "MainTableViewController.h"
#import "UserCenterViewController.h"

@implementation MainViewController

- (instancetype)init{
    if (self = [super init]) {
        UIScrollView *mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -STATUSBAR, SCREEN_WIDTH, SCREEN_HEIGHT + STATUSBAR)];
        mainScrollView.backgroundColor = [UIColor whiteColor];
        mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 568);
        [self.view addSubview:mainScrollView];
        UIImageView *backgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT + STATUSBAR)];
        backgroundImage.image = [UIImage imageNamed:@"main_background"];
        [mainScrollView addSubview:backgroundImage];
        
        UIImageView *backgroundImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/1.7, SCREEN_WIDTH/1.7 * 618 / 358)];
        backgroundImage2.image = [UIImage imageNamed:@"main_background_2"];
        backgroundImage2.EA_Right = SCREEN_WIDTH;
        backgroundImage2.EA_CenterY = (SCREEN_HEIGHT+STATUSBAR)/2;
        [mainScrollView addSubview:backgroundImage2];
        
        UIButton *findServer = [self buttonWithFrame:CGRectMake(170, 100, 120, 60) Title:@"找人工" Image:@"main_button_findworker"];
        [findServer addTarget:self action:@selector(findServerClicked) forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:findServer];
        
        UIButton *findJob = [self buttonWithFrame:CGRectMake(70, 160, 120, 60) Title:@"找工作" Image:@"main_button_findjob"];
        [findJob addTarget:self action:@selector(findJobClicked) forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:findJob];
        
        UIButton *sendTask =[self buttonWithFrame:CGRectMake(20, (SCREEN_HEIGHT+STATUSBAR)/2-30, 130, 60) Title:@"工作发布" Image:@"main_button_issue"];
        [sendTask addTarget:self action:@selector(sendTaskClicked) forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:sendTask];
        
        
        UIButton *registerWorker = [self buttonWithFrame:CGRectMake(60, SCREEN_HEIGHT+STATUSBAR-220, 130, 60) Title:@"应聘登记" Image:@"main_button_registerworker"];
        [registerWorker addTarget:self action:@selector(registerWorkerClicked) forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:registerWorker];
        
        UIButton *userCenter = [self buttonWithFrame:CGRectMake(160, SCREEN_HEIGHT+STATUSBAR-160, 130, 60) Title:@"用户中心" Image:@"main_button_usercenter"];
        [userCenter addTarget:self action:@selector(userCenterClicked) forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:userCenter];
        
    }
    return self;
}

- (UIButton *)buttonWithFrame:(CGRect)frame Title:(NSString *)title Image:(NSString *)imageName{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.height)];
    icon.EA_Right = button.frame.size.width;
    icon.image = [UIImage imageNamed:@"main_button_background"];
    [button addSubview:icon];
    
    UIImageView *iconHeader = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.height/1.5, frame.size.height/1.5)];
    iconHeader.image = [UIImage imageNamed:imageName];
    [button addSubview:iconHeader];
    iconHeader.EA_CenterX = icon.EA_CenterX;
    iconHeader.EA_CenterY = icon.EA_CenterY;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.text = title;
    [button addSubview:label];
    return button;
}

//找服务
- (void)findServerClicked{
    MainTableViewController *mainTableVC = [[MainTableViewController alloc]initWithType:MainTableViewControllerTypeFindServer];
    [self.navigationController pushViewController:mainTableVC animated:YES];
    
}

//找工作
- (void)findJobClicked{
    MainTableViewController *mainTableVC = [[MainTableViewController alloc]initWithType:MainTableViewControllerTypeFindJob];
    [self.navigationController pushViewController:mainTableVC animated:YES];
    
}

//发布服务需求
- (void)sendTaskClicked{
    if ([DataCenterManager sharedManager].currentUser == nil) {
        EALoginViewController *loginVC = [[EALoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else{
        IssueTaskViewController *taskVC = [[IssueTaskViewController alloc]init];
        [self.navigationController pushViewController:taskVC animated:YES];
        
    }
}

//登记劳工
- (void)registerWorkerClicked{
    if ([DataCenterManager sharedManager].currentUser == nil) {
        EALoginViewController *loginVC = [[EALoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else{
        RegisterWorkerViewController *registerWorkerVC = [[RegisterWorkerViewController alloc]init];
        [self.navigationController pushViewController:registerWorkerVC animated:YES];
    }
}

//用户中心
- (void)userCenterClicked{
    
    if ([DataCenterManager sharedManager].currentUser == nil) {
        EALoginViewController *loginVC = [[EALoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else{
        UserCenterViewController *usercenterVC = [[UserCenterViewController alloc]init];
        [self.navigationController pushViewController:usercenterVC animated:YES];
    }
}

- (void)refesh{
    [[NetWorkManager sharedManager] sendGetRequest:APIlogin param:nil CallBackHandle:^(id responseObject){
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}

@end

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

@implementation MainViewController

- (instancetype)init{
    if (self = [super init]) {
        UIScrollView *mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        mainScrollView.backgroundColor = [UIColor whiteColor];
        mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 568);
        [self.view addSubview:mainScrollView];
        
        UIButton *findServer = [[UIButton alloc]initWithFrame:CGRectMake(0, 12.5, SCREEN_WIDTH, 180)];
        [findServer setBackgroundImage:[UIImage imageNamed:@"findServerBackground"] forState:UIControlStateNormal];
        [findServer setTitle:@"找服务" forState:UIControlStateNormal];
        [findServer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [findServer addTarget:self action:@selector(findServerClicked) forControlEvents:UIControlEventTouchUpInside];
        findServer.titleLabel.font = [UIFont systemFontOfSize:35];
        [mainScrollView addSubview:findServer];
        
        UIButton *findJob = [[UIButton alloc]initWithFrame:CGRectMake(0, 205, SCREEN_WIDTH, 180)];
        [findJob setBackgroundImage:[UIImage imageNamed:@"findJobBackground"] forState:UIControlStateNormal];
        [findJob setTitle:@"找工作" forState:UIControlStateNormal];
        [findJob setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [findJob addTarget:self action:@selector(findJobClicked) forControlEvents:UIControlEventTouchUpInside];
        findJob.titleLabel.font = [UIFont systemFontOfSize:35];
        [mainScrollView addSubview:findJob];
        
        UIButton *sendTask = [[UIButton alloc]initWithFrame:CGRectMake(0, 385, SCREEN_WIDTH/2, 183)];
        [sendTask addTarget:self action:@selector(sendTaskClicked) forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:sendTask];
        UIImageView *sendTaskImage = [[UIImageView alloc]initWithFrame:CGRectMake(45, 22, 55, 55)];
        sendTaskImage.image = [UIImage imageNamed:@"sendTask"];
        [sendTask addSubview:sendTaskImage];
        UILabel *sendTaskLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 86, SCREEN_WIDTH/2, 15)];
        sendTaskLabel.text = @"任务发布";
        sendTaskLabel.textColor = UIColorFromRGB(0x5a5a5a);
        sendTaskLabel.textAlignment = NSTextAlignmentCenter;
        [sendTask addSubview:sendTaskLabel];
        
        UIButton *registerWorker = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 385, SCREEN_WIDTH/2, 183)];
        [registerWorker addTarget:self action:@selector(registerWorkerClicked) forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:registerWorker];
        UIImageView *registerWorkerImage = [[UIImageView alloc]initWithFrame:CGRectMake(45, 22, 55, 55)];
        registerWorkerImage.image = [UIImage imageNamed:@"registerWorker"];
        [registerWorker addSubview:registerWorkerImage];
        UILabel *registerWorkerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 86, SCREEN_WIDTH/2, 15)];
        registerWorkerLabel.text = @"劳工登记";
        registerWorkerLabel.textColor = UIColorFromRGB(0x5a5a5a);
        registerWorkerLabel.textAlignment = NSTextAlignmentCenter;
        [registerWorker addSubview:registerWorkerLabel];
    }
    return self;
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

- (void)refesh{
    [[NetWorkManager sharedManager] sendGetRequest:APIlogin param:nil CallBackHandle:^(id responseObject){
        
    }];
}



@end

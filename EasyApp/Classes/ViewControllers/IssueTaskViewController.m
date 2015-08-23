//
//  IssueTaskViewController.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/22.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "IssueTaskViewController.h"
#import "EASingleLineInputView.h"
#import "EAButtonView.h"

@interface IssueTaskViewController ()
@property (nonatomic, retain) EASingleLineInputView *nameInput;
@property (nonatomic, retain) EASingleLineInputView *taskInput;
@property (nonatomic, retain) EASingleLineInputView *priceInput;
@property (nonatomic, retain) EASingleLineInputView *addressInput;
@property (nonatomic, retain) EASingleLineInputView *phoneInput;
@property (nonatomic, retain) EASingleLineInputView *areaInput;

@property (nonatomic, retain) EAButtonView *confirmButton;

@end

@implementation IssueTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [Tools getBackBarBtn];
    [btn addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *testItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = testItem;
    self.navigationItem.titleView = [Tools getTitleLab:@"发布任务"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _nameInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 25, SCREEN_WIDTH - 24, 30) Title:@"称呼" Placeholder:@"请输入您的称呼"];
    [self.view addSubview:_nameInput];
    _taskInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 67, SCREEN_WIDTH - 24, 30) Title:@"任务" Placeholder:@"请输入任务内容"];
    [self.view addSubview:_taskInput];
    _priceInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 109, SCREEN_WIDTH - 24, 30) Title:@"价格" Placeholder:@"请输入价格"];
    [self.view addSubview:_priceInput];
    _addressInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 151, SCREEN_WIDTH - 24, 30) Title:@"地址" Placeholder:@"输入您所在的具体地址"];
    [self.view addSubview:_addressInput];
    _phoneInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 193, SCREEN_WIDTH - 24, 30) Title:@"手机号" Placeholder:@"请输入您的联系电话"];
    [self.view addSubview:_phoneInput];
    _areaInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 234, SCREEN_WIDTH - 24, 30) Title:@"服务区域" Placeholder:@""];
    _areaInput.needAreaSelect = YES;
    [self.view addSubview:_areaInput];
    
    _confirmButton = [[EAButtonView alloc]initWithFrame:CGRectMake(12, 284, SCREEN_WIDTH - 24, 30) Title:@"确认" ColorType:BackgroundColorTypeRed];
    [self.view addSubview:_confirmButton];
    
    __block IssueTaskViewController *blockSelf = self;
    [_confirmButton setEAButtonClickBlock:^{
        [SVProgressHUD showWithStatus:@"正在登记" maskType:SVProgressHUDMaskTypeGradient];
        AppUser *user = [DataCenterManager sharedManager].currentUser;
        NSString *address = [NSString stringWithFormat:@"%@%@",blockSelf.areaInput.areaSelect.areaLabel.text,blockSelf.addressInput.contentTextField.text];
        NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:
                              user.uuid,@"userUuid",
                              blockSelf.taskInput.contentTextField.text,@"taskInfo",
                              blockSelf.priceInput.contentTextField.text,@"fee",
                              address,@"address",
                              blockSelf.phoneInput.contentTextField.text,@"userMobile",
                              blockSelf.nameInput.contentTextField.text,@"userName",nil];
        [[NetWorkManager sharedManager]sendGetRequest:APIaddtask param:dict CallBackHandle:^(id responseObject){
            if ([[responseObject objectForKey:@"status"] integerValue] == 0) {
                [SVProgressHUD showSuccessWithStatus:@"发布成功"];
                [blockSelf.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"发布失败"];
            }
        }];
    }];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

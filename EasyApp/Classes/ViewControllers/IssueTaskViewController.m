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
@property (nonatomic, retain) EASingleLineInputView *workerTypeInput;
@property (nonatomic, retain) EASingleLineInputView *genderInput;
@property (nonatomic, retain) EASingleLineInputView *ageInput;
@property (nonatomic, retain) EASingleLineInputView *priceInput;
@property (nonatomic, retain) EASingleLineInputView *educatedInput;
@property (nonatomic, retain) EASingleLineInputView *addressInput;
@property (nonatomic, retain) EASingleLineInputView *aboutmeInput;
@property (nonatomic, retain) EASingleLineInputView *contactInput;
@property (nonatomic, retain) EASingleLineInputView *phoneInput;

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
    
    _workerTypeInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 25, SCREEN_WIDTH - 24, 30) Title:@"工种" Placeholder:@"请输入劳工种类"];
    [self.view addSubview:_workerTypeInput];
    _genderInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 67, SCREEN_WIDTH - 24, 30) Title:@"性别要求" Placeholder:@""];
    _genderInput.needGenderSelectButton = YES;
    [self.view addSubview:_genderInput];
    _ageInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 109, SCREEN_WIDTH - 24, 30) Title:@"年龄要求" Placeholder:@"请选择年龄段"];
    [self.view addSubview:_ageInput];
    _priceInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 151, SCREEN_WIDTH - 24, 30) Title:@"提供薪酬" Placeholder:@"请输入提供的薪资"];
    [self.view addSubview:_priceInput];
    _educatedInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 193, SCREEN_WIDTH - 24, 30) Title:@"文化要求" Placeholder:@"请选择文化程度"];
    [self.view addSubview:_educatedInput];
    _addressInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 234, SCREEN_WIDTH - 24, 30) Title:@"用人单位" Placeholder:@"请输入单位地址"];
    [self.view addSubview:_addressInput];
    _aboutmeInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 276, SCREEN_WIDTH - 24, 30) Title:@"工作内容" Placeholder:@"请用简短的文字介绍工作"];
    [self.view addSubview:_aboutmeInput];
    _contactInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 318, SCREEN_WIDTH - 24, 30) Title:@"联系人" Placeholder:@"请输入联系人姓名"];
    [self.view addSubview:_contactInput];
    _phoneInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 360, SCREEN_WIDTH - 24, 30) Title:@"联系电话" Placeholder:@"请输入联系人电话"];
    [self.view addSubview:_phoneInput];
    
    _confirmButton = [[EAButtonView alloc]initWithFrame:CGRectMake(12, 410, SCREEN_WIDTH - 24, 30) Title:@"确认" ColorType:BackgroundColorTypeGreen];
    [self.view addSubview:_confirmButton];
    
    __block IssueTaskViewController *blockSelf = self;
    [_confirmButton setEAButtonClickBlock:^{
        [SVProgressHUD showWithStatus:@"正在登记" maskType:SVProgressHUDMaskTypeGradient];
        AppUser *user = [DataCenterManager sharedManager].currentUser;
        NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:
                              user.uuid,@"userUuid",
                              user.name,@"userName",
                              user.mobile,@"userMobile",
                              blockSelf.aboutmeInput.contentTextField.text,@"taskInfo",
                              blockSelf.ageInput.contentTextField.text,@"age",
                              blockSelf.genderInput.genderSelectButton.gender,@"gender",
                              blockSelf.workerTypeInput.contentTextField.text,@"taskType",
                              blockSelf.educatedInput.contentTextField.text,@"taskEducation",
                              blockSelf.addressInput.contentTextField.text,@"taskEmployer",
                              blockSelf.priceInput.contentTextField.text,@"taskFee",
                              blockSelf.phoneInput.contentTextField.text,@"workerMobile",nil];
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

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}


@end

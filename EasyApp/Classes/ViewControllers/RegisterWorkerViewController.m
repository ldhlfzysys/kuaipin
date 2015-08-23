//
//  RegisterWorkerViewController.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/22.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "RegisterWorkerViewController.h"
#import "EASingleLineInputView.h"
#import "EAButtonView.h"
@interface RegisterWorkerViewController ()
@property (nonatomic, retain) EASingleLineInputView *nameInput;
@property (nonatomic, retain) EASingleLineInputView *genderInput;
@property (nonatomic, retain) EASingleLineInputView *ageInput;
@property (nonatomic, retain) EASingleLineInputView *skillInput;
@property (nonatomic, retain) EASingleLineInputView *phoneInput;
@property (nonatomic, retain) EASingleLineInputView *areaInput;

@property (nonatomic, retain) EAButtonView *confirmButton;
@end

@implementation RegisterWorkerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [Tools getBackBarBtn];
    [btn addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *testItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = testItem;
    self.navigationItem.titleView = [Tools getTitleLab:@"劳工登记"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _nameInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 25, SCREEN_WIDTH - 24, 30) Title:@"称呼" Placeholder:@"请输入您的称呼"];
    [self.view addSubview:_nameInput];
    _genderInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 67, SCREEN_WIDTH - 24, 30) Title:@"性别" Placeholder:@"请输入您的性别"];
    _genderInput.needGenderSelectButton = YES;
    [self.view addSubview:_genderInput];
    _ageInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 109, SCREEN_WIDTH - 24, 30) Title:@"年龄" Placeholder:@"请输入您的年龄"];
    [self.view addSubview:_ageInput];
    _skillInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 151, SCREEN_WIDTH - 24, 30) Title:@"技能" Placeholder:@"例如：刷墙 瓦工 搬家"];
    [self.view addSubview:_skillInput];
    _phoneInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 193, SCREEN_WIDTH - 24, 30) Title:@"手机号" Placeholder:@"请输入您的联系电话"];
    [self.view addSubview:_phoneInput];
    _areaInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 234, SCREEN_WIDTH - 24, 30) Title:@"服务区域" Placeholder:@""];
    _areaInput.needAreaSelect = YES;
    [self.view addSubview:_areaInput];
    
    _confirmButton = [[EAButtonView alloc]initWithFrame:CGRectMake(12, 284, SCREEN_WIDTH - 24, 30) Title:@"确认" ColorType:BackgroundColorTypeRed];
    [self.view addSubview:_confirmButton];
    
    __block RegisterWorkerViewController *blockSelf = self;
    [_confirmButton setEAButtonClickBlock:^{
        [SVProgressHUD showWithStatus:@"正在登记" maskType:SVProgressHUDMaskTypeGradient];
        AppUser *user = [DataCenterManager sharedManager].currentUser;
        NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:
                              user.uuid,@"userUuid",
                              user.mobile,@"userMobile",
                              blockSelf.nameInput.contentTextField.text,@"name",
                              blockSelf.ageInput.contentTextField.text,@"age",
                              blockSelf.genderInput.genderSelectButton.gender,@"gender",
                              blockSelf.skillInput.contentTextField.text,@"skill",
                              blockSelf.areaInput.areaSelect.areaLabel.text,@"serviceRegion",
                              blockSelf.phoneInput.contentTextField.text,@"workerMobile",
                              user.name,@"userName",nil];
        [[NetWorkManager sharedManager]sendGetRequest:APIaddworker param:dict CallBackHandle:^(id responseObject){
            if ([[responseObject objectForKey:@"status"] integerValue] == 0) {
                [SVProgressHUD showSuccessWithStatus:@"登记成功"];
                [blockSelf.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"登记失败"];
            }
        }];
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ResetInfoViewController.m
//  EasyApp
//
//  Created by liudonghuan on 15/10/2.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "ResetInfoViewController.h"

@interface ResetInfoViewController ()
@end

@implementation ResetInfoViewController

- (instancetype)initWithType:(ResetInfoType)type{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        UIButton *btn = [Tools getBackBarBtn];
        [btn addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *testItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = testItem;
        
        
        if (type == ResetInfoTypePassword) {
            self.navigationItem.titleView = [Tools getTitleLab:@"修改密码"];
            _userName = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 25, SCREEN_WIDTH - 24, 30) Title:@"新密码" Placeholder:@"请输入新密码"];
            _userName.contentTextField.secureTextEntry = YES;
            [self.view addSubview:_userName];
            _gender = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 67, SCREEN_WIDTH - 24, 30) Title:@"再次输入" Placeholder:@"请再次输入新密码"];
            _gender.contentTextField.secureTextEntry = YES;
            [self.view addSubview:_gender];
        }else{
            self.navigationItem.titleView = [Tools getTitleLab:@"修改信息"];
            _userName = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 25, SCREEN_WIDTH - 24, 30) Title:@"用户名" Placeholder:@"请输入用户名"];
            [self.view addSubview:_userName];
            _gender = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 67, SCREEN_WIDTH - 24, 30) Title:@"选择性别" Placeholder:@""];
            _gender.needGenderSelectButton = YES;
            [self.view addSubview:_gender];
            
        }
        
        
        _confirmButton = [[EAButtonView alloc]initWithFrame:CGRectMake(12, 127, SCREEN_WIDTH - 24, 30) Title:@"确认" ColorType:BackgroundColorTypeGreen];
        [self.view addSubview:_confirmButton];
        [self.view addSubview:_confirmButton];
        __block ResetInfoViewController *blockSelf = self;
        [_confirmButton setEAButtonClickBlock:^{
            [SVProgressHUD showWithStatus:@"正在修改" maskType:SVProgressHUDMaskTypeGradient];
            AppUser *user = [DataCenterManager sharedManager].currentUser;
            NSMutableDictionary *dict = [@{} mutableCopy];
            if (type == ResetInfoTypePassword) {
                if (![blockSelf checkPasswrod]){
                    [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致"];
                    return;
                }
                [dict setObject:user.uuid forKey:@"uuid"];
                [dict setObject:blockSelf.userName.contentTextField.text forKey:@"password"];
            }else{
                [dict setObject:user.uuid forKey:@"uuid"];
                [dict setObject:blockSelf.userName.contentTextField.text forKey:@"userName"];
                [dict setObject:blockSelf.gender.genderSelectButton.gender forKey:@"gender"];
            }
            NSString *APIAddress = @"";
            if (type == ResetInfoTypePassword) {
                APIAddress = APIupdatePassword;
            }else{
                APIAddress = APIupdate;
            }
            [[NetWorkManager sharedManager]sendGetRequest:APIAddress param:dict CallBackHandle:^(id responseObject){
                if ([[responseObject objectForKey:@"status"] integerValue] == 0) {
                    [SVProgressHUD showSuccessWithStatus:@"更新成功"];
                    [blockSelf.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"更新失败，检查网络"];
                }
            }];
        }];
        
    }
    return self;
}

- (BOOL)checkPasswrod{
    if ([_userName.contentTextField.text isEqual:_gender.contentTextField.text]) {
        return YES;
    }else{
        return NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

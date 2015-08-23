//
//  EALoginViewController.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/22.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "EALoginViewController.h"
#import "EARegisterViewController.h"

@interface EALoginViewController ()

@end

@implementation EALoginViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [Tools getBackBarBtn];
    [btn addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *testItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = testItem;
    self.navigationItem.titleView = [Tools getTitleLab:@"登录"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _nameInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 25, SCREEN_WIDTH - 24, 30) Title:@"用户名" Placeholder:@"请输入您的手机号"];
    _nameInput.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_nameInput];
    _passwordInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 67, SCREEN_WIDTH - 24, 30) Title:@"密码" Placeholder:@"请输入密码"];
    _passwordInput.contentTextField.keyboardType = UIKeyboardTypeAlphabet;
    _passwordInput.contentTextField.secureTextEntry = YES;
    [_passwordInput samePositionLike:_nameInput];
    [self.view addSubview:_passwordInput];
    
    _loginBtn = [[EAButtonView alloc] initWithFrame:CGRectMake(12, 117, SCREEN_WIDTH - 24, 30) Title:@"登录" ColorType:BackgroundColorTypeGreen];
    [self.view addSubview:_loginBtn];
    __block EALoginViewController *blockSelf = self;
    [_loginBtn setEAButtonClickBlock:^{
        [SVProgressHUD showWithStatus:@"正在登录" maskType:SVProgressHUDMaskTypeGradient];
        [NSTimer scheduledTimerWithTimeInterval:5 invocation:nil repeats:NO];
        NSMutableDictionary *param = [[NSMutableDictionary alloc]initWithObjectsAndKeys:blockSelf.nameInput.contentTextField.text,@"mobile",blockSelf.passwordInput.contentTextField.text,@"password", nil];
        [[NetWorkManager sharedManager] sendPostRequest:APIlogin param:param CallBackHandle:^(id responseObject){
            
            NSInteger status = [[responseObject objectForKey:@"status"] integerValue];
            if (status == 0) {
                NSDictionary *dict = [responseObject objectForKey:@"data"];
                AppUser *user = [[AppUser alloc]init];
                [user userFromDictionary:dict];
                if (user) {
                    [DataCenterManager sharedManager].currentUser = user;
                    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"appuser"];
                }
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
            }
        }];
       
    }];
    
    _registerBtn =  [[EAButtonView alloc] initWithFrame:CGRectMake(12, 162, SCREEN_WIDTH - 24, 30) Title:@"注册" ColorType:BackgroundColorTypeRed];
    [_registerBtn setEAButtonClickBlock:^{
        EARegisterViewController *registerVC = [[EARegisterViewController alloc]init];
        [self.navigationController pushViewController:registerVC animated:YES];
    }];
    [self.view addSubview:_registerBtn];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_nameInput.contentTextField resignFirstResponder];
    
}

//- (void)dealloc{
//    [_nameInput release],_nameInput  = nil;
//    [_passwordInput release],_passwordInput = nil;
//    [_loginBtn release],_loginBtn = nil;
//    [_registerBtn release],_registerBtn = nil;
//    [_findPasswrodBackBtn release],_findPasswrodBackBtn = nil;
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//    [super dealloc];
//}

@end

//
//  EARegisterViewController.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/22.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "EARegisterViewController.h"

@interface EARegisterViewController ()
@property (nonatomic,retain) EASingleLineInputView *nameLabel;
@property (nonatomic,retain) EASingleLineInputView *passwordLabel;
@property (nonatomic,retain) EASingleLineInputView *checkCodeLabel;
@property (nonatomic,retain) EASingleLineInputView *confirmPasswrodLabel;

@property (nonatomic,retain) EAButtonView *backToLoginButton;
@property (nonatomic,retain) EAButtonView *registerButton;
@end

@implementation EARegisterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [Tools getBackBarBtn];
    [btn addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *testItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = testItem;
    self.navigationItem.titleView = [Tools getTitleLab:@"注册"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    __block EARegisterViewController *blockSelf = self;
    _nameLabel = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 25, SCREEN_WIDTH - 24, 30)  Title:@"手机号" Placeholder:@"请输入手机号"];
    _nameLabel.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_nameLabel];
    
    _checkCodeLabel = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 67, SCREEN_WIDTH - 24, 30) Title:@"验证码" Placeholder:@"请输入验证码"];
    _checkCodeLabel.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
    _checkCodeLabel.needGetCheckCodeButton = YES;
    [_checkCodeLabel.getCheckCodeButton setGetCheckCodeBlock:^{
        if ([blockSelf judgeNumber:blockSelf.nameLabel.contentTextField.text]) {
            [SVProgressHUD showErrorWithStatus:@"手机号不正确"];
        }else{
            blockSelf.checkCodeLabel.getCheckCodeButton.enabled = NO;
            [blockSelf.checkCodeLabel.getCheckCodeButton setTitle:@"请稍等" forState:UIControlStateNormal];
            [[NetWorkManager sharedManager]sendGetRequest:APIsendCheckNum param:@{@"mobile":blockSelf.nameLabel.contentTextField.text} CallBackHandle:^(id responseObject){
                if ([[responseObject objectForKey:@"status"] integerValue] == 0) {
                    [SVProgressHUD showSuccessWithStatus:@"获取成功"];
                    [blockSelf.checkCodeLabel.getCheckCodeButton setTitle:@"输入验证码" forState:UIControlStateNormal];
                    blockSelf.checkCodeLabel.getCheckCodeButton.checkCode = [[responseObject objectForKey:@"data"] objectForKey:@"checkNum"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"获取失败或您已注册"];
                    [blockSelf.checkCodeLabel.getCheckCodeButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
                    blockSelf.checkCodeLabel.getCheckCodeButton.enabled = YES;
                }
            }];
        }
        
    }];
    
    [self.view addSubview:_checkCodeLabel];
    
    _passwordLabel = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 109, SCREEN_WIDTH - 24, 30) Title:@"密码" Placeholder:@"请输入密码"];
    [_passwordLabel samePositionLike:_checkCodeLabel];
    _passwordLabel.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_passwordLabel];
    
    _confirmPasswrodLabel = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 151, SCREEN_WIDTH - 24, 30) Title:@"确认密码" Placeholder:@"再次输入密码"];
    _confirmPasswrodLabel.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_confirmPasswrodLabel];
    
    _registerButton = [[EAButtonView alloc]initWithFrame:CGRectMake(12, 201, SCREEN_WIDTH - 24, 30) Title:@"注册" ColorType:BackgroundColorTypeGreen];
    

    [_registerButton setEAButtonClickBlock:^{
        if (![blockSelf.passwordLabel.contentTextField.text isEqualToString:blockSelf.confirmPasswrodLabel.contentTextField.text]) {
            [SVProgressHUD showErrorWithStatus:@"两次密码不一致"];
        }else if(![blockSelf.checkCodeLabel.contentTextField.text isEqualToString:blockSelf.checkCodeLabel.getCheckCodeButton.checkCode]){
            [SVProgressHUD showErrorWithStatus:@"验证码不正确"];
        }else{
            
            NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:
                                  blockSelf.nameLabel.contentTextField.text,@"mobile",
                                  blockSelf.passwordLabel.contentTextField.text,@"password",nil];
            [[NetWorkManager sharedManager] sendGetRequest:APIregister param:param CallBackHandle:^(id responseObject){
                NSDictionary *dict = [responseObject objectForKey:@"data"];
                if ([[responseObject objectForKey:@"status"]integerValue] == 0) {
                    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"appuser"];
                    [blockSelf.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"注册失败"];
                }
                
            }];
        }
       
        
    }];
    [self.view addSubview:_registerButton];
    
    _backToLoginButton = [[EAButtonView alloc]initWithFrame:CGRectMake(12, 246, SCREEN_WIDTH - 24, 30) Title:@"返回登陆" ColorType:BackgroundColorTypeRed];
    [_backToLoginButton setEAButtonClickBlock:^{
        [blockSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
    [self.view addSubview:_backToLoginButton];
    
    
}

- (BOOL)judgeNumber:(NSString *)_number{
    NSString *phoneCheck=@"^1(3[0-9]|5[0-35-9]|8[025-9])//d{8}$";
    NSPredicate *phonelTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneCheck];
    return [phonelTest evaluateWithObject:_number];
    
}

//- (void)dealloc{
//    [_nameLabel release],_nameLabel = nil;
//    [_passwordLabel release],_passwordLabel = nil;
//    [_checkCodeLabel release],_checkCodeLabel = nil;
//    [_confirmPasswrodLabel release],_confirmPasswrodLabel = nil;
//    [_backToLoginButton release],_backToLoginButton = nil;
//    [_registerButton release],_registerButton = nil;
//    [super dealloc];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

@end

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

#define NUMBERS @"0123456789"

@interface IssueTaskViewController ()
@property (nonatomic, retain) EASingleLineInputView *workerTypeInput;
@property (nonatomic, retain) EASingleLineInputView *genderInput;
@property (nonatomic, retain) EASingleLineInputView *priceInput;
@property (nonatomic, retain) EASingleLineInputView *educatedInput;
@property (nonatomic, retain) EASingleLineInputView *addressInput;
@property (nonatomic, retain) EASingleLineInputView *aboutmeInput;
@property (nonatomic, retain) EASingleLineInputView *areaInput;
@property (nonatomic, retain) EASingleLineInputView *detailaddressInput;
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

    _priceInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 109, SCREEN_WIDTH - 24, 30) Title:@"提供薪酬" Placeholder:@"输入薪资：元/小时"];
    _priceInput.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
    _priceInput.contentTextField.delegate = self;
    [self.view addSubview:_priceInput];
    _educatedInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 151, SCREEN_WIDTH - 24, 30) Title:@"文化要求" Placeholder:@""];
    _educatedInput.needAreaSelect = YES;
    _educatedInput.areaSelect.areaArray = [[NSArray alloc]initWithObjects:@"小学",@"初中",@"高中",@"专科",@"本科",@"研究生",@"博士", nil];
    [self.view addSubview:_educatedInput];
    _addressInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 193, SCREEN_WIDTH - 24, 30) Title:@"用人单位" Placeholder:@"请输入单位地址"];
    [self.view addSubview:_addressInput];
    _aboutmeInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 234, SCREEN_WIDTH - 24, 30) Title:@"工作内容" Placeholder:@"请用简短的文字介绍工作"];
    [self.view addSubview:_aboutmeInput];
    
    _areaInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 276, SCREEN_WIDTH - 24, 30) Title:@"地区" Placeholder:@""];
    _areaInput.needAreaSelect = YES;
    [self.view addSubview:_areaInput];
    
    _detailaddressInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 318, SCREEN_WIDTH - 24, 30) Title:@"街道" Placeholder:@"填写详细地址"];
    [self.view addSubview:_detailaddressInput];
    
    _contactInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 360, SCREEN_WIDTH - 24, 30) Title:@"联系人" Placeholder:@"请输入联系人姓名"];
    [self.view addSubview:_contactInput];
    _phoneInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 400, SCREEN_WIDTH - 24, 30) Title:@"联系电话" Placeholder:@"请输入联系人电话"];
    [self.view addSubview:_phoneInput];
    
    _confirmButton = [[EAButtonView alloc]initWithFrame:CGRectMake(12, 460, SCREEN_WIDTH - 24, 30) Title:@"确认" ColorType:BackgroundColorTypeGreen];
    [self.view addSubview:_confirmButton];
    
    __block IssueTaskViewController *blockSelf = self;
    [_confirmButton setEAButtonClickBlock:^{
        [SVProgressHUD showWithStatus:@"正在登记" maskType:SVProgressHUDMaskTypeGradient];
        AppUser *user = [DataCenterManager sharedManager].currentUser;
        NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:
                              user.uuid,@"userUuid",
                              blockSelf.contactInput.contentTextField.text,@"userName",
                              blockSelf.phoneInput.contentTextField.text,@"userMobile",
                              blockSelf.workerTypeInput.contentTextField.text,@"taskType",
                              blockSelf.aboutmeInput.contentTextField.text,@"taskInfo",
                              blockSelf.genderInput.genderSelectButton.gender,@"taskGender",
                              blockSelf.priceInput.contentTextField.text,@"taskFee",
                              blockSelf.educatedInput.contentTextField.text,@"taskEducation",
                              blockSelf.addressInput.contentTextField.text,@"taskEmployer",
                              blockSelf.aboutmeInput.contentTextField.text,@"taskInfo",
                              blockSelf.areaInput.areaSelect.areaLabel.text,@"taskRegion",
                              blockSelf.detailaddressInput.contentTextField.text,@"taskRoad",
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

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    
    NSCharacterSet*cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"请输入数字"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        
        [alert show];
        return NO;
        
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

@end

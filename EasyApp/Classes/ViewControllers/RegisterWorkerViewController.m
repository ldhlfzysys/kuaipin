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

#define NUMBERS @"0123456789"

@interface RegisterWorkerViewController ()
@property (nonatomic, retain) EASingleLineInputView *workerTypeInput;
@property (nonatomic, retain) EASingleLineInputView *nameInput;
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

@implementation RegisterWorkerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [Tools getBackBarBtn];
    [btn addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *testItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = testItem;
    self.navigationItem.titleView = [Tools getTitleLab:@"应聘登记"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    _workerTypeInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 25, SCREEN_WIDTH - 24, 30) Title:@"工种" Placeholder:@"请输入劳工种类"];
    [self.view addSubview:_workerTypeInput];
    
    _nameInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 67, SCREEN_WIDTH - 24, 30) Title:@"姓名" Placeholder:@"请输入姓名"];
    [self.view addSubview:_nameInput];
    _genderInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 109, SCREEN_WIDTH - 24, 30) Title:@"性别" Placeholder:@"请输入您的性别"];
    _genderInput.needGenderSelectButton = YES;
    [self.view addSubview:_genderInput];
    _ageInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 151, SCREEN_WIDTH - 24, 30) Title:@"年龄" Placeholder:@"请输入您的年龄"];
    _ageInput.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
    _ageInput.contentTextField.delegate = self;
    [self.view addSubview:_ageInput];
    _priceInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 193, SCREEN_WIDTH - 24, 30) Title:@"薪酬要求" Placeholder:@"输入期望薪资：元/小时"];
    _priceInput.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
    _priceInput.contentTextField.delegate = self;
    [self.view addSubview:_priceInput];
    _educatedInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 234, SCREEN_WIDTH - 24, 30) Title:@"文化程度" Placeholder:@"请选择文化程度"];
    _educatedInput.needAreaSelect = YES;
    _educatedInput.areaSelect.areaArray = [[NSArray alloc]initWithObjects:@"不限",@"小学",@"初中",@"高中",@"专科",@"本科",@"研究生",@"博士", nil];
    [self.view addSubview:_educatedInput];
    _addressInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 276, SCREEN_WIDTH - 24, 30) Title:@"居住地" Placeholder:@"请选择居住地址"];
    _addressInput.needAreaSelect = YES;
    [self.view addSubview:_addressInput];
    _aboutmeInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 318, SCREEN_WIDTH - 24, 30) Title:@"自我介绍" Placeholder:@"请用简短的文字介绍自己"];
    [self.view addSubview:_aboutmeInput];
    _contactInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 360, SCREEN_WIDTH - 24, 30) Title:@"联系人" Placeholder:@"请输入联系人姓名"];
    //[self.view addSubview:_contactInput];
    _phoneInput = [[EASingleLineInputView alloc]initWithFrame:CGRectMake(12, 360, SCREEN_WIDTH - 24, 30) Title:@"劳工手机" Placeholder:@"请输入劳工手机"];
    [self.view addSubview:_phoneInput];
    
    _confirmButton = [[EAButtonView alloc]initWithFrame:CGRectMake(12, 410, SCREEN_WIDTH - 24, 30) Title:@"确认" ColorType:BackgroundColorTypeGreen];
    [self.view addSubview:_confirmButton];
    
    __block RegisterWorkerViewController *blockSelf = self;
    [_confirmButton setEAButtonClickBlock:^{
        [SVProgressHUD showWithStatus:@"正在登记" maskType:SVProgressHUDMaskTypeGradient];
        AppUser *user = [DataCenterManager sharedManager].currentUser;
        NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:
                              user.uuid,@"userUuid",
                              user.name,@"userName",
                              user.mobile,@"userMobile",
                              blockSelf.nameInput.contentTextField.text,@"name",
                              blockSelf.ageInput.contentTextField.text,@"age",
                              blockSelf.genderInput.genderSelectButton.genderChinese,@"gender",
                              blockSelf.workerTypeInput.contentTextField.text,@"workerMajor",
                              blockSelf.educatedInput.areaSelect.areaLabel.text,@"workerEducation",
                              blockSelf.aboutmeInput.contentTextField.text,@"workerDetail",
                              blockSelf.addressInput.areaSelect.areaLabel.text,@"workerAddress",
                              blockSelf.priceInput.contentTextField.text,@"workerSalary",
                              user.mobile,@"workerMobile",nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

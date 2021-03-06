//
//  DetailViewController.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/23.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "DetailViewController.h"
#import "EAButtonView.h"
#import "EASingleLineText.h"
@interface DetailViewController ()
@property (nonatomic,retain)EASingleLineText *nameLabel;
@property (nonatomic,retain)EASingleLineText *addressLabel;
@property (nonatomic,strong)EASingleLineText *genderLabel;
@property (nonatomic,strong)EASingleLineText *ageLabel;
@property (nonatomic,retain)EASingleLineText *priceLabel;
@property (nonatomic,strong)EASingleLineText *educationLabel;
@property (nonatomic,strong)EASingleLineText *companyAddressLabel;
@property (nonatomic,strong)EASingleLineText *aboutmeLabel;
@property (nonatomic,retain)EASingleLineText *contactLabel;
@property (nonatomic,retain)EASingleLineText *phoneLabel;
@property (nonatomic,retain)EAButtonView *callButton;
@property (nonatomic,retain)NSString *phoneNum;
@end

@implementation DetailViewController

- (instancetype)initWithDictionary:(NSDictionary *)dict Type:(MainTableViewControllerType)type{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        UIButton *btn = [Tools getBackBarBtn];
        [btn addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *testItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = testItem;
        self.navigationItem.titleView = [Tools getTitleLab:@"详细资料"];
        
        UIScrollView *mainScrollView = [[UIScrollView alloc]init];
        mainScrollView.backgroundColor = UIColorFromRGB(0xe8e8e8);
        [self.view addSubview:mainScrollView];
        
        
        if (type==MainTableViewControllerTypeFindServer) {//worker
            CGFloat commonLabelHegiht = 50;
            _nameLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60) HeadTitle:[dict objectForKey:@"workerMajor"] Content:[dict objectForKey:@"workerName"]];
            _nameLabel.headTitleLabel.textColor = UIColorFromRGB(0x0fa079);
            [mainScrollView addSubview:_nameLabel];
            
            _genderLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _nameLabel.EA_Bottom+1, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:@"性别要求:" Content:[dict objectForKey:@"workerGender"]];
            [mainScrollView addSubview:_genderLabel];
            
            _ageLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _genderLabel.EA_Bottom, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:@"年龄要求:" Content:[NSString stringWithFormat:@"%@",[dict objectForKey:@"workerAge"]]];
            [mainScrollView addSubview:_ageLabel];
            _priceLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _ageLabel.EA_Bottom, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:@"提供薪酬:" Content:[NSString stringWithFormat:@"%@%@",[dict objectForKey:@"workerSalary"],@"元/小时"]];
            [mainScrollView addSubview:_priceLabel];
            _educationLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _priceLabel.EA_Bottom, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:@"文化要求:" Content:[dict objectForKey:@"workerEducation"]];
            [mainScrollView addSubview:_educationLabel];
            
            _companyAddressLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _educationLabel.EA_Bottom, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:@"居住地址:" Content:[dict objectForKey:@"workerAddress"]];
            _companyAddressLabel.addressImage.image = [UIImage imageNamed:@"address_icon"];
            [_companyAddressLabel.addressImage setNeedsDisplay];
            [mainScrollView addSubview:_companyAddressLabel];
            
            _aboutmeLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _companyAddressLabel.EA_Bottom, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:@"自我介绍:" Content:[dict objectForKey:@"workerDetail"]];
            [mainScrollView addSubview:_aboutmeLabel];
            
            _contactLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _aboutmeLabel.EA_Bottom + 1, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:@"联系人:" Content:[dict objectForKey:@"workerName"]];
            [mainScrollView addSubview:_contactLabel];
            
            _phoneLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _contactLabel.EA_Bottom, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:@"联系电话:" Content:[dict objectForKey:@"workerMobile"]];
            [mainScrollView addSubview:_phoneLabel];
            
            _callButton = [[EAButtonView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, _contactLabel.EA_Bottom, commonLabelHegiht, 30) Title:@"打电话" ColorType:BackgroundColorTypeGreen];
            _callButton.EA_CenterY = _phoneLabel.EA_CenterY;
            _callButton.layer.masksToBounds = YES;
            _callButton.layer.cornerRadius = 8;
            mainScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, MIN(_phoneLabel.EA_Bottom, SCREEN_HEIGHT_REAL));
            mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _phoneLabel.EA_Bottom);
            _phoneNum = [dict objectForKey:@"workerMobile"];
        }else{//task
            CGFloat commonLabelHegiht = 40;
            _nameLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:[dict objectForKey:@"taskType"] Content:@""];
            [mainScrollView addSubview:_nameLabel];
            
            _addressLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _nameLabel.EA_Bottom, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:[NSString stringWithFormat:@"%@%@",[dict objectForKey:@"taskRegion"],[dict objectForKey:@"taskRoad"]] Content:@""];
            _addressLabel.headTitleLabel.EA_Width = 280;
            _addressLabel.contentLabel.hidden = YES;
            [mainScrollView addSubview:_addressLabel];
            
            _genderLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _addressLabel.EA_Bottom + 1, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:@"性别要求:" Content:[dict objectForKey:@"taskGender"]];
            [mainScrollView addSubview:_genderLabel];
            
            _ageLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _genderLabel.EA_Bottom, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:@"年龄要求:" Content:[dict objectForKey:@"taskAddress"]];
            [mainScrollView addSubview:_ageLabel];

            _priceLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _ageLabel.EA_Bottom, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:@"提供薪酬:" Content:[NSString stringWithFormat:@"%@%@",[dict objectForKey:@"taskFee"],@"元/小时"]];
            [mainScrollView addSubview:_priceLabel];
            
            _educationLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _priceLabel.EA_Bottom, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:@"文化要求:" Content:[dict objectForKey:@"taskEducation"]];
            [mainScrollView addSubview:_educationLabel];
            
            _companyAddressLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _educationLabel.EA_Bottom, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:@"用人单位:" Content:[dict objectForKey:@"taskEmployer"]];
            [mainScrollView addSubview:_companyAddressLabel];
            _aboutmeLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _companyAddressLabel.EA_Bottom, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:@"工作内容:" Content:[dict objectForKey:@"taskInfo"]];
            [mainScrollView addSubview:_aboutmeLabel];
            
            _contactLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _aboutmeLabel.EA_Bottom+1, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:@"联系人:" Content:[dict objectForKey:@"userName"]];
            [mainScrollView addSubview:_contactLabel];
            
            _phoneLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, _contactLabel.EA_Bottom, SCREEN_WIDTH, commonLabelHegiht) HeadTitle:@"联系电话:" Content:[dict objectForKey:@"userMobile"]];
            [mainScrollView addSubview:_phoneLabel];
            
            _callButton = [[EAButtonView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, _priceLabel.EA_Top, 60, 30) Title:@"打电话" ColorType:BackgroundColorTypeGreen];
            _callButton.EA_CenterY = _phoneLabel.EA_CenterY;
            _callButton.layer.masksToBounds = YES;
            _callButton.layer.cornerRadius = 8;
            mainScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, MIN(_phoneLabel.EA_Bottom, SCREEN_HEIGHT_REAL));
            mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _phoneLabel.EA_Bottom);
            _phoneNum = [dict objectForKey:@"userMobile"];
        }
        
        [mainScrollView addSubview:_callButton];
        __block DetailViewController *blockSelf = self;
        [_callButton setEAButtonClickBlock:^(){
            [blockSelf makephonecall];
            
        }];
    }
    return self;
}


-(void)makephonecall
{
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择拨打商家电话"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil];
    [sheet addButtonWithTitle:_phoneNum];
    
    [sheet addButtonWithTitle:@"取消"];
    sheet.cancelButtonIndex = sheet.numberOfButtons-1;
    [sheet showInView:self.view];
    
}
//打电话
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        
    }else{
        NSString *phonecall = [NSString stringWithFormat:@"%@%@",@"tel:",[actionSheet buttonTitleAtIndex:buttonIndex]];
        if(![[UIApplication sharedApplication]openURL:[NSURL URLWithString:phonecall]] ){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"无法打开程序" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil] ;
            [alert show] ;
        }
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

@end

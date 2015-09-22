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
@property (nonatomic,retain)EASingleLineText *businessLabel;
@property (nonatomic,retain)EASingleLineText *priceLabel;
@property (nonatomic,retain)EASingleLineText *addressLabel;
@property (nonatomic,retain)EASingleLineText *phoneLabel;
@property (nonatomic,retain)EAButtonView *callButton;
@property (nonatomic,retain)NSString *phoneNum;
@end

@implementation DetailViewController

- (instancetype)initWithDictionary:(NSDictionary *)dict Type:(MainTableViewControllerType)type{
    if (self = [super init]) {
        self.view.backgroundColor = UIColorFromRGB(0xe8e8e8);
        UIButton *btn = [Tools getBackBarBtn];
        [btn addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *testItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = testItem;
        self.navigationItem.titleView = [Tools getTitleLab:@"详细资料"];
        
        
        if (type==MainTableViewControllerTypeFindServer) {//worker
            _nameLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60) HeadTitle:[dict objectForKey:@"workerName"] Content:[NSString stringWithFormat:@"%@%@%@%@",[dict objectForKey:@"workerGender"],@" ",[dict objectForKey:@"workerAge"],@"岁"]];
            [self.view addSubview:_nameLabel];
            _businessLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 40) HeadTitle:@"业务介绍" Content:[dict objectForKey:@"workerSkill"]];
            [self.view addSubview:_businessLabel];
            _addressLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 40) HeadTitle:@"联系地址" Content:[dict objectForKey:@"serviceRegion"]];
            [self.view addSubview:_addressLabel];
            _phoneLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, 155, SCREEN_WIDTH, 40) HeadTitle:@"联系电话" Content:[dict objectForKey:@"userMobile"]];
            [self.view addSubview:_phoneLabel];
            _callButton = [[EAButtonView alloc]initWithFrame:CGRectMake(15, 215, SCREEN_WIDTH - 30, 30) Title:@"打电话" ColorType:BackgroundColorTypeRed];
            
        }else{//task

            _nameLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60) HeadTitle:[dict objectForKey:@"userName"] Content:@""];
            [self.view addSubview:_nameLabel];
            _businessLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 40) HeadTitle:@"业务介绍" Content:[dict objectForKey:@"taskInfo"]];
            [self.view addSubview:_businessLabel];
            _priceLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 40) HeadTitle:@"劳务费" Content:[NSString stringWithFormat:@"%@%@",[dict objectForKey:@"taskFee"],@"元"]];
            [self.view addSubview:_priceLabel];
            _addressLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, 155, SCREEN_WIDTH, 40) HeadTitle:@"联系地址" Content:[dict objectForKey:@"taskAddress"]];
            [self.view addSubview:_addressLabel];
            _phoneLabel = [[EASingleLineText alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 40) HeadTitle:@"联系电话" Content:[dict objectForKey:@"userMobile"]];
            [self.view addSubview:_phoneLabel];
            
            _callButton = [[EAButtonView alloc]initWithFrame:CGRectMake(15, 260, SCREEN_WIDTH - 30, 30) Title:@"打电话" ColorType:BackgroundColorTypeRed];
        }
        _phoneNum = [dict objectForKey:@"userMobile"];
        [self.view addSubview:_callButton];
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

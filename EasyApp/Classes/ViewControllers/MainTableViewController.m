//
//  MainTableViewController.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/22.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "MainTableViewController.h"
#import "DetailViewController.h"
#import "MainTableViewCell.h"
#import "SearchViewCon.h"
@interface MainTableViewController ()
@property (nonatomic, retain) EAAreaSelect *leftSelectView;
@property (nonatomic, retain) EAAreaSelect *midSelectView;
@property (nonatomic, retain) EAAreaSelect *rightSelectView;
@property (nonatomic, retain) NSMutableArray *datas;
@property (nonatomic, assign) MainTableViewControllerType nowType;
@property (nonatomic, retain) UITableView *mainTable;
@property (nonatomic, assign) int pageNum;
@property (nonatomic, retain) NSString *APIAddress;
@property(nonatomic,strong)UIButton *searchBtn;
@end

@implementation MainTableViewController

- (instancetype)initWithType:(MainTableViewControllerType)type{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        _datas = [NSMutableArray array];
        _nowType = type;
        UIButton *btn = [Tools getBackBarBtn];
        [btn addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *testItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = testItem;
        
        switch (_nowType) {
            case MainTableViewControllerTypeFindJob:{//找工作
                _leftSelectView = [[EAAreaSelect alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 42)];
                _leftSelectView.delegate = self;
                [self.view addSubview:_leftSelectView];
                _rightSelectView = [[EAAreaSelect alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 42)];
                _rightSelectView.delegate = self;
                [self.view addSubview:_rightSelectView];
                _rightSelectView.areaLabel.text = @"服务区域";
                _leftSelectView.areaLabel.text = @"排序方式";
                _leftSelectView.areaArray = [[NSArray alloc]initWithObjects:@"不限",@"按价格",@"按时间", nil];
                _APIAddress = APIfindtask;
                _midSelectView = [[EAAreaSelect alloc]init];
                _midSelectView.areaLabel.text = @"性别";
                _midSelectView.areaArray = [[NSArray alloc]initWithObjects:@"不限",@"男",@"女", nil];
                _midSelectView.hidden = YES;
                //画线
                UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, 1, 42)];
                line1.backgroundColor = UIColorFromRGB(0xe8e8e8);
                [self.view addSubview:line1];
                
            }
                break;
            case MainTableViewControllerTypeFindServer:{
                _leftSelectView = [[EAAreaSelect alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 42)];
                _leftSelectView.delegate = self;
                [self.view addSubview:_leftSelectView];
                _midSelectView = [[EAAreaSelect alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 42)];
                _midSelectView.delegate = self;
                [self.view addSubview:_midSelectView];
                _rightSelectView = [[EAAreaSelect alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2/3, 0, SCREEN_WIDTH/3, 42)];
                _rightSelectView.delegate = self;
                [self.view addSubview:_rightSelectView];
                _midSelectView.areaLabel.text = @"性别";
                _midSelectView.areaArray = [[NSArray alloc]initWithObjects:@"不限",@"男",@"女", nil];
                _rightSelectView.areaLabel.text = @"服务区域";
                _leftSelectView.areaLabel.text = @"年龄段";
                _leftSelectView.areaArray = [[NSArray alloc]initWithObjects:@"不限",@"18~25",@"26~35",@"35以上", nil];
                _APIAddress = APIfindworker;
                //画线
                UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 0, 1, 42)];
                line1.backgroundColor = UIColorFromRGB(0xe8e8e8);
                [self.view addSubview:line1];
                
                UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2/3, 0, 1, 42)];
                line2.backgroundColor = UIColorFromRGB(0xe8e8e8);
                [self.view addSubview:line2];
            }
                break;
                
            default:
                break;
        }
        
        
        
        UIImageView *line3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
        line3.backgroundColor = UIColorFromRGB(0xe8e8e8);
        [self.view addSubview:line3];
        
        _mainTable  = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.view.EA_Width,self.view.EA_Height - 40 - 44)];
        _mainTable.dataSource = self;
        _mainTable.delegate = self;
        _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTable];
        
        _mainTable.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        _mainTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
        
        _pageNum = 1;
        [_mainTable.header beginRefreshing];
        //搜索框
        _searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, (46-27.5)/2, 254, 27.5)];
        _searchBtn.EA_CenterX = SCREEN_WIDTH/2 + 10;
        [_searchBtn setBackgroundImage:[UIImage imageNamed:@"searchbar_bg"] forState:UIControlStateNormal];
        [_searchBtn setBackgroundImage:[UIImage imageNamed:@"searchbar_bg"] forState:UIControlStateHighlighted];
        [_searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UILabel *searchtitle = [[UILabel alloc]initWithFrame:CGRectMake(35, 7.5, 120, 12)];
        searchtitle.font = [UIFont systemFontOfSize:12];
        searchtitle.text = @"请输入商户名、地点";
        searchtitle.textColor = [UIColor blackColor];
        [_searchBtn addSubview:searchtitle];
    }
    return self;
}

- (void)searchBtnClick{
    SearchViewCon *searchVC = [[SearchViewCon alloc]initWithType:_nowType];
    [self.navigationController pushViewController:searchVC animated:YES];
}
- (void)contentDidChange{
    [_mainTable.header beginRefreshing];
}

- (void)headerRefresh{
    _pageNum = 1;
    
    [[NetWorkManager sharedManager]sendGetRequest:_APIAddress param:[self getDictonary] CallBackHandle:^(id responseObject){
        if ([[responseObject objectForKey:@"status"] integerValue] == 0) {
            [_datas removeAllObjects];
            NSArray *data = [responseObject objectForKey:@"data"];
            [_datas addObjectsFromArray:data];
            [_mainTable reloadData];
        }else{
            [_datas removeAllObjects];
            [_mainTable reloadData];
        }
        [self endRefresh];
    }];
}

- (void)footerRefresh{
    _pageNum +=1;

    [[NetWorkManager sharedManager]sendGetRequest:_APIAddress param:[self getDictonary] CallBackHandle:^(id responseObject){
        if ([[responseObject objectForKey:@"status"] integerValue] == 0) {
            NSArray *data = [responseObject objectForKey:@"data"];
            [_datas addObjectsFromArray:data];
            [_mainTable reloadData];
        }else{
            
        }
        [self endRefresh];
    }];
}

- (NSMutableDictionary *)getDictonary{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    NSString *areaStr = @"";
    NSString *gengderStr = @"";
    if (![_rightSelectView.areaLabel.text isEqualToString:@"服务区域"] && ![_rightSelectView.areaLabel.text isEqualToString:@"不限"]) {
        areaStr = _rightSelectView.areaLabel.text;
    }
    if (![_midSelectView.areaLabel.text isEqualToString:@"性别"] &&![_midSelectView.areaLabel.text isEqualToString:@"不限"]) {
        gengderStr = _midSelectView.areaLabel.text;
    }
    NSString *pageStr = [NSString stringWithFormat:@"%d",_pageNum];
    if (_nowType == MainTableViewControllerTypeFindJob) {
        [para setObject:_rightSelectView.areaLabel.text forKey:@"serviceRegion"];
        NSString *sortStr= @"";
        if ([_leftSelectView.areaLabel.text isEqualToString:@"按时间"]) {
            sortStr = @"insertTime";
        }else if ([_leftSelectView.areaLabel.text isEqualToString:@"按价格"]){
            sortStr = @"taskFee";
        }
        [para setObject:sortStr forKey:@"sort"];
        [para setObject:pageStr forKey:@"page"];
        [para setObject:areaStr forKey:@"serviceRegion"];
        [para setObject:gengderStr forKey:@"gender"];
        
    }else{
        NSString *minAge = @"0";
        NSString *maxAge = @"99";
        if ([_leftSelectView.areaLabel.text componentsSeparatedByString:@"~"].count == 2) {
            minAge = [[_leftSelectView.areaLabel.text componentsSeparatedByString:@"~"] firstObject];
            maxAge =[[_leftSelectView.areaLabel.text componentsSeparatedByString:@"~"] lastObject];
        }
        [para setObject:minAge forKey:@"minAge"];
        [para setObject:maxAge  forKey:@"maxAge"];
        [para setObject:areaStr forKey:@"serviceRegion"];
        [para setObject:pageStr forKey:@"page"];
        [para setObject:gengderStr forKey:@"gender"];
    }
    return para;
}

- (void)endRefresh{
    [_mainTable.header endRefreshing];
    [_mainTable.footer endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuserStr = @"MaintableViewCell";
    MainTableViewCell *cell = [[MainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserStr];
    if (cell == nil) {
        cell = [[MainTableViewCell alloc]init];
    }
    
    if (_nowType == MainTableViewControllerTypeFindJob){//找工作
        cell.typeLabel.text = [[_datas objectAtIndex:indexPath.row] objectForKey:@"taskType"];
        cell.nameLabel.text = [[_datas objectAtIndex:indexPath.row] objectForKey:@"taskEmployer"];
        cell.ageLabel.text = [[_datas objectAtIndex:indexPath.row] objectForKey:@"taskRegion"];
        cell.priceLabel.text = [NSString stringWithFormat:@"%@%@",[[_datas objectAtIndex:indexPath.row] objectForKey:@"taskFee"],@"元/小时"];
        if ([[[_datas objectAtIndex:indexPath.row] objectForKey:@"taskGender"] isEqualToString:@"女"]) {
            cell.genderImageView.image = [UIImage imageNamed:@"gendericon_female"];
        }else{
            cell.genderImageView.image = [UIImage imageNamed:@"gendericon_male"];
        }
        cell.priceIconImageView.image = [UIImage imageNamed:@"priceicon_task"];
    }else{//找人工
        cell.typeLabel.text = [[_datas objectAtIndex:indexPath.row] objectForKey:@"workerMajor"];
        cell.nameLabel.text = [[_datas objectAtIndex:indexPath.row] objectForKey:@"workerName"];
        cell.ageLabel.text = [NSString stringWithFormat:@"%@%@",[[_datas objectAtIndex:indexPath.row] objectForKey:@"workerAge"],@"岁"];
        cell.priceLabel.text = [NSString stringWithFormat:@"%@%@",[[_datas objectAtIndex:indexPath.row] objectForKey:@"workerSalary"],@"元/小时"];
        if ([[[_datas objectAtIndex:indexPath.row] objectForKey:@"workerGender"] isEqualToString:@"女"]) {
            cell.genderImageView.image = [UIImage imageNamed:@"gendericon_female"];
        }else{
            cell.genderImageView.image = [UIImage imageNamed:@"gendericon_male"];
        }
        cell.priceIconImageView.image = [UIImage imageNamed:@"priceicon_worker"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [[DetailViewController alloc]initWithDictionary:[_datas objectAtIndex:indexPath.row] Type:_nowType];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated{
//    [self.navigationController.view addSubview:_searchBtn];
    [self.navigationController.navigationBar addSubview:_searchBtn];
}

- (void)viewWillDisappear:(BOOL)animated{
    [_searchBtn removeFromSuperview];
}
@end


//
//  ManageTableViewController.m
//  EasyApp
//
//  Created by liudonghuan on 15/9/28.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "ManageTableViewController.h"
#import "MainTableViewCell.h"
#import "DetailViewController.h"
@interface ManageTableViewController ()
@property (nonatomic, retain) NSMutableArray *datas;
@property (nonatomic, assign) MainTableViewControllerType nowType;
@property (nonatomic, retain) UITableView *mainTable;
@property (nonatomic, assign) int pageNum;
@property (nonatomic, retain) NSString *APIAddress;
@property (nonatomic, retain) NSString *APIDeleteAddress;
@property (nonatomic, retain) UIBarButtonItem *backBtn;
@property (nonatomic,retain) UIBarButtonItem *editBtn;
@property (nonatomic,retain)UIBarButtonItem *confirmBtn;
@property (nonatomic,retain)NSMutableDictionary *deleteItems;
@end

@implementation ManageTableViewController

- (instancetype)initWithType:(MainTableViewControllerType)type{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        _datas = [NSMutableArray array];
        _pageNum = 1;
        _nowType = type;
        _deleteItems = [@{} mutableCopy];
        UIButton *btn = [Tools getBackBarBtn];
        [btn addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        _backBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = _backBtn;
        self.navigationItem.titleView = [Tools getTitleLab:@"详细资料"];
        
        UIButton *editButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        [editButton addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
        [editButton setBackgroundImage:[UIImage imageNamed:@"editbutton_bg"] forState:UIControlStateNormal];
        _editBtn = [[UIBarButtonItem alloc]initWithCustomView:editButton];
        self.navigationItem.rightBarButtonItem = _editBtn;
        
        UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        [confirm addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        confirm.titleLabel.font = [UIFont systemFontOfSize:10];
        [confirm setTitle:@"确认" forState:UIControlStateNormal];
        [confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        confirm.layer.borderColor = [UIColor whiteColor].CGColor;
        confirm.layer.borderWidth = 1;
        _confirmBtn = [[UIBarButtonItem alloc]initWithCustomView:confirm];
        
        
        
        switch (_nowType) {
            case MainTableViewControllerTypeFindJob:{//找工作
                _APIAddress = APIFindMyTask;
                _APIDeleteAddress = APIdeletetask;
                self.navigationItem.titleView = [Tools getTitleLab:@"工作管理"];
                
            }
                break;
            case MainTableViewControllerTypeFindServer:{
                _APIAddress = APIFindMyWorker;
                _APIDeleteAddress = APIdeleteworker;
                self.navigationItem.titleView = [Tools getTitleLab:@"劳工管理"];
            }
                break;
                
            default:
                break;
        }
        _mainTable  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.EA_Width,self.view.EA_Height - 44)];
        _mainTable.dataSource = self;
        _mainTable.delegate = self;
        _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTable.allowsMultipleSelectionDuringEditing=YES;
        [self.view addSubview:_mainTable];
        
        _mainTable.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        _mainTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
        
        _pageNum = 1;
        [_mainTable.header beginRefreshing];
    }
    return self;
}


- (void)editClick{
    _mainTable.editing = YES;
    self.navigationItem.rightBarButtonItem = _confirmBtn;
}

- (void)confirmClick{
    _mainTable.editing = NO;
    self.navigationItem.rightBarButtonItem = _editBtn;
    [_datas removeObjectsInArray:[_deleteItems allValues]];
    [_mainTable deleteRowsAtIndexPaths:[NSArray arrayWithArray:[_deleteItems allKeys]] withRowAnimation:UITableViewRowAnimationNone];
    __block NSString *uuids = [@"" mutableCopy];
    
    [_deleteItems enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        uuids = [uuids stringByAppendingFormat:@"%@%@",[obj objectForKey:@"uuid"],@";"];
    }];
    NSDictionary *para = @{@"uuids":uuids};
    [[NetWorkManager sharedManager]sendGetRequest:_APIDeleteAddress param:para CallBackHandle:^(id responseObject){
        NSLog(@"%@",para);
        if ([[responseObject objectForKey:@"status"] integerValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"操作成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"操作失败，请刷新重试"];
        }
    }];
    [_deleteItems removeAllObjects];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *cell = (MainTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    [_deleteItems removeObjectForKey:indexPath];
}


- (void)headerRefresh{
    _pageNum = 1;
    AppUser *user = [DataCenterManager sharedManager].currentUser;
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:user.uuid,@"userUuid", nil];
    [[NetWorkManager sharedManager]sendGetRequest:_APIAddress param:para CallBackHandle:^(id responseObject){
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
    AppUser *user = [DataCenterManager sharedManager].currentUser;
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:user.uuid,@"userUuid", nil];
    [[NetWorkManager sharedManager]sendGetRequest:_APIAddress param:para CallBackHandle:^(id responseObject){
        if ([[responseObject objectForKey:@"status"] integerValue] == 0) {
            NSArray *data = [responseObject objectForKey:@"data"];
            [_datas addObjectsFromArray:data];
            [_mainTable reloadData];
        }else{
            
        }
        [self endRefresh];
    }];
}

- (void)endRefresh{
    [_mainTable.header endRefreshing];
    [_mainTable.footer endRefreshing];
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
	cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    if (cell == nil) {
        cell = [[MainTableViewCell alloc]init];
    }
    if (_nowType == MainTableViewControllerTypeFindJob){//找工作
        cell.typeLabel.text = [[_datas objectAtIndex:indexPath.row] objectForKey:@"taskType"];
        cell.nameLabel.text = [[_datas objectAtIndex:indexPath.row] objectForKey:@"taskEmployer"];
        cell.ageLabel.text = [[_datas objectAtIndex:indexPath.row] objectForKey:@"taskRegion"];
        cell.addressImageView.image = [UIImage imageNamed:@"address_icon_gray"];
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

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.editing == YES) {
        MainTableViewCell *cell = (MainTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.selected = YES;
        [_deleteItems setObject:[_datas objectAtIndex:indexPath.row] forKey:indexPath];
        
    }else{
        
        DetailViewController *detailVC = [[DetailViewController alloc]initWithDictionary:[_datas objectAtIndex:indexPath.row] Type:_nowType];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

@end


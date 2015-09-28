//
//  SearchViewCon.m
//  tuannimei
//
//  Created by liudonghuan on 15/1/29.
//  Copyright (c) 2015年 liudonghuan. All rights reserved.
//

#import "SearchViewCon.h"
#import "SearchView.h"
#import "MainTableViewCell.h"
#import "DetailViewController.h"
@interface SearchViewCon()
@property(nonatomic,strong)NSMutableArray *searchDatas;
@property (nonatomic,strong) SearchView *mainView;
@property (nonatomic,assign)MainTableViewControllerType nowType;
@property (nonatomic,copy)NSString *APIAddress;
@end

@implementation SearchViewCon
- (id)initWithType:(MainTableViewControllerType)type{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _nowType = type;
        switch (type) {
            case MainTableViewControllerTypeFindJob:{
                _APIAddress = APIsearchtask;
                break;
            }
            case MainTableViewControllerTypeFindServer:{
                _APIAddress = APIsearchworker;
                break;
            }
            default:
                break;
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:_mainView.mainText];
    }
    return self;
}
- (void)loadView{
    UIButton *btn = [Tools getBackBarBtn];
    [btn addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *testItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = testItem;
    
    _mainView = [[SearchView alloc]init];
    _searchDatas = [@[] mutableCopy];
    [self setView:_mainView];
    _mainView.tableView.delegate = self;
    _mainView.tableView.dataSource = self;
    __block SearchViewCon *blockself = self;
    [_mainView setDeleteBtnBlock:^(){
        [blockself.mainView.mainText setText:@""];
    }];
    [self.navigationController.view addSubview:_mainView.mainText];
    [self.navigationController.view addSubview:_mainView.deleteBtn];
    [_mainView.mainText becomeFirstResponder];

}
//标签

#pragma mark - uitextfieldNof

- (void)textFieldChanged:(NSNotification *)nof
{
    UITextField *field = [nof object];
    if ([field.text isEqualToString:@""]) {
        _mainView.tableView.hidden = YES;
    }else{
        NSDictionary *para = [[NSDictionary alloc] initWithObjectsAndKeys:field.text,@"keyWord", nil];
        [[NetWorkManager sharedManager]sendGetRequest:_APIAddress param:para CallBackHandle:^(id responseObject){
            if ([[responseObject objectForKey:@"status"] integerValue] == 0) {
                [_searchDatas removeAllObjects];
                NSArray *data = [responseObject objectForKey:@"data"];
                [_searchDatas addObjectsFromArray:data];
                [_mainView.tableView reloadData];
                _mainView.tableView.hidden = NO;
            }else{
                [_searchDatas removeAllObjects];
                [_mainView.tableView reloadData];
            }
        }];

    }
    
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _searchDatas.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *biaoji = @"search";
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:biaoji];
    
    if (cell == nil) {
        cell = [[MainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:biaoji];
    }
    if (_nowType == MainTableViewControllerTypeFindJob){//找工作
        cell.typeLabel.text = [[_searchDatas objectAtIndex:indexPath.row] objectForKey:@"taskType"];
        cell.nameLabel.text = [[_searchDatas objectAtIndex:indexPath.row] objectForKey:@"taskEmployer"];
        cell.ageLabel.text = [[_searchDatas objectAtIndex:indexPath.row] objectForKey:@"taskRegion"];
        cell.priceLabel.text = [NSString stringWithFormat:@"%@%@",[[_searchDatas objectAtIndex:indexPath.row] objectForKey:@"taskFee"],@"元/小时"];
        if ([[[_searchDatas objectAtIndex:indexPath.row] objectForKey:@"taskGender"] isEqualToString:@"女"]) {
            cell.genderImageView.image = [UIImage imageNamed:@"gendericon_female"];
        }else{
            cell.genderImageView.image = [UIImage imageNamed:@"gendericon_male"];
        }
        cell.priceIconImageView.image = [UIImage imageNamed:@"priceicon_task"];
    }else{//找人工
        cell.typeLabel.text = [[_searchDatas objectAtIndex:indexPath.row] objectForKey:@"workerMajor"];
        cell.nameLabel.text = [[_searchDatas objectAtIndex:indexPath.row] objectForKey:@"workerName"];
        cell.ageLabel.text = [NSString stringWithFormat:@"%@%@",[[_searchDatas objectAtIndex:indexPath.row] objectForKey:@"workerAge"],@"岁"];
        cell.priceLabel.text = [NSString stringWithFormat:@"%@%@",[[_searchDatas objectAtIndex:indexPath.row] objectForKey:@"workerSalary"],@"元/小时"];
        if ([[[_searchDatas objectAtIndex:indexPath.row] objectForKey:@"workerGender"] isEqualToString:@"女"]) {
            cell.genderImageView.image = [UIImage imageNamed:@"gendericon_female"];
        }else{
            cell.genderImageView.image = [UIImage imageNamed:@"gendericon_male"];
        }
        cell.priceIconImageView.image = [UIImage imageNamed:@"priceicon_worker"];
    }
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVC = [[DetailViewController alloc]initWithDictionary:[_searchDatas objectAtIndex:indexPath.row] Type:_nowType];
    [self.navigationController pushViewController:detailVC animated:YES];
}





#pragma mark - 滚动协议及生命周期相关
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_mainView.mainText) {
        [_mainView.mainText resignFirstResponder];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_mainView.mainText removeFromSuperview];
    [_mainView.deleteBtn removeFromSuperview];

}

@end

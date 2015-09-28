//
//  SearchView.m
//  tuannimei
//
//  Created by liudonghuan on 15/1/29.
//  Copyright (c) 2015年 liudonghuan. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

- (id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xf0efed);
        
        
        _mainText = [[UITextField alloc]initWithFrame:CGRectMake(45, 40/2 - 33/2 +22 , 260, 33)];
        //_mainText.layer.borderColor = MXCOLOR_ORANGE.CGColor;
        _mainText.layer.borderWidth = 0.5;
        _mainText.layer.masksToBounds = YES;
        _mainText.layer.cornerRadius = 8;
        _mainText.backgroundColor = [UIColor whiteColor];
        _mainText.placeholder = @"请输入商家名、品类或商圈...";
        _mainText.font = [UIFont systemFontOfSize:13];
        UIImageView *searchLogo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        searchLogo.image = [UIImage imageNamed:@"search_logo"];
        _mainText.leftView = searchLogo;
        _mainText.leftViewMode = UITextFieldViewModeAlways;
        
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(270, 29, 28, 28)];
        _deleteBtn.layer.masksToBounds = YES;
        _deleteBtn.layer.cornerRadius = 12;
        //[_deleteBtn setBackgroundColor:MXCOLOR_GRAY];
        //_deleteBtn.alpha = 0.7;
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"search_delete.png"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnOnclick) forControlEvents:UIControlEventTouchUpInside];

        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
        _tableView.hidden = YES;
        _tableView.separatorStyle = NO;
        [self addSubview:_tableView];
        
    }
    return self;
}
- (void)deleteBtnOnclick{
    _deleteBtnBlock();
}
@end

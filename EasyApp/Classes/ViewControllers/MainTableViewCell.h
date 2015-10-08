//
//  MainTableViewCell.h
//  EasyApp
//
//  Created by liudonghuan on 15/9/26.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *typeLabel;
@property (nonatomic,retain) UILabel *nameLabel;
@property (nonatomic,retain) UILabel *priceLabel;
@property (nonatomic,retain) UILabel *ageLabel;
@property (nonatomic, strong) UIImageView *genderImageView;
@property (nonatomic, strong) UIImageView *priceIconImageView;

@property (nonatomic,strong) UIImageView *addressImageView;
@end

//
//  MainTableViewCell.m
//  EasyApp
//
//  Created by liudonghuan on 15/9/26.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 5, 100, 20)];
        _typeLabel.textColor = UIColorFromRGB(0x352e65);
        _typeLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_typeLabel];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(52, _typeLabel.EA_Bottom + 10, 100, 20)];
        _nameLabel.textColor = UIColorFromRGB(0x354e65);
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_nameLabel];
        
        _priceIconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(52, _nameLabel.EA_Bottom + 12, 16, 16)];
        _priceIconImageView.image = [UIImage imageNamed:@"priceicon_image"];
        [self addSubview:_priceIconImageView];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, _nameLabel.EA_Bottom + 10, 100, 20)];
        _priceLabel.textColor = UIColorFromRGB(0x354e65);
        _priceLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_priceLabel];
        
        _genderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _typeLabel.EA_Bottom + 10, 20, 20)];
        _genderImageView.EA_CenterX = self.EA_Width/2 + 40;
        _genderImageView.image = [UIImage imageNamed:@"gendericon_male"];
        [self addSubview:_genderImageView];
        
        _ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(270, _typeLabel.EA_Bottom + 10, 90, 20)];
        _ageLabel.textColor = UIColorFromRGB(0x354e65);
        _ageLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_ageLabel];
        
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, _priceLabel.EA_Bottom + 5, SCREEN_WIDTH, 5)];
        line.backgroundColor = UIColorFromRGB(0xe8e8e8);
        [self addSubview:line];
    }
    return self;
}

- (void)setSelected:(BOOL)selected{
    if (selected == YES) {
        self.backgroundColor = UIColorFromRGB(0xdddddd);
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end


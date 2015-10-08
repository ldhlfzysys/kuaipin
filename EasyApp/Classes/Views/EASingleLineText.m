//
//  EASingleLineText.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/23.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "EASingleLineText.h"

@implementation EASingleLineText

- (instancetype)initWithFrame:(CGRect)frame HeadTitle:(NSString *)title Content:(NSString *)content{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _headTitleLabel = [self labelWithFrame:CGRectMake(6, 0, 70, frame.size.height)];
        _contentLabel = [self labelWithFrame:CGRectMake(88, 0, SCREEN_WIDTH - 140, frame.size.height)];
        _headTitleLabel.text = title;
        _contentLabel.text = content;
        _contentLabel.numberOfLines = 0;
        [self addSubview:_headTitleLabel];
        [self addSubview:_contentLabel];
        _addressImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        _addressImage.EA_Right = frame.size.width - 15;
        _addressImage.EA_CenterY = frame.size.height/2;
        [self addSubview:_addressImage];
    }
    return self;
}

- (UILabel *)labelWithFrame:(CGRect)frame{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = UIColorFromRGB(0x6d6d6d);
    label.font = [UIFont systemFontOfSize:15];
    [self addSubview:label];
    return label;
}

@end

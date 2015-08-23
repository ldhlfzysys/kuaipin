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
        UILabel *headTitleLabel = [self labelWithFrame:CGRectMake(6, 0, 60, frame.size.height)];
        UILabel *contentLabel = [self labelWithFrame:CGRectMake(78, 0, SCREEN_WIDTH - 90, frame.size.height)];
        headTitleLabel.text = title;
        contentLabel.text = content;
        [self addSubview:headTitleLabel];
        [self addSubview:contentLabel];
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

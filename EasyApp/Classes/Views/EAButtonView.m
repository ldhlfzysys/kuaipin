//
//  EAButtonView.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/22.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "EAButtonView.h"

@implementation EAButtonView

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title ColorType:(BackgroundColorType)type{
    if (self = [super initWithFrame:frame]) {
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addTarget:self action:@selector(onclicked) forControlEvents:UIControlEventTouchUpInside];
        if (type == BackgroundColorTypeGreen) {
            [self setBackgroundImage:[UIImage imageNamed:@"buttonBackground_green"] forState:UIControlStateNormal];
        }else if (type == BackgroundColorTypeRed){
            [self setBackgroundImage:[UIImage imageNamed:@"buttonBackground_red"] forState:UIControlStateNormal];
        }
    }
    return self;
}

- (void)onclicked{
    _EAButtonClickBlock();
}

@end

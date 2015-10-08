//
//  EASingleLineText.h
//  EasyApp
//
//  Created by liudonghuan on 15/8/23.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EASingleLineText : UIView
@property(nonatomic,strong)UILabel *headTitleLabel;
@property(nonatomic,strong)UIImageView *addressImage;
@property(nonatomic,strong)UILabel *contentLabel;
- (instancetype)initWithFrame:(CGRect)frame HeadTitle:(NSString *)title Content:(NSString *)content;

@end

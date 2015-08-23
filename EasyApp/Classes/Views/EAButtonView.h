//
//  EAButtonView.h
//  EasyApp
//
//  Created by liudonghuan on 15/8/22.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BackgroundColorTypeGreen = 0,
    BackgroundColorTypeRed = 1,
}BackgroundColorType;

@interface EAButtonView : UIButton

@property (nonatomic, copy) void (^EAButtonClickBlock)(void);
- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title ColorType:(BackgroundColorType)type;

@end

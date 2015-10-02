//
//  ResetInfoViewController.h
//  EasyApp
//
//  Created by liudonghuan on 15/10/2.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EASingleLineInputView.h"
#import "EAButtonView.h"

typedef enum{
    ResetInfoTypeUserInfo = 0,
    ResetInfoTypePassword,
}ResetInfoType;

@interface ResetInfoViewController : UIViewController
@property (nonatomic,strong)EASingleLineInputView *userName;
@property (nonatomic,strong)EASingleLineInputView *gender;
@property (nonatomic,strong)EAButtonView *confirmButton;
- (instancetype)initWithType:(ResetInfoType)type;
@end

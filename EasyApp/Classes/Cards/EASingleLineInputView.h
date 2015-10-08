//
//  EASingleLineInputCardView.h
//  EasyApp
//
//  Created by liudonghuan on 15/8/21.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGenderSelectButton;
@class EAGetCheckCodeButton;
@class EAAreaSelect;

@interface EASingleLineInputView : UIView
@property (nonatomic, retain) UIImageView *separateLine;
@property (nonatomic, retain) UILabel *headTitle;
@property (nonatomic, retain) UITextField *contentTextField;

//性别
@property BOOL needGenderSelectButton;
@property (nonatomic, retain) EAGenderSelectButton *genderSelectButton;
//验证码按钮
@property BOOL needGetCheckCodeButton;
@property (nonatomic, retain) EAGetCheckCodeButton *getCheckCodeButton;
//地域选择
@property BOOL needAreaSelect;
@property (nonatomic, retain) EAAreaSelect *areaSelect;

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString*)title Placeholder:(NSString*)placeholder;
- (void)samePositionLike:(EASingleLineInputView *)singLineView;
@end

@interface EAGenderSelectButton : UIView

@property (nonatomic, retain)UILabel *maleLabel;
@property (nonatomic, retain)UILabel *femaleLabel;
@property (nonatomic, retain)UIButton *maleButton;
@property (nonatomic, retain)UIButton *femaleButton;
@property (nonatomic, retain)NSString *gender;
@property (nonatomic, strong)NSString *genderChinese;

@end



@interface EAGetCheckCodeButton : UIButton

@property (nonatomic,copy)void (^GetCheckCodeBlock)(void);
@property (nonatomic,retain)NSTimer *timer;
@property (nonatomic,retain)NSString *checkCode;


@end

@protocol EAAreaSelectDelegate <NSObject>

- (void)contentDidChange;

@end

@interface EAAreaSelect : UIView<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>
@property (nonatomic,retain) NSArray *areaArray;
@property (nonatomic,retain) UIPickerView *pickerView;
@property (nonatomic,retain) UILabel *areaLabel;
@property (nonatomic,retain) UIAlertView *alertView;
@property id<EAAreaSelectDelegate> delegate;
@end

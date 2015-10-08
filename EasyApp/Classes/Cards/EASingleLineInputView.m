//
//  EASingleLineInputCardView.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/21.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "EASingleLineInputView.h"

@implementation EASingleLineInputView

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString*)title Placeholder:(NSString*)placeholder{
    if (self = [super initWithFrame:frame]) {
        UIImageView *backgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        backgroundImage.image = [UIImage imageNamed:@"singleLineInputBackground"];
        [self addSubview:backgroundImage];
        _headTitle = [[UILabel alloc]init];
        _headTitle.font = [UIFont systemFontOfSize:15];
        _headTitle.EA_Left = 12;
        _headTitle.textColor = UIColorFromRGB(0x354e65);
        _headTitle.text = title;
        [_headTitle sizeToFit];
        _headTitle.EA_CenterY = self.EA_Height/2;
        [self addSubview:_headTitle];
        
        _separateLine = [[UIImageView alloc]init];
        _separateLine.backgroundColor = UIColorFromRGB(0xb0b0b0);
        _separateLine.frame = CGRectMake(_headTitle.EA_Right + 10, 0, 1, frame.size.height);
        [self addSubview:_separateLine];
        
        _contentTextField = [[UITextField alloc]initWithFrame:CGRectMake(_headTitle.EA_Right + 20, 0, self.EA_Width - (_headTitle.EA_Right + 30), self.EA_Height)];
        _contentTextField.placeholder = placeholder;
        [self addSubview:_contentTextField];
        
        _getCheckCodeButton = [[EAGetCheckCodeButton alloc]init];
        [self addSubview:_getCheckCodeButton];
        
        _genderSelectButton = [[EAGenderSelectButton alloc]init];
        [self addSubview:_genderSelectButton];
        
        _areaSelect = [[EAAreaSelect alloc]init];
        [self addSubview:_areaSelect];
        

       
        
        
        
    }
    return self;
}

- (void)samePositionLike:(EASingleLineInputView *)singLineView{
    self.headTitle.center = singLineView.headTitle.center;
    self.separateLine.center = singLineView.separateLine.center;
    self.contentTextField.frame = singLineView.contentTextField.frame;
    self.contentTextField.center = singLineView.contentTextField.center;
}

- (void)layoutSubviews{
    if (_needGetCheckCodeButton) {
        _getCheckCodeButton.frame = CGRectMake(self.EA_Width - 90 , 0, 90, 30);
    }else{
        _getCheckCodeButton.hidden = YES;
    }
    if (_needGenderSelectButton){
        _genderSelectButton.frame = CGRectMake(_headTitle.EA_Right + 20, 0, 100, 30);
        _contentTextField.hidden = YES;
    }else{
        _genderSelectButton.hidden = YES;
    }
    if (_needAreaSelect) {
        _areaSelect.frame = CGRectMake(_headTitle.EA_Right + 20, 0, 100, 30);
        _contentTextField.hidden = YES;
    }else{
        _areaSelect.hidden = YES;
    }
}



//- (void)dealloc{
//    [_separateLine release],_separateLine = nil;
//    [_headTitle release],_headTitle = nil;
//    [_contentTextField retain],_contentTextField = nil;
//    if (_needGenderSelectButton) {
//        [_genderSelectButton release],_genderSelectButton = nil;
//    }
//    if (_needGetCheckCodeButton) {
//        [_getCheckCodeButton release],_getCheckCodeButton = nil;
//    }
//    [super dealloc];
//}



@end

typedef enum {
    GenderTypeFemale = 0,
    GenderTypeMale = 1,
    
}GenderType;

@implementation EAGenderSelectButton
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _maleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 10, 10)];
        [_maleButton setBackgroundImage:[UIImage imageNamed:@"buttonSelected"] forState:UIControlStateSelected];
        [_maleButton setBackgroundImage:[UIImage imageNamed:@"buttonUnselected"] forState:UIControlStateNormal];
        _maleButton.selected = YES;
        _maleButton.tag = GenderTypeMale;
        [_maleButton addTarget:self action:@selector(buttonOnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_maleButton];
        _maleLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 0, 20, 30)];
        _maleLabel.text = @"男";
        _gender = @"1";
        _maleLabel.font = [UIFont systemFontOfSize:13];
        _maleLabel.textColor = UIColorFromRGB(0x354e65);
        [self addSubview:_maleLabel];
        
        _femaleButton = [[UIButton alloc]initWithFrame:CGRectMake(39, 10, 10, 10)];
        [_femaleButton setBackgroundImage:[UIImage imageNamed:@"buttonSelected"] forState:UIControlStateSelected];
        [_femaleButton setBackgroundImage:[UIImage imageNamed:@"buttonUnselected"] forState:UIControlStateNormal];
        _femaleButton.selected = NO;
        _femaleButton.tag = GenderTypeFemale;
        [_femaleButton addTarget:self action:@selector(buttonOnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_femaleButton];
        _femaleLabel = [[UILabel alloc]initWithFrame:CGRectMake(53, 0, 30, 30)];
        _femaleLabel.text = @"女";
        _femaleLabel.font = [UIFont systemFontOfSize:13];
        _femaleLabel.textColor = UIColorFromRGB(0x354e65);
        [self addSubview:_femaleLabel];
        
    }
    return self;
}

- (void)buttonOnclicked:(UIButton *)btn{
    if (btn.tag == GenderTypeMale) {
        _maleButton.selected = YES;
        _femaleButton.selected = NO;
        _gender = @"1";
        _genderChinese = @"男";
    }else{
        _maleButton.selected = NO;
        _femaleButton.selected = YES;
        _gender = @"0";
        _genderChinese = @"女";
    }
}
@end

@implementation EAGetCheckCodeButton
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(getCheckCodeClicked) forControlEvents:UIControlEventTouchUpInside];
        [self setBackgroundImage:[UIImage imageNamed:@"getCheckCodeBackground"] forState:UIControlStateNormal];
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
//        NSString *checkCodeTimeStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"checkCodeTime"];
//        if (checkCodeTimeStr!= nil) {
//            if (![checkCodeTimeStr isEqualToString:@"获取验证码"]) {
//                [self setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"checkCodeTime"] forState:UIControlStateNormal];
//                [_timer fire];
//            }
//        }
        
    }
    return self;
}


- (void)countDown{
    if ([self.titleLabel.text integerValue] <= 0) {
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.enabled = YES;
        //[[NSUserDefaults standardUserDefaults] setObject:self.titleLabel.text forKey:@"checkCodeTime"];
        [_timer invalidate];
    }else{
        self.enabled = NO;
        [self setTitle:[NSString stringWithFormat:@"%d",([self.titleLabel.text integerValue] - 1)] forState:UIControlStateNormal];
        //[[NSUserDefaults standardUserDefaults] setObject:self.titleLabel.text forKey:@"checkCodeTime"];
    }
}

- (void)getCheckCodeClicked{
    _GetCheckCodeBlock();
}

@end

@implementation EAAreaSelect

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openPickerView)];
        [self addGestureRecognizer:tapGesture];
        _alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 240, 100)];
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            [_alertView setValue:_pickerView forKey:@"accessoryView"];
        }else{
            [_alertView addSubview:_pickerView];
        }
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _areaArray = [[NSArray alloc]initWithObjects:@"不限",@"滨海新区",@"南开区",@"和平区",@"红桥区",@"河西区",@"河东区",@"河北区",@"北辰区",@"津南区",@"东丽区",@"蓟县",@"西青区",@"武清区",@"静海县",@"宝坻区",@"宁河县", nil];
        
        _areaLabel = [[UILabel alloc]init];
        _areaLabel.textAlignment = NSTextAlignmentCenter;
        _areaLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_areaLabel];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _areaLabel.EA_Width = self.EA_Width;
    _areaLabel.EA_Height = self.EA_Height;
}

- (void)openPickerView{
    [_pickerView setShowsSelectionIndicator:YES];
    [_alertView show];
}

#pragma pickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _areaArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_areaArray objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _areaLabel.text = [_areaArray objectAtIndex:row];
    _alertView.hidden = YES;
    [_delegate contentDidChange];
}

@end

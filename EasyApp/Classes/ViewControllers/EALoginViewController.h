//
//  EALoginViewController.h
//  EasyApp
//
//  Created by liudonghuan on 15/8/22.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EASingleLineInputView.h"
#import "EAButtonView.h"
@interface EALoginViewController : UIViewController

@property (nonatomic, retain) EASingleLineInputView *nameInput;
@property (nonatomic, retain) EASingleLineInputView *passwordInput;

@property (nonatomic, retain) EAButtonView *loginBtn;
@property (nonatomic, retain) EAButtonView *registerBtn;
@property (nonatomic, retain) EAButtonView *findPasswrodBackBtn;
@end

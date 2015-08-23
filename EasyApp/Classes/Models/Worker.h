//
//  Worker.h
//  EasyApp
//
//  Created by liudonghuan on 15/8/16.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EABaseModel.h"
@interface Worker : EABaseModel
@property (nonatomic, retain) NSString *uuid;
@property (nonatomic, retain) NSString *userUuid;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *userMobile;
@property (nonatomic, retain) NSString *workerName;
@property (nonatomic, assign) NSInteger workerAge;
@property (nonatomic, retain) NSString *workerGender;
@property (nonatomic, retain) NSString *workerMobile;
@property (nonatomic, retain) NSString *workerSkill;//技能
@property (nonatomic, retain) NSString *serviceRegion;//服务区域
@property (nonatomic, assign) NSInteger ifDelete;
@property (nonatomic, retain) NSString *insertTime;
@end

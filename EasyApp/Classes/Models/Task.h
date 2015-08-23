//
//  Task.h
//  EasyApp
//
//  Created by liudonghuan on 15/8/16.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EABaseModel.h"
@interface Task : EABaseModel
@property (nonatomic, retain) NSString *uuid;
@property (nonatomic, retain) NSString *userUuid;//发布者
@property (nonatomic, retain) NSString *userName;//发布者姓名
@property (nonatomic, retain) NSString *taskInfo;//任务内容
@property (nonatomic, assign) CGFloat taskFee;//任务费用
@property (nonatomic, retain) NSString *taskAddress;//地点
@property (nonatomic, retain) NSString *userMobile;//发布者手机号
@property (nonatomic, assign) NSInteger ifDelete;
@property (nonatomic, retain) NSString *insertTime;
@end

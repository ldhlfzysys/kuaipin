//
//  Task.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/16.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "Task.h"

@implementation Task
- (BOOL)userFromDictionary:(NSDictionary *)dict
{
    self.userName = [dict EA_stringForKey:@"userName"];
    self.uuid = [dict EA_stringForKey:@"uuid"];
    self.userUuid = [dict EA_stringForKey:@"userUuid"];
    self.userName = [dict EA_stringForKey:@"userName"];
    self.taskInfo = [dict EA_stringForKey:@"taskInfo"];
    self.taskFee = [dict EA_integerForKey:@"taskFee"];
    self.taskAddress = [dict EA_stringForKey:@"taskAddress"];
    self.userMobile = [dict EA_stringForKey:@"userMobile"];
    self.ifDelete = [dict EA_integerForKey:@"ifDelete"];
    self.insertTime = [dict EA_stringForKey:@"insertTime"];
    return true;
}


@end

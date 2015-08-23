//
//  Worker.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/16.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "Worker.h"

@implementation Worker
- (BOOL)userFromDictionary:(NSDictionary *)dict
{
    self.uuid = [dict EA_stringForKey:@"uuid"];
    self.userUuid = [dict EA_stringForKey:@"userUuid"];
    self.userName = [dict EA_stringForKey:@"userName"];
    self.userMobile = [dict EA_stringForKey:@"userMobile"];
    self.workerName = [dict EA_stringForKey:@"workerName"];
    self.workerAge = [dict EA_integerForKey:@"workerAge"];
    self.workerGender = [dict EA_stringForKey:@"workerGender"];
    self.workerMobile = [dict EA_stringForKey:@"workerMobile"];
    self.workerSkill = [dict EA_stringForKey:@"workerSkill"];
    self.serviceRegion = [dict EA_stringForKey:@"serviceRegion"];
    self.ifDelete = [dict EA_integerForKey:@"ifDelete"];
    self.insertTime = [dict EA_stringForKey:@"insertTime"];
    return true;
}


@end

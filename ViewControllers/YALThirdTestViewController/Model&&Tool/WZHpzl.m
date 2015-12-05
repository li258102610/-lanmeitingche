//
//  WZHpzl.m
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/6.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import "WZHpzl.h"

@implementation WZHpzl

- (instancetype) initWithHpzl:(NSDictionary *)hpzlDic {
    
    self = [super init];
    if (!self) {
        return nil ;
    }
    self.car = [hpzlDic objectForKey:@"car"];
    self.iD = [hpzlDic objectForKey:@"id"];
    
    return self;
}

@end

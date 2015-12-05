//
//  WZCity.m
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/6.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import "WZCity.h"

@implementation WZCity

- (instancetype) initWithCity:(NSDictionary *)citylDic {
    
    self = [super init];
    if (!self) {
        return nil ;
    }
    
    _cityName = [citylDic objectForKey:@"city_name"];
    _cityCode = [citylDic objectForKey:@"city_code"];
    _abbr = [citylDic objectForKey:@"abbr"];
    _engine = [citylDic objectForKey:@"engine"];
    _engineno = [citylDic objectForKey:@"engineno"];
    _class_wz = [citylDic objectForKey:@"class"];
    _classno = [citylDic objectForKey:@"classno"];
    _regist = [citylDic objectForKey:@"regist"];
    _registno = [citylDic objectForKey:@"registno"];
    
    return self;
}

@end

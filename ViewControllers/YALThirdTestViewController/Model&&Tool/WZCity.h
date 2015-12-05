//
//  WZCity.h
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/6.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZCity : NSObject

@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSString *cityCode;
@property (strong, nonatomic) NSString *abbr;
@property (strong, nonatomic) NSString *engine;
@property (strong, nonatomic) NSString *engineno;
@property (strong, nonatomic) NSString *class_wz;
@property (strong, nonatomic) NSString *classno;
@property (strong, nonatomic) NSString *regist;
@property (strong, nonatomic) NSString *registno;


- (instancetype) initWithCity:(NSDictionary *)citylDic ;

@end

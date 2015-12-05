//
//  WZProvince.h
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/13.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZCity.h"

@interface WZProvince : NSObject

@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,strong) NSArray *cityArray;
@property (nonatomic ,strong) NSString *province_code;

- (instancetype) initWithProvince:(NSDictionary *)provinceDic ;

@end

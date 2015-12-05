//
//  ProvinceResult.h
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/13.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZProvince.h"

@interface ProvinceResult : NSObject

@property (nonatomic ,strong) NSString *error_code;
@property (nonatomic ,strong) NSString *reason;
@property (nonatomic ,strong) NSArray *result;

- (instancetype)initWithProvinceJson:(id)responseObject;

@end

//
//  HpzlResult.h
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/13.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZHpzl.h"

@interface HpzlResult : NSObject

@property (nonatomic ,strong) NSString *errorCode;
@property (nonatomic ,strong) NSString *reason;
@property (nonatomic ,strong) NSArray *result;

- (instancetype)initWithHpzlJson:(id)responseObject;

@end

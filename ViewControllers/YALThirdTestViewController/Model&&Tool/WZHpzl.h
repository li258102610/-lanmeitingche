//
//  WZHpzl.h
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/6.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZHpzl : NSObject

@property (strong, nonatomic) NSString *car;
@property (strong, nonatomic) NSString *iD ;

- (instancetype) initWithHpzl:(NSDictionary *)hpzlDic ;

@end

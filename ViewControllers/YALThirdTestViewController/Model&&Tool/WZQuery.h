//
//  WZQuery.h
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/6.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZQuery : NSObject

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *area;
@property (strong, nonatomic) NSString *act;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *fen;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSString *handled;

- (instancetype) initWithQuery:(NSDictionary *)query ;


@end

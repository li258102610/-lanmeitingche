//
//  WZQuery.m
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/6.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import "WZQuery.h"

@implementation WZQuery

- (instancetype) initWithQuery:(NSDictionary *)query{
    
    self = [super init];
    if (!self) {
        return nil;
    }
    _date =     [self notNil:[query objectForKey:@"date"]];
    _area =     [self notNil:[query objectForKey:@"area"]];
    _act =      [self notNil:[query objectForKey:@"act"]];
    _code =     [self notNil:[query objectForKey:@"code"]];
    _fen =      [self notNil:[query objectForKey:@"fen"]];
    _money =    [self notNil:[query objectForKey:@"money"]];
    _handled =  [self notNil:[query objectForKey:@"handled"]];
    
    return self;
}

- (NSString *)notNil:(id)obj{
    
    if (![obj isKindOfClass:[NSNull class]]&&[[NSString stringWithFormat:@"%@",obj] length]>0) {
        return [NSString stringWithFormat:@"%@",obj];
    }else{
        return @"--";
    }
}

@end

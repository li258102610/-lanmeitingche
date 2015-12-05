//
//  ProvinceResult.m
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/13.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import "ProvinceResult.h"

@implementation ProvinceResult

- (instancetype)initWithProvinceJson:(id)responseObject{
    
    self = [super init];
    if (!self) {
        return nil;
    }
    NSDictionary *jsonDic = (NSDictionary *)responseObject;
    [self setResultWith:jsonDic];
    
    return self;
}

- (void)setResultWith:(NSDictionary *)jsonDic{
    NSString *errorCode =  [NSString stringWithFormat:@"%@",[jsonDic objectForKey:@"error_code"]];
    NSString *reason = [jsonDic objectForKey:@"reason"];
    NSDictionary *result = [jsonDic objectForKey:@"result"];
    
    _error_code = errorCode;
    _reason = reason;
    
    if ([errorCode isEqualToString:@"0"]) {
        
        NSArray *provinceArray = [result allValues];
        NSMutableArray *models = [NSMutableArray new];
        for (NSDictionary *province in provinceArray) {
            WZProvince *model = [[WZProvince alloc] initWithProvince:province];
            [models addObject:model];
        }
        _result = [models  copy];
    }else{
        _result = @[];
    }
}
@end

//
//  HpzlResult.m
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/13.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import "HpzlResult.h"

@implementation HpzlResult

-(instancetype)initWithHpzlJson:(id)responseObject{
    self = [super init];
    if (!self) {
        return nil;
    }
    NSDictionary *jsonDic = (NSDictionary *)responseObject;
    [self setResultWith:jsonDic];
    
    return self;
}

- (void)setResultWith:(NSDictionary *)jsonDic{

    NSString *errorCode = [NSString stringWithFormat:@"%@",[jsonDic objectForKey:@"error_code"]];
    NSString *reason = [jsonDic objectForKey:@"reason"];
    NSArray *result = [jsonDic objectForKey:@"result"];
    
    _errorCode = errorCode;
    _reason = reason;
    
    if ([errorCode isEqualToString:@"0"]) {

        NSMutableArray *oldArray = [result mutableCopy];
        for (int i=0; i<[oldArray count]; i++) {
            NSDictionary *hpzl = [oldArray objectAtIndex:i];
            WZHpzl *model = [[WZHpzl alloc]initWithHpzl:hpzl];
            [oldArray replaceObjectAtIndex:i withObject:model];
        }
        _result = [oldArray copy];
    }else{
        _result = @[];
    }

}

@end

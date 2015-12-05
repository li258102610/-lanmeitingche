//
//  QueryResult.m
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/13.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import "QueryResult.h"

@implementation QueryResult

- (instancetype)initWithQueryJson:(id)responseObject{

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
    NSDictionary *result = [jsonDic objectForKey:@"result"];
    
    _errorCode = errorCode;
    _reason = reason;
    
    if ([errorCode isEqualToString:@"0"]) {
        NSArray *lists = [result objectForKey:@"lists"];
        NSMutableArray *oldArray = [lists mutableCopy];
        
        for (int i=0; i<[oldArray count]; i++) {
            NSDictionary *query = [oldArray objectAtIndex:i];
            WZQuery *model = [[WZQuery alloc]initWithQuery:query];
            [oldArray replaceObjectAtIndex:i withObject:model];
        }
        
        _result = [self sorteddArrayWithDate:oldArray];
        
    }else{
        _result = @[];
    }
    
}

- (NSArray *)sorteddArrayWithDate:(NSMutableArray *)array{

    NSArray *oldarray = [array copy];
    NSArray *newArray =  [oldarray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        WZQuery *wz1 = obj1;
        WZQuery *wz2 = obj2;
        
        NSDate *date1 =  [self dateFromString:wz1.date];
        NSDate *date2 =  [self dateFromString:wz2.date];
        
        if (date1 < date2) {
            return NSOrderedDescending;
        }else if (date1 >date2){
            return NSOrderedAscending;
        }else{
            return NSOrderedSame;
        }
    }];
    return newArray;
}

- (NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];

    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

@end

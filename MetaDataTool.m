//
//  MetaDataTool.m
//  ZTMapSection
//
//  Created by Tong Zhao on 15/11/13.
//  Copyright © 2015年 ZhTg. All rights reserved.
//

#import "MetaDataTool.h"

@implementation MetaDataTool
+(NSArray*)parkingPoints:(id)responseObject{
    if (!responseObject) {
        return nil;
    }
    NSMutableArray* parkingPointMutArray = [NSMutableArray array];
    NSArray* responseArray = responseObject[@"result"];
    for (NSDictionary* parkPointDic in responseArray) {
        ParkingInfo* park = [ParkingInfo new];
        [park setValuesForKeysWithDictionary:parkPointDic];
        [parkingPointMutArray addObject:park];
    }
    return [parkingPointMutArray copy];
}
@end

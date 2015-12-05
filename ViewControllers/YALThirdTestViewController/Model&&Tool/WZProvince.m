//
//  WZProvince.m
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/13.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import "WZProvince.h"

@implementation WZProvince

- (instancetype) initWithProvince:(NSDictionary *)provinceDic {

    self = [super init];
    if (!self) {
        return nil ;
    }
    NSDictionary *province = [provinceDic copy];
    
    self.name = [province objectForKey:@"province"];
    self.cityArray = [self setCitysWith:[province objectForKey:@"citys"]];
    self.province_code = [province objectForKey:@"province_code"];
                          
    return self;
}

- (NSArray *) setCitysWith:(NSArray *)citys{
    NSMutableArray *oldArray = [citys mutableCopy];
    for (int i=0; i<[oldArray count]; i++) {
        NSDictionary *city = [oldArray objectAtIndex:i];
        WZCity *model = [[WZCity alloc]initWithCity:city];
        [oldArray replaceObjectAtIndex:i withObject:model];
    }
    return [oldArray copy];
}
@end

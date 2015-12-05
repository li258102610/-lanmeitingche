//
//  MetaDataTool.h
//  ZTMapSection
//
//  Created by Tong Zhao on 15/11/13.
//  Copyright © 2015年 ZhTg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParkingInfo.h"

@interface MetaDataTool : NSObject

+(NSArray*)parkingPoints:(id)responseObject;
@end

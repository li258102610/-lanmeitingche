//
//  customAnnotation.h
//  ZTMapSection
//
//  Created by tarena_ZHTG on 15/11/16.
//  Copyright © 2015年 ZhTg. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

@interface customAnnotation : BMKPointAnnotation

@property(nonatomic,assign)int totalPark;
@property(nonatomic,assign)int emptyPark;

@property(nonatomic,strong)NSString* parkingName;
@property(nonatomic,strong)NSString* parkingAddress;
@property(nonatomic,strong)NSString* openTime;
@property(nonatomic,strong)NSString* closeTime;
@property(nonatomic,strong)NSString* dayParkingPrice;
@property(nonatomic,strong)NSString* nightParkingPrice;
@property(nonatomic,strong)NSString* trackPrice;
@property(nonatomic,strong)NSString* carPrice;
@property(nonatomic,strong)NSURL* parkImageURL;
@end

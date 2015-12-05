//
//  ParkAnnotation.h
//  ZTMapSection
//
//  Created by Tong Zhao on 15/11/11.
//  Copyright © 2015年 ZhTg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ParkAnnotation : NSObject<MKAnnotation>
//声明一个坐标属性
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
//title/subtitle属性可选
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
//设定大头针的自定义图片
@property (nonatomic, strong) UIImage *image;
@end

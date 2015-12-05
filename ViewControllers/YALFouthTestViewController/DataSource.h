//
//  DataSoruce.h
//  OilPrice
//
//  Created by zzp_pc on 15/11/12.
//  Copyright © 2015年 zzp_pc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject

@property (nonatomic,strong)NSString        *address;
@property (nonatomic,strong)NSString        *area;
@property (nonatomic,strong)NSString        *areaname;
@property (nonatomic,strong)NSString        *brandname;
@property (nonatomic,strong)NSString        *discount;
@property (nonatomic,assign)double          distance;
@property (nonatomic,strong)NSString        *exhaust;
@property (nonatomic,strong)NSDictionary    *gastprice;
@property (nonatomic,assign)int             id;
@property (nonatomic,assign)float           lat;
@property (nonatomic,assign)float           lon;
@property (nonatomic,strong)NSString        *name;
@property (nonatomic,strong)NSString        *position;
@property (nonatomic,strong)NSDictionary    *price;
@property (nonatomic,strong)NSString        *type;
@property (nonatomic,strong)NSString        *fwlsmc;

@end

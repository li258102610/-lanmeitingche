//
//  ViewController.h
//  NaviDemo
//
//  Created by Baidu on 14/12/18.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>

@interface PhoneGPSViewController : UIViewController

@property(nonatomic,assign)CLLocationDegrees startLatitude;
@property(nonatomic,assign)CLLocationDegrees startLongitude;

@property(nonatomic,assign)CLLocationDegrees endLatitude;
@property(nonatomic,assign)CLLocationDegrees endLongitude;

@end


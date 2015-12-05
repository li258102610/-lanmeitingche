//
//  ParkViewController.h
//  ZTMapSection
//
//  Created by Tong Zhao on 15/11/10.
//  Copyright © 2015年 ZhTg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <CoreLocation/CoreLocation.h>

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
//geosearch
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
//聚合数据
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "customAnnotation.h"
#import "OilPriceViewContro.h"

@protocol sendLatAndLon <NSObject>

- (void)getLat:(float)lat lon:(float)lon;

@end

@interface ParkViewController : UIViewController <BMKMapViewDelegate, BMKPoiSearchDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
@property (nonatomic)id <sendLatAndLon> delegate;

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property(nonatomic,strong)BMKLocationService* locService;
@property (weak, nonatomic) IBOutlet UIButton *startLocationBtn;

@property (weak, nonatomic) IBOutlet UIButton   *roadConditionBtnOff;
@property (weak, nonatomic) IBOutlet UIButton   *roadConditionBtnOn;
@property (weak, nonatomic) IBOutlet UIView     *mapLevelView;

@property (weak, nonatomic) IBOutlet UITextField *interestPlaceTextField;
@property(nonatomic,strong)BMKGeoCodeSearch* geocodesearch;
@property (weak, nonatomic) IBOutlet UIButton *addMapviewBtn;
@property (weak, nonatomic) IBOutlet UIButton *subMapviewBtn;
@property (weak, nonatomic) IBOutlet UIButton *naviButton;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UIButton *flatButton;
@property (weak, nonatomic) IBOutlet UIButton *gpsButton;

//curentPoint
@property(nonatomic,assign)CLLocationDegrees currentLatitude;
@property(nonatomic,assign)CLLocationDegrees currentLongitude;
@property(nonatomic,assign)CLLocationDegrees endLatitude;
@property(nonatomic,assign)CLLocationDegrees endLongitude;
//@property(nonatomic,assign)CLLocationCoordinate2D userlocationCoordinate;

//选中的annotation
@property(nonatomic,strong)customAnnotation* selectedAnnotation;


@end

//
//  ParkViewController.m
//  ZTMapSection
//
//  Created by Tong Zhao on 15/11/10.
//  Copyright © 2015年 ZhTg. All rights reserved.
//

#import "ParkViewController.h"
#import "ParkAnnotation.h"
#import "ParkingDetailViewController.h"
#import "MetaDataTool.h"
#import "ParkingInfo.h"
#import "PhoneGPSViewController.h"
#import "SVProgressHUD.h"
#define debug 1

@interface ParkViewController ()
@property (nonatomic, strong) BMKPoiSearch *poiSearch;
//CLLocation属性，用于定位
@property(nonatomic,strong)CLLocationManager  *locationManager;

@property(nonatomic,assign) BOOL isGeoSearch;
@property (weak, nonatomic) IBOutlet UIImageView *addSubImg;


@end

@implementation ParkViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)tabBarViewWillCollapse {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)tabBarViewWillExpand {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)tabBarViewDidCollapse {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)tabBarViewDidExpand {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化地图视图对象
//    self.mapView = [[BMKMapView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:@"JH80a161ddd046c15586eadd1f0c66972e"];
    _locService = [[BMKLocationService alloc]init];
    self.currentLatitude = 0;
    self.currentLongitude = 0;
    self.endLongitude = 0;
    self.endLatitude = 0;
    //添加到view上
    [self.view addSubview:self.mapView];
    [self.mapView addSubview:self.startLocationBtn];
    [self.mapView addSubview:self.naviButton];
    
    [self.mapView addSubview:self.mapLevelView];
    [self.mapLevelView addSubview:self.addSubImg];
    [self.mapLevelView addSubview:self.addMapviewBtn];
    [self.mapLevelView addSubview:self.subMapviewBtn];
    
    [self.mapView addSubview:self.roadConditionBtnOff];
    [self.mapView addSubview:self.roadConditionBtnOn];
    self.roadConditionBtnOn.hidden = YES;
    self.roadConditionBtnOn.enabled = NO;
    
    [self.mapView addSubview:self.flatButton];
    [self.mapView addSubview:self.gpsButton];
    self.gpsButton.hidden = YES;
    self.gpsButton.enabled = NO;

    
    self.naviButton.hidden = YES;
    //设置地图缩放比例
    [_mapView setZoomLevel:10];
    //初始化地理编码
    _geocodesearch=[[BMKGeoCodeSearch alloc]init];
    //初始化poi搜岁对象
    _poiSearch = [[BMKPoiSearch alloc]init];
    
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //由于IOS8中定位的授权机制改变 需要进行手动授权
        self.locationManager = [[CLLocationManager alloc] init];
        //获取授权认证
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
        self.navigationController.navigationBar.translucent = NO;
    }
    //定位：
    [_locService startUserLocationService];
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位位置
 
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _poiSearch.delegate = self; //设置代理(获取搜索的结果)
}
-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geocodesearch.delegate = nil; // 不用时，置nil
    _poiSearch.delegate = nil;
}

/**
 *地图初始化完毕时会调用此接口
 *@param mapview 地图View
 */
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView{
    
}
//开启定位
- (IBAction)startLocation:(id)sender {
    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    //    [self.startLocationBtn setEnabled:NO];
    //    [_mapView setZoomLevel:16];
//    [self.startLocationBtn setAlpha:0.6];
    
}
- (IBAction)clickRoadContidionOff:(UIButton*)sende
{
    self.roadConditionBtnOff.hidden = YES;
    self.roadConditionBtnOff.enabled = NO;
    self.roadConditionBtnOn.hidden = NO;
    self.roadConditionBtnOn.enabled = YES;
    [_mapView setTrafficEnabled:YES];
}
- (IBAction)clickRoadConditionOn:(id)sender {
    self.roadConditionBtnOff.hidden = NO;
    self.roadConditionBtnOff.enabled = YES;
    self.roadConditionBtnOn.hidden = YES;
    self.roadConditionBtnOn.enabled = NO;
    [_mapView setTrafficEnabled:NO];
}


//更改地图模式
- (IBAction)clickFlatMode:(id)sender {
    self.flatButton.hidden = YES;
    self.flatButton.enabled = NO;
    self.gpsButton.hidden = NO;
    self.gpsButton.enabled = YES;
    _mapView.mapType = BMKMapTypeSatellite;
}

- (IBAction)clickGpsMode:(id)sender {
    self.flatButton.hidden = NO;
    self.flatButton.enabled = YES;
    self.gpsButton.hidden = YES;
    self.gpsButton.enabled = NO;
    _mapView.mapType = BMKMapTypeStandard;
    
}


#pragma mark - GEOSEARCH

- (IBAction)geoSearch:(id)sender {
    [sender resignFirstResponder];
    _isGeoSearch = true;
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    if (self.regionLabel.text == nil) {
        geocodeSearchOption.city = @"北京";
    }
    geocodeSearchOption.city = self.regionLabel.text;
    geocodeSearchOption.address = self.interestPlaceTextField.text;
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
    [self.interestPlaceTextField resignFirstResponder];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.interestPlaceTextField resignFirstResponder];
}
//开启菜单栏
- (IBAction)swipeUserInfo:(id)sender {
    AppDelegate* delegate = [[UIApplication sharedApplication]delegate];
    [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        //    ***************** LIFE ***************
        //    /*IP*/
        NSString *path = @"http://api2.juheapi.com/park/query";
        NSString *api_id = @"133";
        NSString *method = @"GET";
        NSDictionary *param = @{@"kw":self.interestPlaceTextField.text,
                                @"lon": @(result.location.longitude),
                                @"lat": @(result.location.latitude),
                                @"distance":@(2000),
                                @"limit":@(50),
                                @"key":@"2f895ddf171ed0e69d30f1805c3cb13b"};
        JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
        [SVProgressHUD showWithStatus:@"正在加载..."];
        
        [juheapi executeWorkWithAPI:path
                              APIID:api_id
                         Parameters:param
                             Method:method
                            Success:^(id responseObject){
                                [SVProgressHUD dismiss];
                                if ([[param objectForKey:@"dtype"] isEqualToString:@"xml"]) {
                                    NSLog(@"***xml*** \n %@", responseObject);
                                }else{
                                    int error_code = [[responseObject objectForKey:@"error_code"] intValue];
                                    if (!error_code) {
                                        NSLog(@"数据读取成功！！！ %@", responseObject);
                                        NSArray* parkingInfoArray = [MetaDataTool parkingPoints:responseObject];
//                                        static int annoTag = 1;
                                        for (ParkingInfo* parkInfo in parkingInfoArray) {
                                #warning 百度自带的大头针，可修改
                                            customAnnotation* item = [[customAnnotation alloc]init];
//                                            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
                                            item.coordinate = CLLocationCoordinate2DMake([parkInfo.LOC[@"lat"] doubleValue], [parkInfo.LOC[@"lon"] doubleValue]);
                                            item.title = parkInfo.CCMC;
                                            item.subtitle = parkInfo.BTTCJG;
                                            item.parkingName = parkInfo.CCMC;
                                            item.parkingAddress = parkInfo.CCDZ;
                                            item.openTime = parkInfo.YYKSSJ;
                                            item.dayParkingPrice = parkInfo.BTTCJG;
                                            item.nightParkingPrice = parkInfo.WSTCJG;
                                            item.trackPrice = parkInfo.JCSFA;
                                            item.carPrice = parkInfo.JCSFB;
                                            item.parkImageURL = [NSURL URLWithString:parkInfo.CCTP];
                                            item.totalPark = parkInfo.ZCW;
                                            item.emptyPark = parkInfo.KCW;
                                            item.closeTime = parkInfo.YYJSSJ;
                                            self.regionLabel.text = parkInfo.QYCS;
                                            
                                            [self.mapView addAnnotation:item];
//                                            self.mapView setCenterCoordinate:info.pt animated:YES];
                                            [self.mapView setZoomLevel:16];
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                 _mapView.centerCoordinate = item.coordinate;
                                            });
                                            
//                                            annoTag++;
                                            
                                        }

                                    }else{
                                        NSLog(@"数据读取失败！%@", responseObject);
                                    }
                                }
                            } Failure:^(NSError *error) {
                                NSLog(@"error:   %@",error.description);
                            }];
        
//***************搜索停车场***************
//        BMKNearbySearchOption* option = [BMKNearbySearchOption new];
//        option.location = result.location;
//        option.radius = 50000;
//        option.keyword = @"停车场";
//        option.sortType = 0;
//        BOOL isSuccess = [self.poiSearch poiSearchNearBy:option];
//        if (!isSuccess) {
//            NSLog(@"附近搜索失败!!");
//        }
    }
}

//添加大头针的时候, 自动地调用该方法
//添加多少大头针，就会调用多少次该方法
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    //使用MKAnnotationView类来自定义大头针视图
    //1.把用户当前的位置对应大头针对象排除
    if ([annotation isKindOfClass:[BMKUserLocation class]]) {
        return nil;
    }
    //2.使用大头针视图的重用机制来创建/获取大头针视图
    static NSString *identifier = @"annotationView";
    BMKPinAnnotationView *pinAnnotationView = (BMKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!pinAnnotationView) {
        //创建新的pin大头针视图
        pinAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        //4.手动设置属性才可以点中弹出框
        pinAnnotationView.canShowCallout = YES;
        //设置大头针图标
//        ((BMKPinAnnotationView*)newAnnotation).image = [UIImage imageNamed:@"zhaohuoche"];
        //设定大头针颜色 (iOS9属性变化/颜色变化)
        //pinAnnotationView.pinColor = MKPinAnnotationColorPurple;
        //设置一个从天而降的动画
        //5.设置大头针视图的图片必须不能和动画一起设置(要想设置视图的图片，设置动画为no)
        pinAnnotationView.animatesDrop = NO;

        //6.设置大头针视图的左右自定义视图
//        UIImageView* leftImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_classify_cafe"]];
//        pinAnnotationView.leftCalloutAccessoryView = leftImg;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        button.imageView.image= [UIImage imageNamed:@"icon_compass_background"];
        [button addTarget:self action:@selector(clickParkDetailButton) forControlEvents:UIControlEventTouchUpInside];
        pinAnnotationView.rightCalloutAccessoryView = button;
 
    } else {
        //把annotation直接赋值给已经存在大头针视图
        pinAnnotationView.annotation = annotation;
    }
    //将创建好的AnnotationView返回回去
    return pinAnnotationView;
    //    return nil;

}
//点击大头针，触发方法
-(void)clickParkDetailButton{
    
    ParkingDetailViewController* parkingDetail = [ParkingDetailViewController new];
    parkingDetail.parkingName       = self.selectedAnnotation.title;
    parkingDetail.totalPark         = self.selectedAnnotation.totalPark;
    parkingDetail.emptyPark         = self.selectedAnnotation.emptyPark;
    
    parkingDetail.parkingAddress    = self.selectedAnnotation.parkingAddress;
    parkingDetail.openTime          = self.selectedAnnotation.openTime;
    parkingDetail.closeTime         = self.selectedAnnotation.closeTime;
    parkingDetail.dayParkingPrice   = self.selectedAnnotation.dayParkingPrice;
    parkingDetail.nightParkingPrice = self.selectedAnnotation.nightParkingPrice;
    parkingDetail.trackPrice        = self.selectedAnnotation.nightParkingPrice;
    parkingDetail.carPrice          = self.selectedAnnotation.carPrice;
    parkingDetail.parkImageURL      = self.selectedAnnotation.parkImageURL;
    
    [self presentViewController:parkingDetail animated:YES completion:nil];
    
}
-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    self.selectedAnnotation = (customAnnotation*)view.annotation;
    self.endLatitude = view.annotation.coordinate.latitude;
    self.endLongitude = view.annotation.coordinate.longitude;
    self.naviButton.hidden = NO;
}
- (IBAction)didPhoneNavi:(id)sender {
    if (self.currentLatitude == 0 || self.currentLongitude == 0) {
        [SVProgressHUD showInfoWithStatus:@"未知起点，请定位后导航"];
        return;
    }
    if (self.endLatitude == 0 || self.endLongitude == 0) {
        [SVProgressHUD showInfoWithStatus:@"未知终点，请搜索停车场后导航"];
        return;
    }
    
    PhoneGPSViewController* phoneGPSView = [[PhoneGPSViewController alloc] initWithNibName:nil bundle:nil];
    phoneGPSView.startLongitude = self.currentLongitude;
    phoneGPSView.startLatitude  = self.currentLatitude;
    phoneGPSView.endLatitude    = self.endLatitude;
    phoneGPSView.endLongitude   = self.endLongitude;
    [self presentViewController:phoneGPSView animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
     NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    self.currentLatitude = userLocation.location.coordinate.latitude;
    self.currentLongitude = userLocation.location.coordinate.longitude;

    NSLog(@"%f %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    [[NSUserDefaults standardUserDefaults]setFloat:self.currentLatitude forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults]setFloat:self.currentLongitude forKey:@"longtitude"];
    
    [_mapView updateLocationData:userLocation];
    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];

    [_locService stopUserLocationService];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mapView setZoomLevel:14];
    });
//    [_delegate getLat:userLocation.location.coordinate.latitude lon:userLocation.location.coordinate.longitude]; // 设置代理
}

-(void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    [self.interestPlaceTextField endEditing:YES];
    self.naviButton.hidden = YES;
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}
/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */

- (void)didStopLocatingUser
{
    NSString *path = @"http://api2.juheapi.com/park/query";
    NSString *api_id = @"133";
    NSString *method = @"GET";
    NSDictionary *param = @{@"kw":self.interestPlaceTextField.text,
                            @"lon": @(self.currentLongitude),
                            @"lat": @(self.currentLatitude),
                            @"distance":@(2000),
                            @"limit":@(50),
                            @"key":@"2f895ddf171ed0e69d30f1805c3cb13b"};
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    [juheapi executeWorkWithAPI:path
                          APIID:api_id
                     Parameters:param
                         Method:method
                        Success:^(id responseObject){
                            [SVProgressHUD dismiss];
                            if ([[param objectForKey:@"dtype"] isEqualToString:@"xml"]) {
                                NSLog(@"***xml*** \n %@", responseObject);
                            }else{
                                int error_code = [[responseObject objectForKey:@"error_code"] intValue];
                                if (!error_code) {
                                    NSLog(@"数据读取成功！！！ %@", responseObject);
                                    NSArray* parkingInfoArray = [MetaDataTool parkingPoints:responseObject];
                                    //                                        static int annoTag = 1;
                                    for (ParkingInfo* parkInfo in parkingInfoArray) {
#warning 百度自带的大头针，可修改
                                        customAnnotation* item = [[customAnnotation alloc]init];
                                        //                                            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
                                        item.coordinate = CLLocationCoordinate2DMake([parkInfo.LOC[@"lat"] doubleValue], [parkInfo.LOC[@"lon"] doubleValue]);
                                        item.title = parkInfo.CCMC;
                                        item.subtitle = parkInfo.BTTCJG;
                                        item.parkingName = parkInfo.CCMC;
                                        item.parkingAddress = parkInfo.CCDZ;
                                        item.openTime = parkInfo.YYKSSJ;
                                        item.dayParkingPrice = parkInfo.BTTCJG;
                                        item.nightParkingPrice = parkInfo.WSTCJG;
                                        item.trackPrice = parkInfo.JCSFA;
                                        item.carPrice = parkInfo.JCSFB;
                                        item.parkImageURL = [NSURL URLWithString:parkInfo.CCTP];
                                        item.totalPark = parkInfo.ZCW;
                                        item.emptyPark = parkInfo.KCW;
                                        item.closeTime = parkInfo.YYJSSJ;
                                        self.regionLabel.text = parkInfo.QYCS;
                                        
                                        [self.mapView addAnnotation:item];
                                        //                                            self.mapView setCenterCoordinate:info.pt animated:YES];
                                        [self.mapView setZoomLevel:16];
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            _mapView.centerCoordinate = item.coordinate;
                                        });
                                        
                                        //                                            annoTag++;
                                        
                                    }
                                    
                                }else{
                                    [SVProgressHUD showInfoWithStatus:@"数据读取失败"];
                                    NSLog(@"数据读取失败！%@", responseObject);
                                }
                            }
                        } Failure:^(NSError *error) {
                            NSLog(@"error:   %@",error.description);
                        }];
    NSLog(@"stop locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    [SVProgressHUD showInfoWithStatus:@"location error"];
    NSLog(@"location error");
}
- (IBAction)addViewLevel:(id)sender {
    self.mapView.zoomLevel += 1;
}
- (IBAction)subViewLevel:(id)sender {
    self.mapView.zoomLevel -= 1;
}


- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
}


@end

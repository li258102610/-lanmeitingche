//
//  oilStationDetailController.m
//  OilPrice
//
//  Created by tarena6 on 15/11/20.
//  Copyright © 2015年 zzp_pc. All rights reserved.
//

#import "oilStationDetailController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GasStationCell.h"
#import "PhoneGPSViewController.h"
#import "SVProgressHUD.h"



@interface oilStationDetailController ()<MKMapViewDelegate,CLLocationManagerDelegate>
//@property (weak, nonatomic) IBOutlet MKMapView *_mapView;
@property (nonatomic,strong)CLLocationManager   *locationMgr;
@end

@implementation oilStationDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentLat = [[NSUserDefaults standardUserDefaults]floatForKey:@"latitude"];
    self.currentLon = [[NSUserDefaults standardUserDefaults]floatForKey:@"longtitude"];
//    self.locationMgr = [CLLocationManager new];
//    [self.locationMgr requestWhenInUseAuthorization];  // 询问定位

}
- (void)getLatLon:(NSNotification*)notification{
    
    NSString *latStr = notification.userInfo[@"lat"];
    NSString *lonStr = notification.userInfo[@"lon"];
    self.currentLat = [latStr doubleValue];
    self.currentLon = [lonStr doubleValue];
    
}

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
//    
//    CLLocationCoordinate2D center = userLocation.location.coordinate;
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.5, 0.5);
//    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
//    NSLog(@"%f,%f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
//
//
//}

- (IBAction)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goTo:(id)sender {
    
    if (self.currentLat == 0 || self.currentLon == 0) {
        
        [SVProgressHUD showInfoWithStatus:@"未知起点，请定位后导航"];
        return;
        
    }
    if (self.endLat == 0 || self.endLon == 0) {
        [SVProgressHUD showInfoWithStatus:@"未知终点，请搜索停车场后导航"];
        return;
    }
    
    PhoneGPSViewController* phoneGPSView = [[PhoneGPSViewController alloc] initWithNibName:nil bundle:nil];
    phoneGPSView.startLongitude = self.currentLon;
    phoneGPSView.startLatitude = self.currentLat;
    phoneGPSView.endLatitude = self.endLat;
    phoneGPSView.endLongitude = self.endLon;
    
    [self presentViewController:phoneGPSView animated:YES completion:nil];

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ParkingDetailViewController.h
//  ZTMapSection
//
//  Created by Tong Zhao on 15/11/12.
//  Copyright © 2015年 ZhTg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParkingDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *parkingNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *parkingAddLabel;
@property (weak, nonatomic) IBOutlet UILabel *openTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayParkingPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nightParkingPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *carPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalParkLabel;
@property (weak, nonatomic) IBOutlet UILabel *emptyParkLabel;
@property (weak, nonatomic) IBOutlet UIImageView *parkingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *currentImageView;

@property(nonatomic,strong)NSString* parkingName;
@property(nonatomic,strong)NSString* parkingAddress;
@property(nonatomic,strong)NSString* openTime;
@property(nonatomic,strong)NSString* closeTime;
@property(nonatomic,strong)NSString* dayParkingPrice;
@property(nonatomic,strong)NSString* nightParkingPrice;
@property(nonatomic,strong)NSString* trackPrice;
@property(nonatomic,strong)NSString* carPrice;
@property(nonatomic,assign)int totalPark;
@property(nonatomic,assign)int emptyPark;
@property(nonatomic,strong)NSURL* parkImageURL;

@end

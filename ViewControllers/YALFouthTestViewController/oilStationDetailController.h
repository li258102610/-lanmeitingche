//
//  oilStationDetailController.h
//  OilPrice
//
//  Created by tarena6 on 15/11/20.
//  Copyright © 2015年 zzp_pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GasStationCell.h"

@interface oilStationDetailController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *oilCampanyLogo;
@property (weak, nonatomic) IBOutlet UILabel *oilSationName;
@property (weak, nonatomic) IBOutlet UILabel *oilStaionType;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *discountMessage;

@property (weak, nonatomic) IBOutlet UILabel *_90price;
@property (weak, nonatomic) IBOutlet UILabel *_93price;
@property (weak, nonatomic) IBOutlet UILabel *_97price;
@property (weak, nonatomic) IBOutlet UILabel *_0price;

@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *oilCardMessage;

@property (assign,nonatomic)float           endLat;
@property (assign,nonatomic)float           endLon;

@property (assign,nonatomic)float           currentLat;
@property (assign,nonatomic)float           currentLon;

@property (weak, nonatomic) IBOutlet UIView *mapView;



@end

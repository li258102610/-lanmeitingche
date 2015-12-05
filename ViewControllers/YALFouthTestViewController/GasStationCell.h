//
//  GasStationCell.h
//  OilPrice
//
//  Created by zzp_pc on 15/11/12.
//  Copyright © 2015年 zzp_pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Oilprice.h"
#import "DataSource.h"

@protocol jumpNextPageDelegate <NSObject>

- (void)goTo:(UIButton*)btn;
- (void)detail:(UIButton*)btn;

@end

@interface GasStationCell : UITableViewCell

@property (nonatomic)id <jumpNextPageDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *oilStationName;
@property (weak, nonatomic) IBOutlet UILabel *oilStationCompanyName;

/**
 *  
 */
@property (weak, nonatomic) IBOutlet UILabel *oilStationAddress;
@property (weak, nonatomic) IBOutlet UIImageView *addressImage;

@property (weak, nonatomic) IBOutlet UILabel *_90price;
@property (weak, nonatomic) IBOutlet UILabel *_93price;
@property (weak, nonatomic) IBOutlet UILabel *_97price;
@property (weak, nonatomic) IBOutlet UILabel *_0price;

@property (weak, nonatomic) IBOutlet UILabel *_90label;
@property (weak, nonatomic) IBOutlet UILabel *_93label;
@property (weak, nonatomic) IBOutlet UILabel *_97label;
@property (weak, nonatomic) IBOutlet UILabel *_0label;

@property (assign,nonatomic)float            lat;
@property (assign,nonatomic)float            lon;
@property (assign,nonatomic)NSString         *type;
@property (assign,nonatomic)NSString         *discountMessage;
@property (assign,nonatomic)NSString         *fwlsmc;

@property (strong,nonatomic)Oilprice        *oilPrice;
@property (strong,nonatomic)DataSource      *dataSource;

@end

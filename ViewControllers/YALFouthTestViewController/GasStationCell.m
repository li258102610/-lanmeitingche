//
//  GasStationCell.m
//  OilPrice
//
//  Created by zzp_pc on 15/11/12.
//  Copyright © 2015年 zzp_pc. All rights reserved.
//

#import "GasStationCell.h"


@interface GasStationCell()

@end
@implementation GasStationCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setOilPrice:(Oilprice *)oilPrice{
    
    self._0price.text  = [NSString stringWithFormat:@"¥%.2f",oilPrice.E0];
    self._90price.text = [NSString stringWithFormat:@"¥%.2f",oilPrice.E90];
    self._93price.text = [NSString stringWithFormat:@"¥%.2f",oilPrice.E93];
    self._97price.text = [NSString stringWithFormat:@"¥%.2f",oilPrice.E97];
    
}
- (void)setDataSource:(DataSource *)dataSource{
    if(dataSource.distance > 1){
        self.distance.text = [NSString stringWithFormat:@"%.2fKm",dataSource.distance / 1000];
    }else{
        self.distance.text = @"---";
    }
    self.oilStationAddress.text = dataSource.address;
    self.oilStationName.text = dataSource.name;
    self.lat = dataSource.lat;
    self.lon = dataSource.lon;
    self.type = dataSource.type;
    self.oilStationCompanyName.text = dataSource.brandname;
    self.discountMessage = dataSource.discount;
    self.fwlsmc = dataSource.fwlsmc;
}

- (IBAction)goToHere:(UIButton*)sender {
    [_delegate goTo:sender];
}
- (IBAction)oilStationDetail:(UIButton *)sender {
    [_delegate detail:sender];
}

@end

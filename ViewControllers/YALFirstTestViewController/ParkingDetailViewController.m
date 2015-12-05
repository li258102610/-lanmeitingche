//
//  ParkingDetailViewController.m
//  ZTMapSection
//
//  Created by Tong Zhao on 15/11/12.
//  Copyright © 2015年 ZhTg. All rights reserved.
//

#import "ParkingDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface ParkingDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *emptySignal;

@end

@implementation ParkingDetailViewController
-(instancetype)init{
    
    if (self = [super init]) {
       
#warning 图片没有初始化
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.parkingName.length == 0) {self.parkingNameLabel.text = @"--";
    }else{self.parkingNameLabel.text = self.parkingName;
    }
    
    if (self.parkingAddress.length == 0) {self.parkingAddLabel.text = @"--";
    }else{self.parkingAddLabel.text = self.parkingAddress;
    }
    
    if (self.openTime.length == 0) {self.openTimeLabel.text = @"--";
    }else{self.openTimeLabel.text = [NSString stringWithFormat:@"%@ - %@",self.openTime,self.closeTime];
    }
    
    if (self.dayParkingPrice.length == 0) {
        self.dayParkingPriceLabel.text = @"--";
    }else{self.dayParkingPriceLabel.text = self.dayParkingPrice;
    }
    
    if (self.nightParkingPrice.length == 0) {
        self.nightParkingPriceLabel.text = @"--";
    }else{self.nightParkingPriceLabel.text = self.nightParkingPrice;
    }
    
    if (self.trackPrice.length == 0) {
        self.trackPriceLabel.text = @"--";
    }else{self.trackPriceLabel.text = self.trackPrice;
    }
    
    if (self.carPrice.length == 0) {
        self.carPriceLabel.text = @"--";
    }else{self.carPriceLabel.text = self.carPrice;
    }
    
    if (@(self.totalPark) == NULL) {
        self.totalParkLabel.text = @"--";
    }else{self.totalParkLabel.text = [NSString stringWithFormat:@"共有%d个车位",self.totalPark];
    }
    
    if (@(self.emptyPark) == NULL) {
        self.emptyParkLabel.text = @"--";
    }else{self.emptyParkLabel.text = [NSString stringWithFormat:@"%d",self.emptyPark];
    }
    [self.parkingImageView sd_setImageWithURL:self.parkImageURL placeholderImage:[UIImage imageNamed:@"停车场"]];
    double i = (double)self.emptyPark / self.totalPark;
    if (i == 0) {
        self.emptySignal.image = [UIImage imageNamed:@"满.png"];
    }else if( i < 0.5){
        self.emptySignal.image = [UIImage imageNamed:@"少量.png"];
    }else if( i < 0.85){
        self.emptySignal.image = [UIImage imageNamed:@"正常.png"];
    }else if( i <= 1.0){
        self.emptySignal.image = [UIImage imageNamed:@"富裕.png"];
    }
    [self.view addSubview:self.emptySignal];
    
}
- (IBAction)clickBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

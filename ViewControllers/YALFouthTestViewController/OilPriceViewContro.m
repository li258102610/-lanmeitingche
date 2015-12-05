//
//  OilPriceViewContro.m
//  Login
//
//  Created by zzp_pc on 15/11/27.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

#import "OilPriceViewContro.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "DataSource.h"
#import "GasStationCell.h"
#import "Oilprice.h"
#import "recommendOilPrice.h"
#import "oilStationDetailController.h"
#import "ParkViewController.h"

@interface OilPriceViewContro ()<UITableViewDataSource,UITableViewDelegate,jumpNextPageDelegate,sendLatAndLon>

@property (weak, nonatomic) IBOutlet UITableView    *_tableview;
@property (nonatomic,strong) NSMutableArray         *dataArray;
@property (nonatomic,strong) NSMutableArray         *oilPriceArray;
@property (nonatomic,assign) char                    *cityName;

@end

@implementation OilPriceViewContro
- (void)getLat:(float)lat lon:(float)lon{
    self.lat = lat;
    self.lon = lon;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.lat = [[NSUserDefaults standardUserDefaults]floatForKey:@"latitude"];
    self.lon = [[NSUserDefaults standardUserDefaults]floatForKey:@"longtitude"];
    
    if(self.lat != 0 && self.lon != 0){
    [self requestWithLat:self.lat Lon:self.lon];
    }
    
    /**
     *  注册自己义cell
     */
    [self._tableview registerNib:[UINib nibWithNibName:@"GasStationCell" bundle:nil] forCellReuseIdentifier:@"tablecell"];
}

- (void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"%f,%f",self.lat,self.lon);
    if (self.lon != 0 && self.lat != 0) {
        [self requestWithLat:self.lat Lon:self.lon];
    }
    
}

- (void)requestWithLat:(double)lat Lon:(double)lon{
    
    [[JHOpenidSupplier shareSupplier]registerJuheAPIByOpenId:@"JH6696b8dcff63689f534b3000b656a0e4"];
    
    NSString *api_id = @"7";
    NSString *method = @"GET";
    
     NSString *LocalURL = @"http://apis.juhe.cn/oil/local";
    NSDictionary *localParam = @{@"key":@"48088c6bbedb1ff22f9b42b7d3234d24",@"lon":@(lon),@"lat":@(lat)};
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:LocalURL
                          APIID:api_id
                     Parameters:localParam
                         Method:method
                        Success:^(id responseObject) {
                            NSDictionary *result = responseObject[@"result"];
                            NSArray *dataArray = result[@"data"];
                            NSMutableArray *dataMutArray = [NSMutableArray array];
                            NSMutableArray *oilpriceMutArray = [NSMutableArray array];
                            for (NSDictionary *source in dataArray) {
                                DataSource *sourceData = [DataSource new];
                                [sourceData setValuesForKeysWithDictionary:source];
                                [dataMutArray addObject:sourceData];
                                
                                NSDictionary *oilPriceDic = sourceData.price;
                                Oilprice *oilprice = [Oilprice new];
                                [oilprice setValuesForKeysWithDictionary:oilPriceDic];
                                [oilpriceMutArray addObject:oilprice];
                                NSLog(@"%ld %ld",oilpriceMutArray.count, dataMutArray.count);
                            }
                            self.dataArray = dataMutArray;
                            self.oilPriceArray = oilpriceMutArray;
                            [self._tableview reloadData];
                            
                        } Failure:^(NSError *error) {
                            NSLog(@"error:   %@",error.description);
                        }];
}


#pragma mark / ************* UITableViewDataSource/UITableViewDelegate ************* /

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return self.oilPriceArray.count;

}

/**
 *  重用cell，对cell中显示的内容进行设置
 */
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GasStationCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"tablecell" forIndexPath:indexPath];
    cell.oilPrice = self.oilPriceArray[indexPath.row];
    cell.dataSource = self.dataArray[indexPath.row];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

/**
 *  设置第个section中row的高度
 * @return : 高度120 px
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

/**
 *  返回section的头部视图的高度
 *  @retun : 160 px
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 160;
}


#pragma mark / ************* 今日油价表的加载与数据展示 ************* /


/**
 * 今日油价view的设置 及数据匹配
 */
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    recommendOilPrice *view =  [[[NSBundle mainBundle]loadNibNamed:@"recommendOilPrice" owner:nil options:nil]lastObject];
    Oilprice *preice = self.oilPriceArray[0];
    view._0OilPrice.text  = [NSString stringWithFormat:@"%.2f",preice.E0];
    view._90OilPrice.text = [NSString stringWithFormat:@"%.2f",preice.E90];
    view._93OilPrice.text = [NSString stringWithFormat:@"%.2f",preice.E93];
    view._97OilPrice.text = [NSString stringWithFormat:@"%.2f",preice.E97];
    
    return view;
}

-(void)goTo:(UIButton *)btn{
    
    GasStationCell *cell = (GasStationCell*)btn.superview.superview;    // btn取一次superview是contentView,再取一次就是cell
    oilStationDetailController *detailVive = [oilStationDetailController new];
    
    [self presentViewController:detailVive animated:YES completion:^{  // 弹出加油详细页并对属性进行赋值
        
        detailVive.oilSationName.text = cell.oilStationName.text;
        detailVive.oilStaionType.text = [NSString stringWithFormat:@"加油站类型：%@",cell.type];
        detailVive.distance.text = cell.distance.text;
        
        detailVive.address.text = cell.oilStationAddress.text;
        detailVive.discountMessage.text = [NSString stringWithFormat:@"打折信息：%@",cell.discountMessage];
        detailVive.oilCardMessage.text = [NSString stringWithFormat:@"%@",cell.fwlsmc];
        
        detailVive._0price.text = cell._0price.text;
        detailVive._90price.text = cell._90price.text;
        detailVive._93price.text = cell._93price.text;
        detailVive._97price.text = cell._97price.text;
        
        detailVive.endLat = cell.lat;  //经度
        detailVive.endLon = cell.lon;  //纬度
    }];
}

- (IBAction)userInfo:(id)sender {
    
     AppDelegate* delegate = [[UIApplication sharedApplication]delegate];
    [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

}
- (void)detail:(UIButton *)btn{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

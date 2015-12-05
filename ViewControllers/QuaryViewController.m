//
//  ViewController.m
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/12.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import "QuaryViewController.h"
#import "WZHpzlTableViewController.h"
#import "WZCitysViewController.h"
#import "WZQueryTableViewController.h"

#import "WZTableViewCell.h"

#import "MBProgressHUD+MJ.h"

#import "HpzlResult.h"
#import "WZHpzl.h"

#import "ProvinceResult.h"
#import "WZProvince.h"
#import "WZCity.h"

#import "QueryResult.h"
#import "WZQuery.h"


#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)

#pragma mark TextField Tag enum
enum TAG_REGISTER_TEXTFIELD{
    
    Tag_HpzlCell  = 100,        //号牌类型
    Tag_HphmTextField ,         //车牌号码
    Tag_CityCell,               //查询地区
    Tag_EnginenoTextField,      //发动机号
    Tag_ClassnoTextField,       //车架号
    Tag_RegistTextField,        //证书号
};

@interface QuaryViewController ()
{
    
    WZHpzl *_wzHpzl;
    WZCity *_wzCity;
    NSString *_hpzlId;      //号牌类型
    NSString *_hphm;        //车牌号码
    NSString *_engineno;    //发动机号
    NSString *_classno;     //车架号
    NSString *_registno;    //证书号
    UITableViewCell *_selectedCell;
    
    NSMutableArray *_inputFileds;
}

@property (assign, nonatomic) CGRect keyboardFrame;
@property (strong, nonatomic) NSArray *provinceArray ;      //省份和城市字典
@property (strong, nonatomic) NSArray *hpzlArray;           //号牌种类列表
@property (strong, nonatomic) NSArray *wzQueryArray;

@end

@implementation QuaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:@"99c91b3fcaa66a75d7710e9bf9f71da6"];
    
    if (!_provinceArray) {
        [self performSelector:@selector(queryProvinceList) withObject:nil];
    }

    if (!_hpzlArray) {
        [self performSelector:@selector(queryHpzlList) withObject:nil];
    }
    
    self.queryTableView.backgroundColor = [UIColor clearColor];
    self.queryTableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.2];
//    self.queryTableView 
    
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setInputFieldsWithWZCity:_wzCity];
}

#pragma mark - method


- (IBAction)queryWeizhang:(id)sender{
    
    _wzHpzl = [[WZHpzl alloc] initWithHpzl:@{@"car":@"小型车" , @"id":@"02"}];
    _wzCity = [[WZCity alloc] initWithCity:@{@"city_name":@"北京" , @"city_code":@"BJ" , @"abbr":@"京" , @"engine":@"1" , @"engineno":@"0" , @"class":@"0" , @"classno":@"0" , @"regist":@"0" , @"registno":@"0"}];
    _hphm = @"京M30526";
    _engineno = @"84010987";
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]initWithObjectsAndKeys:_wzCity.cityCode , @"city", _wzHpzl.iD, @"hpzl", _hphm ,@"hphm", nil];
    if ([_wzCity.engine intValue]) {
        [param addEntriesFromDictionary:@{@"engineno":_engineno}];
    }
    if ([_wzCity.class_wz intValue]) {
        [param addEntriesFromDictionary:@{@"classno":_classno}];
    }
    
    NSString *path = @"http://v.juhe.cn/wz/query";
    NSString *api_id = @"36";
    NSString *method = @"GET";
    
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    
    [juheapi executeWorkWithAPI:path
                          APIID:api_id
                     Parameters:param
                         Method:method
                        Success:^(id responseObject){
                            QueryResult *result = [[QueryResult alloc]initWithQueryJson:responseObject];
                            if (![result.errorCode isEqualToString:@"0"]) {
                                [MBProgressHUD showError:result.reason];
                            }else{
                                _wzQueryArray = result.result;
                                [self performSegueWithIdentifier:@"WZQuery" sender:_wzQueryArray];
                            }
                            
                        } Failure:^(NSError *error) {
                            [MBProgressHUD showError:@"未连接到服务器..."];
                        }];
    
    


}

- (void)queryProvinceList{
    
    NSString *path = @"http://v.juhe.cn/wz/citys";
    NSString *api_id = @"36";
    NSString *method = @"GET";
    NSDictionary *param = @{@"dtype":@"json"};
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    
    [juheapi executeWorkWithAPI:path
                          APIID:api_id
                     Parameters:param
                         Method:method
                        Success:^(id responseObject){
                            ProvinceResult *result = [[ProvinceResult alloc]initWithProvinceJson:responseObject];
                            if (![result.error_code isEqualToString:@"0"]) {
                                [MBProgressHUD showError:result.reason];
                            }else{
                                _provinceArray = result.result;
                            }

                        } Failure:^(NSError *error) {
                            [MBProgressHUD showError:@"未连接到服务器..."];
                        }];
}

- (void)queryHpzlList{
  
    NSString *path = @"http://v.juhe.cn/wz/hpzl";
    NSString *api_id = @"36";
    NSString *method = @"GET";
    NSDictionary *param = @{@"dtype":@"json"};
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    
    [juheapi executeWorkWithAPI:path
                          APIID:api_id
                     Parameters:param
                         Method:method
                        Success:^(id responseObject){
                            HpzlResult *result = [[HpzlResult alloc]initWithHpzlJson:responseObject];
                            if (![result.errorCode isEqualToString:@"0"]) {
                                [MBProgressHUD showError:result.reason];
                            }else{
                                _hpzlArray = result.result;
                            }

                        } Failure:^(NSError *error) {
                          [MBProgressHUD showError:@"未连接到服务器..."];
                        }];
    

}


- (void)setInputFieldsWithWZCity:(WZCity *)city{
    _inputFileds = [[NSMutableArray alloc]initWithCapacity:5];
    [_inputFileds addObject:[self.view viewWithTag:Tag_HphmTextField]];
    
    if ([_wzCity.engine intValue]) {
        [_inputFileds addObject:[self.view viewWithTag:Tag_EnginenoTextField]];
    }
    if ([_wzCity.class_wz intValue]) {
        [_inputFileds addObject:[self.view viewWithTag:Tag_ClassnoTextField]];
    }
    if ([_wzCity.regist intValue]) {
        [_inputFileds addObject:[self.view viewWithTag:Tag_RegistTextField]];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int sectionNumber = [_wzCity.engine intValue] + [_wzCity.class_wz intValue] + [_wzCity.regist intValue]; /* 发动机号 + 车架号 + 证书号 */
    return  sectionNumber + 3;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"WZTableViewCell";
    WZTableViewCell *cell = (WZTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"WZTableViewCell" owner:self options:nil];
    if (cell == nil) {
        cell = [array objectAtIndex:0];
        //设置cell的背景颜色
        cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        //设置cell无法点中
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置cell的文本颜色
        cell.textLabel.textColor = [UIColor whiteColor];    }
    
    NSInteger index = indexPath.row;
    switch (index) {
        case 0:
            cell = [array objectAtIndex:0];
            [(UILabel *)[cell viewWithTag:Tag_HpzlCell] setText:_wzHpzl.car];
            break;
        case 1:
            cell = [array objectAtIndex:1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case 2:
            cell = [array objectAtIndex:2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone; //zp ： 修改cell为无选中效果
            [(UILabel *)[cell viewWithTag:Tag_CityCell] setText:_wzCity.cityName];
            break;
        case 3:
            if ([_wzCity.engine intValue]) {
                cell = [array objectAtIndex:3];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                cell = [array objectAtIndex:4];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            break;
        case 4:
            if ([_wzCity.engine intValue]&&[_wzCity.class_wz intValue]) {
                cell = [array objectAtIndex:4];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                cell = [array objectAtIndex:5];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            break;
        default:
            cell = [array objectAtIndex:5];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"无数据";
//            cell.selectedBackgroundView = [UIView new];
            return cell;
            break;
    }
    return cell;
}


- (UITableViewCell *) setInputCell:(UITableViewCell *)cell AtIndex:(NSInteger)index{
    
    return cell;
}

#pragma mark - UITableviewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSInteger index = indexPath.row;
    if (index == 0) {
        if (!_hpzlArray) {
            [self performSelector:@selector(queryHpzlList) withObject:nil];
        }else{
            [self performSegueWithIdentifier:@"WZHpzl" sender:nil];
        }
        return;
    }
    
    if (index == 2) {
        if (!_provinceArray) {
            [self performSelector:@selector(queryProvinceList) withObject:nil];
        }else{
            [self performSegueWithIdentifier:@"WZCitys" sender:nil];
        }
        return;
    }
}

#pragma UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSUInteger indexOfActiveTextFiled = [_inputFileds indexOfObjectPassingTest:^BOOL(UITextField *textField, NSUInteger idx, BOOL* stop) {
        return textField.isFirstResponder;
    }];
    if (indexOfActiveTextFiled < _inputFileds.count - 1) {
        textField.returnKeyType = UIReturnKeyNext;
    }else{
        textField.returnKeyType = UIReturnKeyDone;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (Tag_ClassnoTextField == textField.tag) {
        _classno = textField.text;
    }
    
    if (Tag_EnginenoTextField == textField.tag) {
        _engineno = textField.text;
    }
    if (Tag_HphmTextField == textField.tag) {
        _hphm = textField.text;
    }
    if (Tag_RegistTextField == textField.tag) {
        _registno = textField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSUInteger indexOfActiveTextFiled = [_inputFileds indexOfObjectPassingTest:^BOOL(UITextField *textField, NSUInteger idx, BOOL* stop) {
        return textField.isFirstResponder;
    }];
    
    if (indexOfActiveTextFiled < _inputFileds.count - 1) {
        [_inputFileds[indexOfActiveTextFiled + 1] becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    

    if ([segue.identifier isEqualToString:@"WZHpzl"]) {
        WZHpzlTableViewController *vc = segue.destinationViewController;
        vc.hpzlArray = _hpzlArray;
        vc.delegate = self;
        return;
    }
    
    if ([segue.identifier isEqualToString:@"WZCitys"]) {
        WZCitysViewController *vc = segue.destinationViewController;
        vc.provinceArray = _provinceArray;
        vc.delegate = self;
        return;
    }
    if ([segue.identifier isEqualToString:@"WZQuery"]) {
        WZQueryTableViewController *vc = segue.destinationViewController;
        vc.wzQueryArray = _wzQueryArray;
        return;
    }

}

- (void) selectCurrentCity:(WZCity *)city
{
    if (_wzCity.engine != city.engine) {
        _wzCity = city;
        [_queryTableView reloadData];
    }else{
        if (_wzCity.class_wz != city.class_wz) {
            _wzCity = city;
             [_queryTableView reloadData];
        }else{
            if (_wzCity.regist != city.regist) {
                _wzCity = city;
                 [_queryTableView reloadData];
            }
        }
        
    }
    [(UILabel *)[_selectedCell viewWithTag:Tag_CityCell] setText:_wzCity.cityName];
    
}

- (void) selectCurrentHpzl:(WZHpzl *)hpzl{
    _wzHpzl = hpzl;
    [(UILabel *)[_selectedCell viewWithTag:Tag_HpzlCell] setText:hpzl.car];
}
@end

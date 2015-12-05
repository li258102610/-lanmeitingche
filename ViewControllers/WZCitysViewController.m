//
//  WZCitysViewController.m
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/12.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import "WZCitysViewController.h"
#import "WZProvince.h"
#import "WZCity.h"

@interface WZCitysViewController ()

@end

@implementation WZCitysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (tableView == _provinceTable) {
        if (_provinceArray != nil) {
            return [_provinceArray count];
        }else{
            return 0;
        }
    }else if(tableView == _cityTable) {
        if (_cityArray !=nil) {
            return [_cityArray count];
        }else{
            return 0;
        }
    }else{
        return 0;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier=@"CityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (tableView == _provinceTable) {
        WZProvince *province = [_provinceArray objectAtIndex:indexPath.row];
        cell.textLabel.text = province.name;
    }else if (tableView == _cityTable){
        WZCity *city = [_cityArray objectAtIndex:indexPath.row];
        cell.textLabel.text = city.cityName;
    }else{
        cell.textLabel.text = @"";
    }
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _provinceTable) {
        if (_provinceArray != nil) {
            WZProvince *province = [_provinceArray objectAtIndex:indexPath.row];
            _cityArray = province.cityArray;
        }else{
            _cityArray = @[];
        }
        [_cityTable reloadData];
    }else{
        if (_cityTable !=nil) {
            WZCity *selectCity = [_cityArray objectAtIndex:indexPath.row];
            if ([self.delegate respondsToSelector:@selector(selectCurrentCity:)]) {
                [self.delegate selectCurrentCity:selectCity];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
    
}
@end

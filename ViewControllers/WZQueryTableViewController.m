//
//  WZQueryTableViewController.m
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/12.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import "WZQueryTableViewController.h"
#import "WZQuery.h"

@interface WZQueryTableViewController ()

@end

@implementation WZQueryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [_wzQueryArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier=@"QueryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
    }
    WZQuery *wz = [_wzQueryArray objectAtIndex:indexPath.section];

    NSString *title = @"--";
    NSString *detail = @"--";
    switch (indexPath.row) {
        case 0:
            title = @"违章地点";
            detail = wz.area;
            break;
        case 1:
            title = @"违章行为";
            detail = wz.act;
            break;
        case 2:
            title = @"违章扣分";
            detail = wz.fen;
            break;
        case 3:
            title = @"违章罚款";
            detail = wz.money;
            break;
        case 4:
            title = @"违章处理";
        {
            NSString *handled = wz.handled;
            if ([handled isEqualToString:@"0"]) {
                detail = @"未处理";
            }else if ([handled isEqualToString:@"1"]){
                detail = @"已处理";
            }else{
                detail = @"未知";
            }
        }
            break;
        default:
            break;
    }
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = detail;
    return cell;
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    WZQuery *wz = [_wzQueryArray objectAtIndex:section];
    return wz.date;
}
@end

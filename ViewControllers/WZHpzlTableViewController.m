//
//  WZHpzlTableViewController.m
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/12.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import "WZHpzlTableViewController.h"
#import "WZHpzl.h"

@interface WZHpzlTableViewController ()

@end

@implementation WZHpzlTableViewController

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_hpzlArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier=@"HpzlCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    WZHpzl *hpzl = [_hpzlArray objectAtIndex:indexPath.row];
    cell.textLabel.text = hpzl.car;
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WZHpzl *hpzl = [_hpzlArray objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(selectCurrentHpzl:)]) {
        [self.delegate selectCurrentHpzl:hpzl];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end

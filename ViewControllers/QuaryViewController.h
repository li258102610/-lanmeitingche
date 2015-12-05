//
//  ViewController.h
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/12.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZCitysViewController.h"
#import "WZHpzlTableViewController.h"

@interface QuaryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,WZCitysDelegate,WZHpzlsDelegate>

- (IBAction)queryWeizhang:(id)sender;

- (void)queryHpzlList;
- (void)queryProvinceList;

@property (strong, nonatomic) IBOutlet UITableView *queryTableView;

@end


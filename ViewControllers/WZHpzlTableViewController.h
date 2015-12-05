//
//  WZHpzlTableViewController.h
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/12.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WZHpzl;
@protocol WZHpzlsDelegate <NSObject>

- (void) selectCurrentHpzl:(WZHpzl *)hpzl;

@end

@interface WZHpzlTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *hpzlArray;
@property (strong, nonatomic) id<WZHpzlsDelegate>delegate;

@end


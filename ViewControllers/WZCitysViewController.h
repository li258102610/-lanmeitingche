//
//  WZCitysViewController.h
//  JH_WeizhangQuery
//
//  Created by ThinkLand on 14/11/12.
//  Copyright (c) 2014年 ThinkLand. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WZCity;


@protocol WZCitysDelegate <NSObject>

- (void) selectCurrentCity:(WZCity *)city;

@end

@interface WZCitysViewController : UIViewController<UITableViewDataSource , UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *provinceTable;
@property (strong, nonatomic) IBOutlet UITableView *cityTable;

@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) id<WZCitysDelegate>delegate;

@end


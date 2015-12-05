//
//  LatestCell.h
//  汽车之家
//
//  Created by LYF on 15/10/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LatestCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *dateLb;

@property (weak, nonatomic) IBOutlet UILabel *commentLb;

@end

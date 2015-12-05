//
//  ColorSet.h
//  menu_test
//
//  Created by lanou3g on 15-4-24.
//  Copyright (c) 2015年 shiyan. All rights reserved.
//

#import <UIKit/UIKit.h>
//粉红色
#define kPinkColor [UIColor colorWithRed:255/255.0 green:192/255.0 blue:203/255.0 alpha:1.0]
//淡紫色
#define kLavenderColor [UIColor colorWithRed:218/255.0 green:112/255.0 blue:214/255.0 alpha:1.0]
//天蓝色
#define kAzureColor [UIColor colorWithRed:240/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]
//橙红色
#define kOrangeRed [UIColor colorWithRed:250/255.0 green:128/255.0 blue:114/255.0 alpha:1.0]
//亮天蓝色
#define kLightBlue [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0]
//象牙白
#define kIvoryWhite [UIColor colorWithRed:250/255.0 green:255/255.0 blue:240/255.0 alpha:1.0]
//淡绿色
#define kPalegreen [UIColor colorWithRed:127/255.0 green:255/255.0 blue:212/255.0 alpha:1.0]

@interface ColorSet : NSObject

+ (ColorSet *)shareColorSet;


@property (nonatomic,strong)UIColor *color;

@end

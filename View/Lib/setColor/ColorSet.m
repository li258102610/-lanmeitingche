//
//  ColorSet.m
//  menu_test
//
//  Created by lanou3g on 15-4-24.
//  Copyright (c) 2015年 shiyan. All rights reserved.
//

#import "ColorSet.h"

@implementation ColorSet

static ColorSet *colorSet = nil;
+ (ColorSet *)shareColorSet
{
    @synchronized(self){
        if (colorSet == nil) {
            colorSet = [[ColorSet alloc]init];
            colorSet.color = kIvoryWhite;
        }
    }
    
    return colorSet;
}


@end

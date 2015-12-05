//
//  ScrollDisplayViewController.h
//
//  Created by EvenLam on 15/10/23.
//  Copyright © 2015年 EvenLam. All rights reserved.
//  可以实现图片轮播
//  需要pod引入Masonry，SDWebImage，BlocksKit等框架

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "BlocksKit.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"    //使用网络图片，需要引入SDWebImage，请到GitHub下载

#pragma mark *** Protocol(协议) ***

@class ScrollDisplayViewController;
@protocol ScrollDisplayViewControllerDelegate <NSObject>

@optional
/** 当用户点击了某一页触发 */
- (void)scrollDisplayViewController: (ScrollDisplayViewController *)scrollDisplayViewController didSelectIndex: (NSInteger)index;

/** 实时回传当前索引值 */
- (void)scrollDisplayViewController: (ScrollDisplayViewController *)scrollDisplayViewController currentIndex: (NSInteger)index;

@end

@interface ScrollDisplayViewController : UIViewController
{
    NSTimer *_timer;    //  成员变量（实例变量）
}
#pragma mark *** Properties(属性) ***

/** 存放传入的图片数组 */
@property (nonatomic, readonly) NSArray *paths;
/** 存放传入的图片名字数组 */
@property (nonatomic, readonly) NSArray *names;
/** 存放传入的视图控制器数组 */
@property (nonatomic, readonly) NSArray *viewControllers;
/** 分页视图控制器 */
@property (nonatomic, readonly) UIPageViewController *pageViewController;
/** 分页控制器 */
@property (nonatomic, readonly) UIPageControl *pageControl;
/** 笔记  代理属性（修饰词用weak） */
@property (nonatomic, weak) id<ScrollDisplayViewControllerDelegate>delegate;
/** 设置是否循环滚动，默认为YES，表示可以循环 */
@property (nonatomic) BOOL canCycle;
/** 设置是否定时滚动，默认为YES，表示定时滚动 */
@property (nonatomic) BOOL autoCycle;
/** 滚动的时间,默认3秒 */
@property (nonatomic) NSTimeInterval duration;
/** 是否显示 页数提示， 默认YES， 显示 */
@property (nonatomic) BOOL showPageControl;
/** 当前页数(CurrentPage) */
@property (nonatomic) NSInteger currentPage;
/** 设置页数提示的垂直偏移量，正数表示向下移动 */
@property (nonatomic) CGFloat pageControlOffset;
/** 设置圆点页数的正常颜色，默认是白色 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
/** 设置圆点页数的高亮颜色，默认是亮灰色 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
/** 等等，自己设置。。。。 */

#pragma mark *** Methods（方法） ***

/** 传入图片地址数组 */
- (instancetype)initWithImagePaths: (NSArray *)paths;
/** 传入图片名字数组 */
- (instancetype)initWithImageNames: (NSArray<NSString *> *)names;
/** 传入视图控制器 */
- (instancetype)initWithViewControllers: (NSArray<UIViewController *> *)viewControllers;


@end

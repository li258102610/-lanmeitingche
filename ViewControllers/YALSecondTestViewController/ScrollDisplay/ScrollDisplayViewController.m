//
//  ScrollDisplayViewController.m
//  汽车之家
//
//  Created by EvenLam on 15/10/23.
//  Copyright © 2015年 EvenLam. All rights reserved.
//

#import "ScrollDisplayViewController.h"

@interface ScrollDisplayViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@end

@implementation ScrollDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_viewControllers || _viewControllers.count == 0) { //  如果控制器数组为空，或者什么也没有
        return;
    }
    
    //  初始化pageViewController,设置数据源代理
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    
    //  为pvc添加约束
    [_pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) { //需要pod 引入 Masonry 第三方框架
        make.edges.mas_equalTo(self.view);
    }];
    [_pageViewController setViewControllers:@[_viewControllers.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    //  配置pageControl
    _pageControl = [UIPageControl new];
    _pageControl.numberOfPages = _viewControllers.count;
    [self.view addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(0);
    }];
    _pageControl.userInteractionEnabled = NO;
    
    self.autoCycle = _autoCycle;
    self.showPageControl = _showPageControl;
    self.pageControlOffset = _pageControlOffset;
    self.pageIndicatorTintColor = _pageIndicatorTintColor;
    self.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
    
}


#pragma mark *** 初始化方法 ***

- (instancetype)initWithImagePaths: (NSArray *)paths{
    self = [super init];

//  路径中可能的类型：NSURL，HTTP://,https:// 本地路径
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < paths.count; i++) {
        id path = paths[i];
        //  为了监控用户点击操作
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([self isURL:path]) {            //  如果是URL地址
            [btn sd_setBackgroundImageWithURL:path forState:UIControlStateNormal];
        }else if ([self isNetPath:path]){   //  如果是网络地址
            NSURL *url = [NSURL URLWithString:path];
            [btn sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
        }else if([path isKindOfClass:[NSString class]]){//  是本地地址
            NSURL *url = [NSURL fileURLWithPath:path];
            [btn sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
        }else{
            [btn setImage:[UIImage imageNamed:@"error@3x"] forState:UIControlStateNormal];
        }
        
//  将btn加入到一个ViewController
        UIViewController *viewController = [UIViewController new];
        viewController.view = btn;
        btn.tag = 1000+i;
        
        //  为btn添加点击事件，点击按钮触发协议方法
        [btn bk_addEventHandler:^(UIButton *sender) {
            [self.delegate scrollDisplayViewController:self didSelectIndex:sender.tag-1000];
        } forControlEvents:UIControlEventTouchUpInside];
        [arr addObject:viewController];
    }
    self = [self initWithViewControllers:arr];
    return self;
}

- (instancetype)initWithImageNames: (NSArray<NSString *> *)names{
    
//  图片名字－>Image－>imageView－>ViewController
    NSMutableArray<UIViewController *> *arr = [NSMutableArray new];
    for (int i = 0; i < names.count; i++) {
        UIImage *image = [UIImage imageNamed:names[i]];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
//  将btn加入到一个ViewController
        UIViewController *viewController = [UIViewController new];
        viewController.view = btn;
        
        btn.tag = 10000+i;
        [btn bk_addEventHandler:^(UIButton *sender) {
            [self.delegate scrollDisplayViewController:self didSelectIndex:sender.tag-10000];
        } forControlEvents:UIControlEventTouchUpInside];
        
        [arr addObject:viewController];
    }
    if (self = [self initWithViewControllers:arr]){
    }
    return self;
}

- (instancetype)initWithViewControllers: (NSArray<UIViewController *> *)viewControllers{
    self = [super init];
    if (self) {
        _viewControllers = [viewControllers copy];  //为了防止实参是可变数组，需要复制一份出来，这样可以保证属性不会因为可变数组在外部被修改，而导致随之修改
        _autoCycle = YES;
        _canCycle = YES;
        _showPageControl = YES;
        _duration = 3;
        _pageControlOffset = 0;
        _pageIndicatorTintColor = [UIColor whiteColor];
        _currentPageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return self;
}

#pragma mark *** setter方法 ***

- (void)setAutoCycle:(BOOL)autoCycle{
    _autoCycle = autoCycle;
    [_timer invalidate];
    if (!autoCycle) {   //  如果为NO，那么直接返回，不自动轮播
        return;
    }
//  设置轮播
    _timer = [NSTimer bk_scheduledTimerWithTimeInterval:_duration block:^(NSTimer *timer) {
        UIViewController *viewController = [_pageViewController.viewControllers firstObject];
        
        NSInteger index = [_viewControllers indexOfObject:viewController];
        UIViewController *nextViewController = nil;
        
        if (index == _viewControllers.count - 1) {
            if (!_canCycle) {
                return ;
            }
            nextViewController = _viewControllers.firstObject;
        }else{
            nextViewController = _viewControllers[index + 1];
        }
        __weak typeof(self) weakself = self;
        [_pageViewController setViewControllers:@[nextViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            [weakself configPageControl];
        }];
    } repeats:YES];
    
}

- (void)setShowPageControl:(BOOL)showPageControl{
    _showPageControl = showPageControl;
    _pageControl.hidden = !showPageControl;
}

- (void)setDuration:(NSTimeInterval)duration{
    _duration = duration;
    self.autoCycle = _autoCycle;    //  用传入的duration重启timer
}

- (void)setPageControlOffset:(CGFloat)pageControlOffset{
    _pageControlOffset = pageControlOffset;
    
//  更新页面数量空间 bottom 的约束
    [_pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_pageControlOffset);
    }];
}

- (void)setCurrentPage:(NSInteger)currentPage{
    /** 
        设置新的显示页面，情况有3种
        1. 新页面 和 老页面 是同一个，什么都不做
        2. 新页面 在 老页面 的左侧 动画效果应该是向左滚动
        3. 新页面 在 老页面 的右侧 动画效果应该是向右滚动
     */
    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
    if (_currentPage == currentPage) {
        return;
    }
    else if (_currentPage > currentPage) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }else{
        direction = UIPageViewControllerNavigationDirectionForward;
    }
    _currentPage = currentPage;
    UIViewController *vc = _viewControllers[currentPage];
    [_pageViewController setViewControllers:@[vc] direction:direction animated:YES completion:nil];
    [self configPageControl];
}
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    [_pageControl setPageIndicatorTintColor:_pageIndicatorTintColor];
    
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    [_pageControl setCurrentPageIndicatorTintColor:currentPageIndicatorTintColor];
}

#pragma mark *** 私有方法 ***

/** 判断是否是URL路径 */
- (BOOL)isURL: (id)path{
    return [path isKindOfClass:[NSURL class]];
}

/** 判断是否是网络路径 */
- (BOOL)isNetPath: (id)path{
    BOOL isString = [path isKindOfClass:[NSString class]];  //  判断是否是字符串类型
    if (!isString) {    //  为了防止非String类型调用下方方法崩溃（如果合起来写就不会有这个问题）
        return NO;
    }
    BOOL containHttp = [path rangeOfString:@"http"].location != NSNotFound; //  判断是否包含@“http”
    BOOL containTile = [path rangeOfString:@"://"].location != NSNotFound;  //  判断是否包含@"://"
    return isString && containHttp && containTile;
}

/** 配置小圆点的位置 */
- (void)configPageControl{
    NSInteger index = [_viewControllers indexOfObject:_pageViewController.viewControllers.firstObject];
    _pageControl.currentPage = index;
}

#pragma mark *** UIPageViewControllerDataSource ***

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [_viewControllers indexOfObject:viewController];  //  获取当前vc的下标
    if (index == 0) {   //  如果是第0个vc，返回最后一个vc
        return _canCycle?_viewControllers.lastObject:nil;
    }
    return _viewControllers[index-1];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [_viewControllers indexOfObject:viewController];
    if (index == _viewControllers.count - 1) {
        return _canCycle?_viewControllers.firstObject:nil;
    }
    return _viewControllers[index+1];
}

#pragma mark *** UIPageViewControllerDelegate ***

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed && finished) {    //  如果完成并且动画也结束了
        [self configPageControl];
        NSInteger index = [_viewControllers indexOfObject:pageViewController.viewControllers.firstObject];
        if ([self.delegate respondsToSelector:@selector(scrollDisplayViewController:currentIndex:)]) {  //可以判断某个对象是否含有某个方法
            [self.delegate scrollDisplayViewController:self currentIndex:index];
        }
    }
}


@end

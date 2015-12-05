//
//  ContainerViewController.m
//  汽车之家
//
//  Created by LYF on 15/10/23.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ContainerViewController.h"
#import "ScrollDisplayViewController.h"
#import "LatestViewController.h"

@interface ContainerViewController ()<ScrollDisplayViewControllerDelegate>

@property (nonatomic, strong) ScrollDisplayViewController *sdVC;

@property (nonatomic, strong) UIScrollView *scrollView;
/** 可变数组，存放头部按钮 */
//@property (nonatomic, strong) NSMutableArray *btns;
/** 用于保存当前选中的按钮 */
@property (nonatomic, strong) UIButton *currentBtn;
/** 线 */
@property (nonatomic, strong) UIView *lineView;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:self.sdVC];
    [self.view addSubview: self.sdVC.view];
    [self.sdVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.navigationController.navigationBar addSubview:self.scrollView];
    self.title = @"新闻";
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    self.scrollView.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.scrollView.hidden = YES;
}
#pragma mark *** 私有方法 ***

- (LatestViewController *)latestVCWithType: (NewsListType)type {
    
    LatestViewController *vc = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"LatestViewController"];
    vc.type = type;
    return vc;
}

#pragma mark *** ScrollDisplayViewControllerDelegate ***

- (void)scrollDisplayViewController:(ScrollDisplayViewController *)scrollDisplayViewController currentIndex:(NSInteger)index{
    _currentBtn.selected = NO;
//    _currentBtn = _btns[index];
    _currentBtn.selected = YES;
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(2);
        make.centerX.mas_equalTo(_currentBtn);
        make.top.mas_equalTo(_currentBtn.mas_bottom).mas_equalTo(7);
    }];
}

#pragma mark *** LazyLoading ***

- (ScrollDisplayViewController *)sdVC {
    if(_sdVC == nil) {
        NSArray *vcs = @[//[self latestVCWithType:NewslistTypeJiShu],
//                         [self latestVCWithType:NewslistTypePinCe],
//                         [self latestVCWithType:NewslistTypeYouJi],
//                         [self latestVCWithType:NewslistTypeDaoGou],
//                         [self latestVCWithType:NewslistTypeWenHua],
                         [self latestVCWithType:NewslistTypeXinWen],
                         //[self latestVCWithType:NewslistTypeZuiXin],
                         //[self latestVCWithType:NewslistTypeYongChe],
                         //[self latestVCWithType:NewslistTypeHangQing],
                         //[self latestVCWithType:NewslistTypeGaiZhuang]
                         ];
        
        _sdVC = [[ScrollDisplayViewController alloc] initWithViewControllers:vcs];
        _sdVC.delegate = self;
        _sdVC.autoCycle = NO;
        _sdVC.showPageControl = NO;
    }
    return _sdVC;
}

- (UIView *)lineView {
    if(_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kRGBColor(56, 106, 198);
    }
    return _lineView;
}

//- (NSMutableArray *)btns {
//    if(_btns == nil) {
//        _btns = [[NSMutableArray alloc] init];
//    }
//    return _btns;
//}


//- (UIScrollView *)scrollView {
//    if(_scrollView == nil) {
//        _scrollView = [[UIScrollView alloc] init];
//        _scrollView.showsHorizontalScrollIndicator = NO;
        //NSArray *arr = @[/*@"技术",@"评测",@"游记",@"导购",@"文化",@"新闻",@"最新",@"用车",@"行情",@"改装"*/];
       // UIView *lastView = nil; //  指向最新添加的按钮
//  用for循环添加按钮
//        for (int i = 0; i < arr.count; i++) {
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [btn setTitle:arr[i] forState:UIControlStateNormal];
//            [btn setTitleColor:kRGBColor(89, 89, 89) forState:UIControlStateNormal];
//            [btn setTitleColor:self.lineView.backgroundColor forState:UIControlStateSelected];
//            if (i == 0) {
//                _currentBtn = btn;
//                btn.selected = YES;
//            }
//            [btn bk_addEventHandler:^(UIButton *sender) {//如果当前按钮是点击状态，什么都不做;否则取消掉之前按钮的点击状态，并把当前按钮设置为点击状态
//                if (_currentBtn != sender) {
//                    _currentBtn.selected = NO;
//                    sender.selected = YES;
//                    _currentBtn = sender;
//                    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                        make.width.mas_equalTo(40);
//                        make.height.mas_equalTo(2);
//                        make.centerX.mas_equalTo(sender);
//                        make.top.mas_equalTo(sender.mas_bottom).mas_equalTo(7);
//                    }];
//                    _sdVC.currentPage = [_btns indexOfObject:sender];
//                }
//                
//            } forControlEvents:UIControlEventTouchUpInside];
//            [_scrollView addSubview:btn];
//            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.size.mas_equalTo(CGSizeMake(45, 24));
//                make.centerY.mas_equalTo(_scrollView);
//                if (lastView) {//表示已经添加过按钮
//                    make.left.mas_equalTo(lastView.mas_right).mas_equalTo(10);
//                }else{
//                    make.left.mas_equalTo(10);
//                }
//            }];
//            
//            lastView = btn;
//            [self.btns addObject:btn];
//        }
        //lastView肯定是最后一个按钮，最有一个按钮的X轴肯定是固定的，当我们设置按钮的右边缘距离俯视图ContentView的右边缘距离10像素，那么滚动视图的内容区域就会被锁定了
        //[lastView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(_scrollView.mas_right).mas_equalTo(-10);
//        }];
//        [_scrollView addSubview:self.lineView];
//        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(40);
//            make.height.mas_equalTo(2);
//            UIButton *btn = _btns[0];
//            make.centerX.mas_equalTo(btn);
//            make.top.mas_equalTo(btn.mas_bottom).mas_equalTo(7);
//        }];
//    }
//    return _scrollView;
//}

@end

//
//  LatestViewController.m
//  汽车之家
//
//  Created by LYF on 15/10/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "LatestViewController.h"
#import "LatestCell.h"
#import "LatestViewModel.h"
#import "ScrollDisplayViewController.h"
#import "DetailViewController.h"
#import "MJRefreshAutoNormalFooter.h"
#import "MJRefreshNormalHeader.h"

@interface LatestViewController ()<UITableViewDelegate,UITableViewDataSource,ScrollDisplayViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) LatestViewModel *latestVM;
@property (nonatomic, strong) ScrollDisplayViewController *sdVC;

@end

@implementation LatestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //  上下拉刷新操作
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.latestVM refreshDataCompleteHandle:^(NSError *error) {
            if (error) [self showErrorMsg:error.localizedDescription];//如果出错，打印错误信息
            [_tableView.header endRefreshing];  //  停止刷新
            [self.tableView reloadData];        //  刷新表格数据
            [self configTableHeader];
        }];
    }];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.latestVM getMoreDataCompleteHandle:^(NSError *error) {
            if (error) [self showErrorMsg:error.description];
            [_tableView.footer endRefreshing];
            [self.tableView reloadData];
        }];
    }];
    [_tableView.header beginRefreshing];    //  自动刷新
}

#pragma mark *** LazyLoading ***

- (LatestViewModel *)latestVM {
    if(_latestVM == nil) {
        _latestVM = [[LatestViewModel alloc] initWithNewsListType:_type];
    }
    return _latestVM;
}


/** 配置tableView的headerView */
- (void)configTableHeader{
    if (self.latestVM.headImageURLs.count == 0) {
        return;
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 185)];
    [_sdVC removeFromParentViewController]; //  把之前的child移除，再新建
    
    NSMutableArray *arr = [NSMutableArray new];
    for (ELNewsResultFocusimgModel *model in self.latestVM.headImageURLs) {
        [arr addObject: [NSURL URLWithString:model.imgurl]];
    }
    
    _sdVC = [[ScrollDisplayViewController alloc] initWithImagePaths:arr];
    _sdVC.delegate = self;
    _sdVC.currentPageIndicatorTintColor = [UIColor redColor];
    _sdVC.pageControlOffset = 10;
    [self addChildViewController:_sdVC];
    [headerView addSubview:_sdVC.view];
    [_sdVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(headerView);
    }];
    _tableView.tableHeaderView = headerView;
}
#pragma mark *** <UITableViewDataSource> ***

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.latestVM.rowNumber;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    LatestCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

//配置Cell
    [cell.iconIV sd_setImageWithURL:[self.latestVM iconURLForRow:indexPath.row]];//网络加载用的是SDWeb的，据说SDWeb比AF快0.03s
    cell.titleLb.text = [self.latestVM titleForRow:indexPath.row];
    cell.dateLb.text = [self.latestVM dateForRow:indexPath.row];
    cell.commentLb.text = [self.latestVM commentNumberForRow:indexPath.row];

    return cell;
    
}
/** 让分割线左侧无空隙 */
kRemoveCellSeparator

#pragma mark *** <UITableViewDelegate> ***

/** 松手后去掉高亮状态 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *vc = [[DetailViewController alloc] initWithID:[self.latestVM IDForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark *** ScrollDisplayViewControllerDelegate ***

- (void)scrollDisplayViewController: (ScrollDisplayViewController *)scrollDisplayViewController didSelectIndex: (NSInteger)index{
    
    DetailViewController *detailVC = [[DetailViewController alloc] initWithID:[self.latestVM adIDForRow:index]];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    DDLogVerbose(@"ScrollDisplayViewControllerDelegate:%ld",index);
}


@end

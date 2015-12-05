//
//  LatestViewModel.h
//  汽车之家
//
//  Created by LYF on 15/10/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//  最新界面的视图模型

#import "BaseViewModel.h"
#import "ELNewsNetManager.h"

@interface LatestViewModel : BaseViewModel

@property (nonatomic) NSInteger rowNumber;

/** 分页加载，必须要有可变的字典 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/** 头部滚动栏的图片数组 */
@property (nonatomic, strong) NSArray *headImageURLs;
/** 最后一条数据的更新时间 */
@property (nonatomic, strong) NSString *updateTime;
/** 标记页数 */
@property (nonatomic) NSInteger page;
/** 类型 */
@property (nonatomic) NewsListType type;

/** 图标的URL地址 */
- (NSURL *)iconURLForRow: (NSInteger)row;
/** 标题 */
- (NSString *)titleForRow: (NSInteger)row;
/** 日期 */
- (NSString *)dateForRow: (NSInteger)row;
/** 评论数量 */
- (NSString *)commentNumberForRow: (NSInteger)row;
/** 刷新 */
- (void)refreshDataCompleteHandle: (void(^)(NSError *error))complete;
/** 加载更多 */
- (void)getMoreDataCompleteHandle: (void(^)(NSError *error))complete;

- (id)initWithNewsListType: (NewsListType)type;
/** 通过滚动展示烂的索引值，获取对应的数据ID */
- (NSNumber *)adIDForRow: (NSInteger)row;


- (NSNumber *)IDForRow: (NSInteger)row;

@end

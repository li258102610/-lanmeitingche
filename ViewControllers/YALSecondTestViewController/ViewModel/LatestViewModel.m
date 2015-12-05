//
//  LatestViewModel.m
//  汽车之家
//
//  Created by LYF on 15/10/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "LatestViewModel.h"

@implementation LatestViewModel
- (NSNumber *)IDForRow: (NSInteger)row{
    return [self newsListModelForRow:row].ID;
}
- (instancetype)initWithNewsListType:(NewsListType)type
{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}
- (NSInteger)rowNumber{
    return self.dataArr.count;
}

- (NSMutableArray *)dataArr {
	if(_dataArr == nil) {
		_dataArr = [[NSMutableArray alloc] init];
	}
	return _dataArr;
}

- (ELNewsResultNewslistModel *)newsListModelForRow: (NSInteger)row{
    return self.dataArr[row];
}

- (NSURL *)iconURLForRow: (NSInteger)row{
    return [NSURL URLWithString:[self newsListModelForRow:row].smallpic];
}

- (NSString *)titleForRow: (NSInteger)row{
    return [self newsListModelForRow:row].title;
}

- (NSString *)dateForRow: (NSInteger)row{
    return [self newsListModelForRow:row].time;
}

- (NSString *)commentNumberForRow: (NSInteger)row{
    return [[self newsListModelForRow:row].replycount.stringValue stringByAppendingString:@"评论"];
}

- (void)getDataCompleteHandle: (void(^)(NSError *error))complete{
    
    [ELNewsNetManager getNewsListType: _type
                             lastTime: _updateTime
                                 page: _page
                     completionHandle:^(ELNewsModel *model, NSError *error) {
    //  如果是下拉刷新，则必须清空数组
        if (_updateTime == 0) {
            [self.dataArr removeAllObjects];
        }
        [self.dataArr addObjectsFromArray:model.result.anewslist];
        
        self.headImageURLs = [model.result.focusimg copy]; //  把可变的数组转换成不可变的数组
        complete(error);
    }];
}

- (void)refreshDataCompleteHandle: (void(^)(NSError *error))complete{
    _updateTime = @"0";
    _page = 1;
    [self getDataCompleteHandle:complete];
}

- (void)getMoreDataCompleteHandle: (void(^)(NSError *error))complete{
    ELNewsResultNewslistModel *obj = self.dataArr.lastObject;
    _updateTime = obj.lasttime;
    _page += 1;
    [self getDataCompleteHandle:complete];
}

- (NSNumber *)adIDForRow: (NSInteger)row{
//通过row获取到对应的 focusimg 数据项
    ELNewsResultFocusimgModel *model = self.headImageURLs[row];
//从数据项种获得ID返回
    return model.ID;
}
@end

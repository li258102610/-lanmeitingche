//
//  ELNewsNetManager.m
//  汽车之家
//
//  Created by LYF on 15/10/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ELNewsNetManager.h"

@implementation ELNewsNetManager

+ (id)getNewsListType: (NewsListType)type
             lastTime: (NSString *)time
                 page: (NSInteger)page
     completionHandle: (void(^)(ELNewsModel *model,NSError *error))completionHandle{
//  需要根据不同类型，设置对应的
    NSString *path = nil;
//    修改链接地址为p%@,l%@,对应page和time
    switch (type) {
//        case NewslistTypeZuiXin:
//            path = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt0-p%@-s30-l%@.json",@(page),time];
//            break;
        case NewslistTypeXinWen:
            path = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt1-p%@-s30-l%@.json",@(page),time];
//            break;
//        case NewslistTypePinCe:
//            path = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt3-p%@-s30-l%@.json",@(page),time];
//            break;
//        case NewslistTypeDaoGou:
//            path = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt60-p%@-s30-l%@.json",@(page),time];
//            break;
//        case NewslistTypeHangQing:
//            path = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c110100-nt2-p%@-s30-l%@.json",@(page),time];
//            break;
//        case NewslistTypeYongChe:
//            path = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt82-p%@-s30-l%@.json",@(page),time];
//            break;
//        case NewslistTypeJiShu:
//            path = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt102-p%@-s30-l%@.json",@(page),time];
//            break;
//        case NewslistTypeWenHua:
//            path = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt97-p%@-s30-l%@.json",@(page),time];
//            break;
//        case NewslistTypeGaiZhuang:
//            path = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt107-p%@-s30-l%@.json",@(page),time];
//            break;
//        case NewslistTypeYouJi:
//            path = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt100-p%@-s30-l%@.json",@(page),time];
//            break;
        default:
            break;
    }
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([ELNewsModel objectWithKeyValues:responseObj],error);
    }];
}


@end

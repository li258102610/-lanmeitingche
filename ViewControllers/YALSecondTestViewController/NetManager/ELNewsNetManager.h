//
//  ELNewsNetManager.h
//  汽车之家
//
//  Created by LYF on 15/10/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "ELNewsModel.h"

typedef NS_ENUM(NSUInteger,NewsListType){
//    NewslistTypeZuiXin,     //最新
    NewslistTypeXinWen,     //新闻
//    NewslistTypePinCe,      //评测
//    NewslistTypeDaoGou,     //导购
//    NewslistTypeHangQing,   //行情
//    NewslistTypeYongChe,    //用车
//    NewslistTypeJiShu,      //技术
//    NewslistTypeWenHua,     //文化
//    NewslistTypeGaiZhuang,  //改装
//    NewslistTypeYouJi,      //游记
} ;

@interface ELNewsNetManager : BaseNetManager

//通过type区分请求的地址
+ (id)getNewsListType: (NewsListType)type
             lastTime: (NSString *)time
                 page: (NSInteger)page
     completionHandle: (void(^)(ELNewsModel *model,NSError *error))completionHandle;




@end


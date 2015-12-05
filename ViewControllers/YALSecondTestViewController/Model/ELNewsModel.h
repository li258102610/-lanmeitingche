//
//  ELNewsModel.h
//  汽车之家
//
//  Created by LYF on 15/10/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//  数据解析

#import "BaseModel.h"

@class ELNewsResultModel,ELNewsResultFocusimgModel,ELNewsResultHeadlineinfoModel,ELNewsResultNewslistModel,ELNewsResultHeadTopnewsinfoModel;

@interface ELNewsModel : BaseModel

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSNumber *returncode;
@property (nonatomic, strong) ELNewsResultModel *result;

@end

@interface ELNewsResultModel : BaseModel

@property (nonatomic, strong) NSArray *focusimg;
@property (nonatomic, strong) ELNewsResultHeadlineinfoModel *headlineinfo;
@property (nonatomic, strong) NSNumber *isloadmore;
@property (nonatomic, strong) NSArray *anewslist;
@property (nonatomic, strong) NSNumber *rowcount;
@property (nonatomic, strong) ELNewsResultHeadTopnewsinfoModel *topnewsinfo;

@end

@interface ELNewsResultFocusimgModel : BaseModel

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, strong) NSNumber *JumpType;
@property (nonatomic, strong) NSString *jumpurl;
@property (nonatomic, strong) NSNumber *mediatype;
@property (nonatomic, strong) NSNumber *pageindex;
@property (nonatomic, strong) NSNumber *replycount;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *updatetime;

@end

@interface ELNewsResultHeadlineinfoModel : BaseModel

@property (nonatomic, strong) NSString *updatetime;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *smallpic;
@property (nonatomic, strong) NSNumber *replycount;
@property (nonatomic, strong) NSNumber *pagecount;
@property (nonatomic, strong) NSNumber *mediatype;
@property (nonatomic, strong) NSString *lasttime;
@property (nonatomic, strong) NSNumber *jumppage;
@property (nonatomic, strong) NSString *indexdetail;
@property (nonatomic, strong) NSNumber *ID;


@end

@interface ELNewsResultNewslistModel : ELNewsResultHeadlineinfoModel

@property (nonatomic, strong) NSNumber *anewstype;   //变量的名字不能以new开头
@property (nonatomic, strong) NSNumber *dbid;
@property (nonatomic, strong) NSString *intacttime;

@end

@interface ELNewsResultHeadTopnewsinfoModel : BaseModel

@end
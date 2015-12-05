//
//  ELNewsModel.m
//  汽车之家
//
//  Created by LYF on 15/10/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ELNewsModel.h"

@implementation ELNewsModel
/** MJ会自动判断某个key对应的属性是什么类型，如果是字典类型，则会通过与这个key相同的名称的类型 进行解析 */

@end

@implementation ELNewsResultModel

+ (NSDictionary *)objectClassInArray{
    //key 需要填属性，表示某个数组属性中的元素对应的特殊解析类
    return @{@"focusimg":[ELNewsResultFocusimgModel class],
             @"anewslist":[ELNewsResultNewslistModel class]};
}

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"anewslist":@"newslist"};
}
@end

@implementation ELNewsResultFocusimgModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
} 

@end

@implementation ELNewsResultHeadlineinfoModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

@end

@implementation ELNewsResultNewslistModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID":@"id",@"anewstype":@"newstype"};
}

@end

@implementation ELNewsResultHeadTopnewsinfoModel


@end



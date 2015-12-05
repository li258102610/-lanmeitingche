//
//  BaseNetManager.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"

static AFHTTPRequestOperationManager *manager = nil;

@implementation BaseNetManager

+ (AFHTTPRequestOperationManager *)sharedAFManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    });
    return manager;
}

+ (id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{
    return [[self sharedAFManager] GET:path parameters:params success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        complete(responseObject, nil);
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        complete(nil, error);
    }];
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{
    return [[self sharedAFManager] POST:path parameters:params success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        complete(responseObject, nil);
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        complete(nil, error);
    }];
}

@end

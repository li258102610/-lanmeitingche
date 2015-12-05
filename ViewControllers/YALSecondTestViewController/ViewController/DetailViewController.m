//
//  DetailViewController.m
//  汽车之家
//
//  Created by LYF on 15/10/23.
//  Copyright © 2015年 Tarena. All rights reserved.
//  

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, strong) NSNumber *ID;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [UIWebView new];
    [self.view addSubview: webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    NSString *path = [NSString stringWithFormat:@"http://cont.app.autohome.com.cn/autov5.0.0/content/news/newscontent-n%@-t0-rct1.json",_ID];
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (instancetype)initWithID:(NSNumber *)ID
{
    self = [super init];
    if (self) {
        self.ID = ID;
    }
    return self;
}

@end

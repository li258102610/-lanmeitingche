//
//  AboutViewController.m
//  Login
//
//  Created by ParkerLovely on 15/11/9.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

#import "AboutViewController.h"
#import "ParkViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)back:(id)sender {
    
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景"]];
    [self.view addSubview:imageView];
    
    
}

@end

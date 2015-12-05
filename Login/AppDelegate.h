//
//  AppDelegate.h
//  Login
//
//  Created by ParkerLovely on 15/11/8.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMDrawerController;

@class YALFoldingTabBarController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MMDrawerController *drawerController;
@property(nonatomic,getter=isOnLine) BOOL onLine; //网络状态
- (void)buildUserInterface;
- (YALFoldingTabBarController *)setupYALTabBarController;

@end


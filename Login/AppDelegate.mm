//
//  AppDelegate.m
//  Login
//
//  Created by ParkerLovely on 15/11/8.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "RightViewController.h"
//model
#import "YALTabBarItem.h"

//controller
#import "YALFoldingTabBarController.h"

//helpers
#import "YALAnimatingTabBarConstants.h"
//Baidu Map
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "BNCoreServices.h"

#import "OilPriceViewContro.h"
#import "ParkViewController.h"
#import "ContainerViewController.h"

#import "QuaryViewController.h"

@interface AppDelegate ()
@property(nonatomic,strong)BMKMapManager* mgr;
@end

@implementation AppDelegate

-(BMKMapManager *)mgr{
    if (!_mgr) {
        _mgr = [BMKMapManager new];
    }
    return _mgr;
}


- (YALFoldingTabBarController *)setupYALTabBarController {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    YALFoldingTabBarController *tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"YALFoldingTabBarController"];
       //prepare leftBarItems
    YALTabBarItem *item1 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"违章"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
   
    ContainerViewController* newsVc = [storyboard instantiateViewControllerWithIdentifier:@"ContainerViewController"];
    UINavigationController  *newsVn = [[UINavigationController alloc]initWithRootViewController:newsVc];
    
    QuaryViewController *quaryVC = [storyboard instantiateViewControllerWithIdentifier:@"QuaryViewController"];
    
    UINavigationController *quaryNavi = [[UINavigationController alloc] initWithRootViewController:quaryVC];
    
    tabBarController.viewControllers = @[quaryNavi,[OilPriceViewContro new],[ParkViewController new],newsVn];
    
    YALTabBarItem *item2 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"油价"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
    
    tabBarController.leftBarItems = @[item1, item2];
    
    //prepare rightBarItems
    YALTabBarItem *item3 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"地图"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
    
    
    YALTabBarItem *item4 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"新闻"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
    
    tabBarController.rightBarItems = @[item3, item4];
    
    tabBarController.centerButtonImage = [UIImage imageNamed:@"plus_icon"];
    
    tabBarController.selectedIndex = 2;
    
    //customize tabBarView
    tabBarController.tabBarView.extraTabBarItemHeight = YALExtraTabBarItemsDefaultHeight;
    tabBarController.tabBarView.offsetForExtraTabBarItems = YALForExtraTabBarItemsDefaultOffset;
//    tabBarController.tabBarView.backgroundColor = [UIColor colorWithRed:94.0/255.0 green:91.0/255.0 blue:149.0/255.0 alpha:1];
    tabBarController.tabBarView.backgroundColor = nil;
    tabBarController.tabBarView.tabBarColor = [UIColor colorWithRed:40.0/255.0 green:47/255.0 blue:67/255.0 alpha:1];
    tabBarController.tabBarView.dotColor = [UIColor colorWithRed:94.0/255.0 green:91.0/255.0 blue:149.0/255.0 alpha:1];
    tabBarController.tabBarViewHeight = YALTabBarViewDefaultHeight;
    tabBarController.tabBarView.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets;
    tabBarController.tabBarView.tabBarItemsEdgeInsets = YALTabBarViewItemsDefaultEdgeInsets;
    
    return tabBarController;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    BOOL isSuccess = [self.mgr start:@"p71FkHXY0z507UbIixqeosja" generalDelegate:nil];
    if (isSuccess) {
        NSLog(@"授权成功");
    }
    //初始化导航SDK
    //BK5ip9xv4lfoAZGokPocNbV7
    [BNCoreServices_Instance initServices:@"p71FkHXY0z507UbIixqeosja"];
    [BNCoreServices_Instance startServicesAsyn:nil fail:nil];
    
    
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:40/255.0 green:47/255.0 blue:67/255.0 alpha:1]];
    //设置有导航条时，状态栏的文字颜色
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    //设置导航条的背景图
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavigationBarDefault"] forBarMetrics:UIBarMetricsDefault];
    //设置左右按钮上的文字颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    
    
    
    [Parse enableLocalDatastore];
    // Initialize Parse.
    [Parse setApplicationId:@"P74EfIKpwjJ9d0aVNIFZOYrgph2oT9dtRdVUGnll"
                  clientKey:@"yPnHSUR73SFvggpMB7sqqhIiQo8ddNBUBRI9Qc2u"];
    
    
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];
    
    
    // [Optional] Track statistics around application opens.
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //从UserDefault中获取user，ifuser存在，从storyboard中取出主界面，放到navi中，把window的root设置为navi
    [self buildUserInterface];
    
    //return [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
    
}

- (void)buildUserInterface{
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_name"];
    if (userName) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];


        
        YALFoldingTabBarController *mainController = [self setupYALTabBarController];
        
        LeftViewController *leftVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
        
       
        
        RightViewController *rightVC = [storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
        self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:mainController leftDrawerViewController:leftVC rightDrawerViewController:rightVC];
        
        
        
        //self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
       self.drawerController.closeDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
        
        
        self.window.rootViewController = self.drawerController;
    }

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:annotation];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

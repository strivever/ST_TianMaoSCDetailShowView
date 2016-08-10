//
//  AppDelegate.m
//  STNavBar
//
//  Created by StriEver on 16/8/5.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HomePageViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //a.初始化一个tabBar控制器
         UITabBarController *tb=[[UITabBarController alloc]init];
         //设置控制器为Window的根控制器
         self.window.rootViewController=tb;
    
         //b.创建子控制器
        HomePageViewController * v1 = [[HomePageViewController alloc]init];
         UIViewController * v2 = [[UIViewController alloc]init];
         UIViewController * v3 = [[UIViewController alloc]init];
         UIViewController * v4 = [[UIViewController alloc]init];
    
         UINavigationController *c1=[[UINavigationController alloc]initWithRootViewController:v1];
         c1.view.backgroundColor=[UIColor grayColor];
         c1.tabBarItem.title=@"消息";
         c1.tabBarItem.image=[UIImage imageNamed:@"tab_recent_nor"];
         c1.tabBarItem.badgeValue=@"123";
    
         UINavigationController *c2=[[UINavigationController alloc]initWithRootViewController:v2];
         c2.view.backgroundColor=[UIColor brownColor];
         c2.tabBarItem.title=@"联系人";
         c2.tabBarItem.image=[UIImage imageNamed:@"tab_buddy_nor"];
    
         UINavigationController *c3=[[UINavigationController alloc]initWithRootViewController:v3];
         c3.tabBarItem.title=@"动态";
         c3.tabBarItem.image=[UIImage imageNamed:@"tab_qworld_nor"];
    
         UINavigationController *c4=[[UINavigationController alloc]initWithRootViewController:v4];
         c4.tabBarItem.title=@"设置";
         c4.tabBarItem.image=[UIImage imageNamed:@"tab_me_nor"];
    
    
    
         //c.添加子控制器到ITabBarController中
         //c.1第一种方式
     //    [tb addChildViewController:c1];
     //    [tb addChildViewController:c2];
    
         //c.2第二种方式
         tb.viewControllers=@[c1,c2,c3,c4];
         self.window.rootViewController = tb;
        [self.window makeKeyAndVisible];
         return YES;
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

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

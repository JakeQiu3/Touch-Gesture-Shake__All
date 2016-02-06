//
//  AppDelegate.m
//  摇晃事件 大全
//
//  Created by 邱少依 on 15/12/29.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "AppDelegate.h"
#import "TouchEventViewController.h"
#import "GestureRecognizerViewController.h"
#import "ShakeViewController.h"
#import "RemoteControlViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
////    测试1：触摸
//    TouchEventViewController *mainVC = [[TouchEventViewController alloc] init];
//    测试2：手势
//    GestureRecognizerViewController *mainVC = [[GestureRecognizerViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
////    测试3：摇动
//    ShakeViewController *mainVC = [[ShakeViewController alloc] init];
//    测试4：远程控制
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:23/255.0 green:180/255.0 blue:237/255.0 alpha:1]];
    [[UINavigationBar appearance]setTintColor:[UIColor redColor]];
    RemoteControlViewController *mainVC = [[RemoteControlViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = nav;

    //设置播放会话，在后台可以继续播放（还需要设置程序允许后台运行模式）
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil];
    if(![[AVAudioSession sharedInstance] setActive:YES error:nil])
    {
        NSLog(@"Failed to set up a session.");
    }
    //启用远程控制事件接收
    [[UIApplication sharedApplication]beginReceivingRemoteControlEvents];
    
    [self.window makeKeyAndVisible];

    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
// 进入后台时，开始任务
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[UIApplication sharedApplication]beginBackgroundTaskWithExpirationHandler:^{
        
    }];
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

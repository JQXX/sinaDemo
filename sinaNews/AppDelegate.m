//
//  AppDelegate.m
//  sinaNews
//
//  Created by a on 16/6/21.
//  Copyright © 2016年 J. All rights reserved.
//

#import "AppDelegate.h"
#import "ShouyeViewController.h"
#import "RemenViewController.h"
#import "FaxianViewController.h"
#import "WodeViewController.h"


#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"



@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)createTabBarController{
    UITabBarController *tbc = [[UITabBarController alloc]init];
    
    NSArray *vcName = @[@"ShouyeViewController",@"RemenViewController",@"FaxianViewController",@"WodeViewController"];
    NSMutableArray *vcArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < vcName.count; i++) {
        Class cls = NSClassFromString(vcName[i]);
        UIViewController *vc = [[cls alloc]init];
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:vc];
        [vcArr addObject:nc];
    }
    
    tbc.viewControllers = vcArr;
    
    
    self.window.rootViewController = tbc;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    [UMSocialData setAppKey:@"5731a50667e58e2af10007f0"];
    [UMSocialData openLog:NO];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx9901cab3c1514d11" appSecret:@"73263113c92e6af0a174efcb14d1da8f" url:@"http://www.baidu.com"];
    
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1105431905" appKey:@"loAGShMVAanEFwBs" url:@"http://www.baidu.com"];
    
    
    
    [self createTabBarController];
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
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

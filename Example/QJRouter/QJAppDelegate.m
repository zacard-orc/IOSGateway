//
//  QJAppDelegate.m
//  QJRouter
//
//  Created by jz on 12/02/2019.
//  Copyright (c) 2019 jz. All rights reserved.
//

#import "QJAppDelegate.h"
#import "Gateway/QJRouter.h"

#import "Atom/Imei.h"
#import "Atom/OpsTime.h"

#import "Basic/UserInfo.h"

#import "Components/NiceMgr.h"

#import "Scene/ExpressVC.h"
#import "Scene/ItemListVC.h"
#import "Scene/JmeVC.h"
#import "Scene/WKVideo.h"
#import "Scene/PreLoadVC.h"
#import "Scene/PreLoadDoubanVC.h"
#import "Scene/PreLoadQQVC.h"
#import "Scene/RNVC.h"
#import "Scene/SyncVC.h"


#import <sys/time.h>
#include <math.h>

//#import <React/RCTRootView.h>
//#import "RNVC.h"

//#import <JavaScriptCore/JavaScriptCore.h>

@implementation QJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    struct timeval start, end;
    long timeuse;

    gettimeofday(&start, NULL);

    gettimeofday(&end, NULL);
    timeuse = 1000000 * ( end.tv_sec - start.tv_sec ) + end.tv_usec - start.tv_usec;
    printf("timeuse => %ld\n",timeuse);
    
    
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    RNVC *rnvc = [[RNVC alloc] init];
//    self.window.rootViewController = rnvc;
//
//    NSURL *url = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios&dev=true"];
//    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:url moduleName:@"RNDemo" initialProperties:nil launchOptions:nil];
//    rnvc.view = rootView;
//
//    [self.window makeKeyAndVisible];
     

    // Override point for customization after application launch.
    QJRouter.sharedInstance.atomArray = @[
              NSStringFromClass([Imei class]),
              NSStringFromClass([OpsTime class])
            ];
    
    QJRouter.sharedInstance.basicArray = @[
              NSStringFromClass([UserInfo class]),
            ];
    
    QJRouter.sharedInstance.componentArray = @[
               NSStringFromClass([NiceMgr class]),
            ];
    
    QJRouter.sharedInstance.sceneArray = @[
               NSStringFromClass([ExpressVC class]),
               NSStringFromClass([ItemListVC class]),
               NSStringFromClass([JmeVC class]),
               NSStringFromClass([WKVideo class]),
               NSStringFromClass([PreLoadVC class]),
               NSStringFromClass([PreLoadDoubanVC class]),
               NSStringFromClass([PreLoadQQVC class]),
               NSStringFromClass([RNVC class]),
               NSStringFromClass([SyncVC class]),
            ];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

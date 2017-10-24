//
//  AppDelegate.m
//  BackgroundTest
//
//  Created by sunhay on 2017/10/24.
//  Copyright © 2017年 iDreamSky. All rights reserved.
//

#import "AppDelegate.h"
#import "ZCTask.h"
#import "ZCLocation.h"

@interface AppDelegate ()
{
    NSUInteger count;
}

@property (strong, nonatomic) ZCTask *task;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) ZCLocation *location;
@property (strong, nonatomic) CLLocationManager *manager;


@end

@implementation AppDelegate


-(void)log {
    NSLog(@"start! %lu", count++);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (application.backgroundRefreshStatus == UIBackgroundRefreshStatusDenied) {
        NSLog(@"Device is disable location service.");
    } else if (application.backgroundRefreshStatus == UIBackgroundRefreshStatusRestricted) {
        NSLog(@"Can't locate the device.");
    } else {
    }
    [[ZCLocation main] startLocation];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(log) userInfo:nil repeats:YES];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSLog(@"1 dead!");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"2 dead!");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSLog(@"3 dead!");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"4 dead!");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"dead!");
}


@end

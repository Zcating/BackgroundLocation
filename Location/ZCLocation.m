//
//  ZCLocation.m
//  BackgroundTest
//
//  Created by sunhay on 2017/10/24.
//  Copyright © 2017年 iDreamSky. All rights reserved.
//

#import "ZCLocation.h"
#import "ZCTask.h"
@import UIKit;
@import CoreLocation;


@interface TestLocationManager : CLLocationManager


@end

@implementation TestLocationManager

-(void)dealloc {
    NSLog(@"Location dealloc!");
}


@end


@implementation ZCLocation

+(instancetype)main {
    static ZCLocation *location = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[ZCLocation alloc] init];
    });
    return location;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
        self.manager = [[TestLocationManager alloc] init];
        self.manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        self.manager.allowsBackgroundLocationUpdates = YES;
        self.manager.pausesLocationUpdatesAutomatically = NO;
    }
    return self;
}


-(void)applicationEnterBackground {
    NSLog(@"Restart location!");
    self.manager.delegate = self;
    self.manager.distanceFilter = kCLDistanceFilterNone;
    [self.manager requestAlwaysAuthorization];
    [self.manager startUpdatingLocation];
//    [self.task beginNewBackgroundTask];
}

-(void)restartLocation {
    NSLog(@"Restart Location.");
    self.manager.delegate = self;
    self.manager.distanceFilter = kCLDistanceFilterNone;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        [self.manager requestAlwaysAuthorization];
    }
    [self.manager startUpdatingLocation];
//    [self.task beginNewBackgroundTask];
}

-(void)startLocation {
    NSLog(@"Start Location.");
    if ([CLLocationManager locationServicesEnabled] == NO) {
        NSLog(@"Location Services is disabled");
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"tips" message:@"Please enable your location services" preferredStyle:UIAlertControllerStyleAlert];
//        id action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
//        [alert addAction:action];
//        id rootVC = [[[UIApplication sharedApplication].delegate window] rootViewController];
//        [rootVC presentViewController:alert animated:YES completion:nil];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"tips" message:@"Please enable your location services" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        NSLog(@"%@, %@",alertView.superview, alertView.subviews);
    } else {
        self.manager.distanceFilter = kCLDistanceFilterNone;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            [self.manager requestAlwaysAuthorization];
        }
        [self.manager startUpdatingLocation];
    }
}

-(void)stopLocation {
    NSLog(@"Stop Location.");
    self.isCollected = NO;
    [self.manager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (self.isCollected) {
        return;
    }
    NSLog(@"%@", locations);
//    [self performSelector:@selector(restartLocation) withObject:nil afterDelay:20];
//    [self performSelector:@selector(stopLocation) withObject:nil afterDelay:10];
    self.isCollected = YES;
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    switch ([error code]) {
        case kCLErrorNetwork:
            break;
        case kCLErrorDenied:
            break;
        default:
            break;
    }
    NSLog(@"%@", error);
}

@end






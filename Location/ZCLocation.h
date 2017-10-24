//
//  ZCLocation.h
//  BackgroundTest
//
//  Created by sunhay on 2017/10/24.
//  Copyright © 2017年 iDreamSky. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
@class ZCTask;
@class TestLocationManager;

@interface ZCLocation : NSObject<CLLocationManagerDelegate>

+(instancetype)main;

//@property (strong, nonatomic) ZCTask *task;
@property (strong, nonatomic) NSTimer *restarTimer;
@property (strong, nonatomic) NSTimer *closeCollectLocaionTimer;

@property (strong, nonatomic) TestLocationManager *manager;

@property BOOL isCollected;

-(void)startLocation;

@end

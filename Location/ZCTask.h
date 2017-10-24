//
//  ZCTask.h
//  BackgroundTest
//
//  Created by sunhay on 2017/10/24.
//  Copyright © 2017年 iDreamSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ZCTask : NSObject

@property (strong, nonatomic) NSMutableArray *taskIDList;

@property UIBackgroundTaskIdentifier masterID;

+(instancetype)shared;

-(UIBackgroundTaskIdentifier)beginNewBackgroundTask;
-(void)endBackgroundTask:(BOOL)all;

@end

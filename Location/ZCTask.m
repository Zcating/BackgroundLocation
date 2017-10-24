//
//  ZCTask.m
//  BackgroundTest
//
//  Created by sunhay on 2017/10/24.
//  Copyright © 2017年 iDreamSky. All rights reserved.
//

#import "ZCTask.h"

@implementation ZCTask

+(instancetype)shared {
    static ZCTask *task;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        task = [[ZCTask alloc] init];
    });
    return task;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.taskIDList = [NSMutableArray array];
        self.masterID = UIBackgroundTaskInvalid;
    }
    return self;
}

-(UIBackgroundTaskIdentifier)beginNewBackgroundTask {

    UIApplication *application = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier taskID = UIBackgroundTaskInvalid;
    if ([application respondsToSelector:@selector(beginBackgroundTaskWithExpirationHandler:)]) {
        taskID = [application beginBackgroundTaskWithExpirationHandler:^{
            NSLog(@"task ID%lu, it has expirated", taskID);
            [self.taskIDList removeObject:@(taskID)];
            taskID = UIBackgroundTaskInvalid;
            [application endBackgroundTask:taskID];
        }];
    }
    if (self.masterID == UIBackgroundTaskInvalid) {
        self.masterID = taskID;
        NSLog(@"start background task: %lu", taskID);
    } else {
        NSLog(@"keep background task: %lu", taskID);
        [self.taskIDList addObject:@(taskID)];
        [self endBackgroundTask:NO];
    }
    return taskID;
}

-(void)endBackgroundTask:(BOOL)all {
    UIApplication *application = [UIApplication sharedApplication];
    if ([application respondsToSelector:@selector(endBackgroundTask:)]) {
        for (int index = 0; index < (all ? self.taskIDList.count:self.taskIDList.count - 1); index++) {
            UIBackgroundTaskIdentifier taskID = [self.taskIDList[0] integerValue];
            NSLog(@"close task: %ld", taskID);
            [application endBackgroundTask:taskID];
            [self.taskIDList removeObjectAtIndex:0];
        }
    }

    if (self.taskIDList.count > 0) {
        NSLog(@"running task: %@", self.taskIDList[0]);
    }
    if (all) {
        [[UIApplication sharedApplication] endBackgroundTask:self.masterID];
        self.masterID = UIBackgroundTaskInvalid;
    } else {
        NSLog(@"kept master task: %lu", self.masterID);
    }
}


@end

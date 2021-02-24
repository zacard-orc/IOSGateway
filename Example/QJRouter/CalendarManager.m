//
//  CalendarManager.m
//  QJRouter_Example
//
//  Created by yujie_900 on 2021/2/23.
//  Copyright © 2021 jz. All rights reserved.
//

#import "CalendarManager.h"
#import <React/RCTLog.h>


@implementation CalendarManager
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(addEvent:(NSString *)name location:(NSString *)location){
    NSLog(@"Pretending to create an event %@ at %@", name, location);
    RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

- (NSDictionary *)constantsToExport
{
  return @{ @"firstDayOfTheWeek": @"Monday" };
}

+ (BOOL)requiresMainQueueSetup{
    return YES;
}
@end

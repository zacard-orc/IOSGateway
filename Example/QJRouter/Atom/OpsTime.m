//
//  OpsTime.m
//  QJRouter_Example
//
//  Created by king on 2021/1/23.
//  Copyright © 2021 jz. All rights reserved.
//

#import "OpsTime.h"
#import <Foundation/NSDate.h>
#import <Foundation/NSDateFormatter.h>

@implementation OpsTime
-(NSString*)getTime{
    static NSDateFormatter *timeStampFormat;
    if (!timeStampFormat) {
        timeStampFormat = [[NSDateFormatter alloc] init];
        [timeStampFormat setDateFormat:@"HH:mm:ss.SSS"];
        [timeStampFormat setTimeZone:[NSTimeZone systemTimeZone]];
    }
    return [timeStampFormat stringFromDate:[NSDate date]];
}
@end

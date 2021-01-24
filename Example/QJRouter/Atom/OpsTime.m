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
//    timeStampFormat = [[NSDateFormatter alloc] init];
//    [timeStampFormat setDateFormat:@"HH:mm:ss.SSS"];
//    [timeStampFormat setTimeZone:[NSTimeZone systemTimeZone]];
//    NSString *ddtime = [[timeStampFormat stringFromDate:[NSDate date]] copy];
//    [timeStampFormat release];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
//    NSString *bbb = [NSString stringWithUTF8String:[currentTimeString UTF8String]];

//    NSString *bbb = [NSString stringWithUTF8String:"aaaa2222"];
//    NSLog(@"currentTimeString =  %@",currentTimeString);
    return currentTimeString;
//    return bbb;
}
@end

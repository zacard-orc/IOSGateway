//
//  Imei.m
//  QJRouter_Example
//
//  Created by king on 2021/1/23.
//  Copyright © 2021 jz. All rights reserved.
//

#import "Imei.h"

@implementation Imei
-(NSString*)getImei:(int)idx{
    if(idx==0){
        return @"aaaa-23902322-2939232-9999";
    } else if (idx==1){
        return @"bbbb-23902322-2939232-9999";
    } else{
        return @"cccc-23902322-2939232-9999";
    }
}

-(NSString*)getImeiAsync:(int)idx useCb:(BLOCKDEF_IMEI_ASYNC)callback{
    callback(@"usecb-cccc-23902322-2939232-9999");
    return @"getImeiAsync usecb";
}
@end

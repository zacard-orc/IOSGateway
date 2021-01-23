//
//  Imei.h
//  QJRouter_Example
//
//  Created by king on 2021/1/23.
//  Copyright © 2021 jz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Imei : NSObject
-(NSString*)getImei:(int)idx;
-(NSString*)getImeiAsync:(int)idx useCb:(BLOCKDEF_IMEI_ASYNC)callback;
@end


NS_ASSUME_NONNULL_END

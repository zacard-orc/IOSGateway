//
//  types.h
//  QJRouter_Example
//
//  Created by king on 2021/1/23.
//  Copyright © 2021 jz. All rights reserved.
//

#ifndef types_h
#define types_h
#include <Foundation/Foundation.h>

typedef NSString *_Nullable(^BLOCKDEF_IMEI)(int);
typedef void *_Nullable(^BLOCKDEF_IMEI_ASYNC)(NSString *_Nullable);
typedef NSString *_Nullable(^BLOCKDEF_TIME)(NSString*_Nullable,int);
typedef NSString *_Nullable(^BLOCKDEF_USERINFO)(NSString*_Nullable);


#endif /* types_h */



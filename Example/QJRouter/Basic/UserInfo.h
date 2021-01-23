//
//  UserInfo.h
//  QJRouter_Example
//
//  Created by king on 2021/1/23.
//  Copyright © 2021 jz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject
@property (nonatomic,strong) NSString* name;
@property (nonatomic,assign) int age;

-(void)setName:(NSString*)name;
-(void)setAge:(int)age;
-(NSString *)getName:(BLOCKDEF_USERINFO)callback;
@end

NS_ASSUME_NONNULL_END

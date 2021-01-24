//
//  UserInfo.m
//  QJRouter_Example
//
//  Created by king on 2021/1/23.
//  Copyright © 2021 jz. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
-(void)setName:(NSString*)name{
    NSLog(@"save %@",name);
    _name = name;
}
-(void)setAge:(int)age{
    _age =age;
}
-(NSString *)getName:(BLOCKDEF_USERINFO)callback{
    NSLog(@"done cb _name");
    callback(_name);
    return @"done";
}
@end

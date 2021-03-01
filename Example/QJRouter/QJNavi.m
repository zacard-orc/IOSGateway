//
//  QJNavi.m
//  QJRouter_Example
//
//  Created by yujie_900 on 2021/2/24.
//  Copyright © 2021 jz. All rights reserved.
//

#import "QJNavi.h"
#define  linRGBA(r,g,b,a) [UIColor colorWithRed:r / 255.0  green:g / 255.0 blue:b / 255.0 alpha:a]

@implementation QJNavi
+ (void)initialize {
    //修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //设置导航栏背景颜色
    [navBar setBarTintColor:linRGBA(254,204,69,0.5)];

}
@end

//
//  ExpressVC.m
//  QJRouter_Example
//
//  Created by king on 2021/1/23.
//  Copyright © 2021 jz. All rights reserved.
//

#import "ExpressVC.h"

@implementation ExpressVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 300, 300, 40)];
    label.text = @"这里是 物流页 Express balabala";
    [self.view addSubview:label];
}

@end

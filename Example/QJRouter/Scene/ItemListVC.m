//
//  ItemListVC.m
//  QJRouter_Example
//
//  Created by king on 2021/1/23.
//  Copyright © 2021 jz. All rights reserved.
//

#import "ItemListVC.h"

@implementation ItemListVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 300, 300, 40)];
    label.text = @"这里是 商品列表页 ItemList balabala";
    [self.view addSubview:label];
}
@end

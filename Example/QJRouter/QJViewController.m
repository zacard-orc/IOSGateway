//
//  QJViewController.m
//  QJRouter
//
//  Created by jz on 12/02/2019.
//  Copyright (c) 2019 jz. All rights reserved.
//

#import "QJViewController.h"
#import <QJRouter/QJRouter.h>
#import <QJRouter/QJRouter+gm.h>

@interface QJViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation QJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"点我Atom： Imei";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"点我Atom： OpsTime";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"点我Basic： UserInfo";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"点我Component： NiceMgr";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"点我Scene： Express 物流页";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"点我Scene： ItemList 商品列表页";
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"aaa-%ld",indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [QJRouter.sharedInstance pushScheme:@"qj://push_a?title=跳转A&name=我是A"];
    } else if (indexPath.row == 1) {
        [QJRouter.sharedInstance pushScheme:@"qj://push_b?title=跳转A&name=我是A"];
    } else {
        
    }
}

@end

//
//  QJViewController.m
//  QJRouter
//
//  Created by jz on 12/02/2019.
//  Copyright (c) 2019 jz. All rights reserved.
//

#import "QJViewController.h"
#import "Gateway/QJRouter.h"
#import "Gateway/QJRouter+gm.h"

// test
//#import "Atom/OpsTime.h"

@interface QJViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation QJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

-(void)alert:(NSString*)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"返回"
                                            message:msg
                                           delegate:nil
                                           cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"🍔 Atom： Imei(arg)";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"🍔 Atom： ImeiAsync(arg+block)";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"🍔 Atom： OpsTime(noarg)";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"📕 Basic： UserInfo(set)";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"📕 Basic： UserInfo(get)";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"📦 Component： NiceMgr";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"🎦 Scene： Express 物流页";
    } else if (indexPath.row == 7) {
        cell.textLabel.text = @"🎦 Scene： ItemList 商品列表页";
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"aaa-%ld",indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSString *imei = [QJRouter.sharedInstance
                          post:@"qj://atom/Imei/getImei"
                          withParam:[NSNumber numberWithInteger:1]
                          useCb:nil
                          useCache:FALSE
                          ];
        NSLog(@"ret imei = %@",imei);
        [self alert:imei];
    } else if (indexPath.row == 1) {
        [QJRouter.sharedInstance
                  post:@"qj://atom/Imei/getImeiAsync"
                  withParam:[NSNumber numberWithInteger:1]
                  useCb:(__bridge id)(__bridge void*)^(NSString *msg){
                      NSLog(@"cb ret = %@", msg);
                      [self alert:msg];
                  }
                  useCache:FALSE
                ];
    } else if (indexPath.row == 2) {
        NSString *ddtime = [QJRouter.sharedInstance
                          post:@"qj://atom/OpsTime/getTime"
                          withParam:nil
                          useCb:nil
                          useCache:FALSE
                          ];
        NSLog(@"ret ddtime = %@",ddtime);
        [self alert:ddtime];
    } else if (indexPath.row == 3) {
        [QJRouter.sharedInstance
                            post:@"qj://basic/UserInfo/setName"
                            withParam:@"Tom"
                            useCb:nil
                            useCache:TRUE
                            ];
        [self alert:@"save Tom"];
    } else if (indexPath.row == 4) {
        [QJRouter.sharedInstance
         post:@"qj://basic/UserInfo/getName"
         withParam:@"Tom"
         useCb:(__bridge id)(__bridge void*)^(NSString *name){
             NSLog(@"cb ret = %@", name);
             [self alert:name];
         }
         useCache:TRUE
         ];
    } else {
        
    }
}

@end

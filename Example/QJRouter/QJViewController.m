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
//#import "Components/NiceMgr.h"
//#import "Scene/ExpressVC.h"
#import "Scene/PreLoadVC.h"
#import "Scene/RNVC.h"

#import <React/RCTRootView.h>

static int RN_BUNDLEID = 0;

@interface QJViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableDictionary *vcLoadWkHis;
@property (nonatomic, strong) PreLoadVC *vv;

@end

@implementation QJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _vcLoadWkHis = [[NSMutableDictionary alloc] initWithCapacity:30];
    
    _vv = [[PreLoadVC alloc] init];
    [_vv loadViewIfNeeded];
//    [self.view addSubview:[[NiceMgr new] addImage]];
//    [self.navigationController pushViewController:[ExpressVC new] animated:TRUE];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:
                           CGRectMake(0, 0, 375, 44)];
    titleLabel.text =@"IOSGateway";
    self.navigationItem.titleView = titleLabel;
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
    return 16;
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
    } else if (indexPath.row == 8) {
        cell.textLabel.text = @"🎦 Scene： JMESPath 体验";
    } else if (indexPath.row == 9) {
        cell.textLabel.text = @"🎦 Scene： WK自动播放 体验";
    } else if (indexPath.row == 10) {
        cell.textLabel.text = @"🎦 Scene： WK预加载-百度 体验";
    } else if (indexPath.row == 11) {
        cell.textLabel.text = @"🎦 Scene： WK预加载-163 体验";
    } else if (indexPath.row == 12) {
        cell.textLabel.text = @"🎦 Scene： WK预加载-qq 体验";
    } else if (indexPath.row == 13) {
        cell.textLabel.text = @"⚛️ Scene： ReactNative 体验";
    } else if (indexPath.row == 14) {
        cell.textLabel.text = @"🎦 Scene： 数据同步体验";
    } else if (indexPath.row == 15) {
        cell.textLabel.text = @"🎦 Scene： Native视频";
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
    } else if (indexPath.row == 5) {
        UIImageView *img = (UIImageView*)[QJRouter.sharedInstance
         post:@"qj://component/NiceMgr/addImage"
         withParam:nil
         useCb:nil
         useCache:TRUE
         ];
        [self.view addSubview:img];
    }  else if (indexPath.row == 6) {
       id vc = [QJRouter.sharedInstance
                  post:@"qj://scene/ExpressVC/initvc"
                  withParam:nil
                  useCb:nil
                  useCache:TRUE
                  ];
        NSLog(@"vc class %@",NSStringFromClass([vc class]));
        [self.navigationController pushViewController:vc animated:YES];
    }  else if (indexPath.row == 7) {
        id vc = [QJRouter.sharedInstance
                 post:@"qj://scene/ItemListVC/initvc"
                 withParam:nil
                 useCb:nil
                 useCache:TRUE
                 ];
        NSLog(@"vc class %@",NSStringFromClass([vc class]));
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 8) {
        id vc = [QJRouter.sharedInstance
                 post:@"qj://scene/JmeVC/initvc"
                 withParam:nil
                 useCb:nil
                 useCache:TRUE
                 ];
        NSLog(@"vc class %@",NSStringFromClass([vc class]));
        [self.navigationController pushViewController:vc animated:YES];
    }  else if (indexPath.row == 9) {
        id vc = [QJRouter.sharedInstance
                 post:@"qj://scene/WKVideo/initvc"
                 withParam:nil
                 useCb:nil
                 useCache:TRUE
                 ];
        NSLog(@"vc class %@",NSStringFromClass([vc class]));
        NSLog(@"vc inaddr %@",vc);

        [self.navigationController pushViewController:vc animated:YES];
    }  else if (indexPath.row == 10) {
        [self.navigationController pushViewController:_vv animated:YES];
    } else if (indexPath.row == 11) {
        id vc = [QJRouter.sharedInstance
                 post:@"qj://scene/PreLoadDoubanVC/initvc"
                 withParam:nil
                 useCb:nil
                 useCache:TRUE
                 ];
        
        NSString *vcName = NSStringFromClass([vc class]);
//        NSLog(@"vc class %@",NSStringFromClass([vc class]));
//        NSLog(@"vc inaddr %@",vc);
//        if([_vcLoadWkHis objectForKey:vcName]){
//            NSLog(@"resue vc %@",vcName);
//            [self.navigationController pushViewController:vc animated:YES];
//        } else{
//            [vc loadViewIfNeeded];
//            [_vcLoadWkHis setValue:@(1) forKey:vcName];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController pushViewController:vc animated:YES];
//            });
//        }
       
    } else if (indexPath.row == 12) {
        id vc = [QJRouter.sharedInstance
                 post:@"qj://scene/PreLoadQQVC/initvc"
                 withParam:nil
                 useCb:nil
                 useCache:TRUE
                 ];
        
        NSString *vcName = NSStringFromClass([vc class]);
        NSLog(@"vc class %@",NSStringFromClass([vc class]));
        NSLog(@"vc inaddr %@",vc);
        if([_vcLoadWkHis objectForKey:vcName]){
            NSLog(@"resue vc %@",vcName);
            [self.navigationController pushViewController:vc animated:YES];
        } else{
            [vc loadViewIfNeeded];
            [_vcLoadWkHis setValue:@(1) forKey:vcName];
        }
    } else if (indexPath.row == 13) {
        id vc = [QJRouter.sharedInstance
                 post:@"qj://scene/RNVC/initvc"
                 withParam:nil
                 useCb:nil
                 useCache:TRUE
                 ];
        
        RN_BUNDLEID++;
        
        NSURL *url;
        NSString *ssf;
        if(RN_BUNDLEID%2){
            ssf =[[NSBundle mainBundle] pathForResource:@"index.ios.123"ofType:@"jsbundle"];
        } else{
            ssf =[[NSBundle mainBundle] pathForResource:@"index.ios.456"ofType:@"jsbundle"];
        }
        
        NSLog(@"ssf => %@",ssf);

        NSString * jsBundlePath = NSHomeDirectory();
        NSLog(@"sanbox root path = %@",jsBundlePath);

//        url = [NSURL URLWithString:[jsBundlePath stringByAppendingString:@"/rndist/index.ios.bundle.123"]];
        
        url = [NSURL URLWithString:ssf];
        
//        NSLog(@"sanbox root url = %@",url);


//        url = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios&dev=true"];
//        NSURL *url = [NSURL URLWithString:@"http://172.30.139.50:8081/index.bundle?platform=ios&dev=true"];

        RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:url moduleName:@"RNDemo" initialProperties:nil launchOptions:nil];
        
        RNVC *vcx = (RNVC*)vc;
        vcx.view = rootView;
        
        [self.navigationController pushViewController:vcx animated:YES];
       
    } else if (indexPath.row == 14) {
        id vc = [QJRouter.sharedInstance
                 post:@"qj://scene/SyncVC/initvc"
                 withParam:nil
                 useCb:nil
                 useCache:TRUE
                 ];
        
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 15) {
        id vc = [QJRouter.sharedInstance
                 post:@"qj://scene/VideoVc/initvc"
                 withParam:nil
                 useCb:nil
                 useCache:TRUE
                 ];
        
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        
    }
}

@end

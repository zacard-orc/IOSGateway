//
//  RNVC.m
//  QJRouter_Example
//
//  Created by yujie_900 on 2021/2/5.
//  Copyright © 2021 jz. All rights reserved.
//

#import "RNVC.h"
#define  linRGBA(r,g,b,a) [UIColor colorWithRed:r / 255.0  green:g / 255.0 blue:b / 255.0 alpha:a]
//#import <React/RCTRootView.h>

#import <sys/sysctl.h>
#import <mach/mach.h>

@interface RNVC()
@property (nonatomic,strong) UILabel *perfLabel;
@end

@implementation RNVC
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"RN体验";
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;


//    NSURL *url = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios&dev=true"];
//    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:url moduleName:@"RNDemo" initialProperties:nil launchOptions:nil];
//
//    [self.view addSubview:rootView];

    // Do any additional setup after loading the view, typically from a nib.
    
//    NSThread *worker = [[NSThread alloc] initWithTarget:self
//                                                  selector:@selector(opsUpdateMem)
//                                                    object:nil];
//    [worker start];
    
    [self initUI];
}

-(void)opsUpdateMem{
//    task_basic_info_data_t taskInfo;
//    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
//    kern_return_t kernReturn = task_info(mach_task_self(),
//                                     TASK_BASIC_INFO,
//                                     (task_info_t)&taskInfo,
//                                     &infoCount);
//
//    if (kernReturn == KERN_SUCCESS) {
//      taskInfo.resident_size/1024.0/1024.0;
//    }
}

-(void)initUI{
    _perfLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 100, 40)];
    _perfLabel.text=@"aAAaaaaaaa";
    [self.view addSubview:_perfLabel];
    NSLog(@"add initUI");
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
//    [self.navigationController.navigationBar setTranslucent:true];
    
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController
    .navigationBar
    .shadowImage = [[UIImage alloc] init];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:
                        [UIFont systemFontOfSize:16 weight:9],
                         NSForegroundColorAttributeName:linRGBA(254,204,69,1)
    }];
    self.navigationItem.title = @"RN体验";
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:
                        [UIFont systemFontOfSize:16 weight:9],
                         NSForegroundColorAttributeName:linRGBA(254,204,69,1)
    }];
    [self.navigationController.navigationBar setBarTintColor:linRGBA(254,204,69,0.5)];
}
@end

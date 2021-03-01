//
//  VideoVc.m
//  QJRouter_Example
//
//  Created by yujie_900 on 2021/2/26.
//  Copyright © 2021 jz. All rights reserved.
//

#import "VideoVc.h"
#import <AVKit/AVKit.h>
#define  linRGBA(r,g,b,a) [UIColor colorWithRed:r / 255.0  green:g / 255.0 blue:b / 255.0 alpha:a]


@interface VideoVc()
@property (nonatomic,strong) UILabel *perfLabel;
//@property (nonatomic,strong) AVPlayerViewController *playerController;
@end

@implementation VideoVc
- (void)viewDidLoad{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initUI];
    
    for(int i=0;i<100;i++){
        int px = (arc4random() % 380) + 0;
        int py = (arc4random() % 600) + 100;
        UIImageView *heart = [self addImageX:px Y:py];
        [self.view addSubview:heart];
    }
}

-(void)initUI{
    NSString *webVideoPath = @"https://vd4.bdstatic.com/mda-mbqbcvafw3w6cmr2/v1-cae/mda-mbqbcvafw3w6cmr2.mp4?v_from_s=nj_videoui_4135&auth_key=1614234486-0-0-0f3fefa24adb6cf6ce1c1d22f183bef6&bcevod_channel=searchbox_feed&pd=1&pt=3&abtest=3000156_3-8_2";
    NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];
    //步骤2：创建AVPlayer
    AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:webVideoUrl];
    //步骤3：使用AVPlayer创建AVPlayerViewController，并跳转播放界面
    AVPlayerViewController *avPlayerVC =[[AVPlayerViewController alloc] init];
    avPlayerVC.player = avPlayer;
    //步骤4：设置播放器视图大小
    avPlayerVC.view.frame = self.view.frame;
    avPlayerVC.videoGravity = AVLayerVideoGravityResizeAspectFill;

    //特别注意:AVPlayerViewController不能作为局部变量被释放，否则无法播放成功
    //解决1.AVPlayerViewController作为属性
    //解决2:使用addChildViewController，AVPlayerViewController作为子视图控制器
    [self addChildViewController:avPlayerVC];
    [self.view addSubview:avPlayerVC.view];
    
    [avPlayerVC.player play];
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
    self.navigationItem.title = @"RN直播";
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

-(UIImageView *)addImageX:(int)x Y:(int)y {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSLog(@"self class  %@", bundle);

    UIImage *img = [UIImage imageNamed:@"heart"];

    NSLog(@"img = %@", img);
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 50, 50)];
    
    [imgView setImage:img];
    return imgView;
}
@end

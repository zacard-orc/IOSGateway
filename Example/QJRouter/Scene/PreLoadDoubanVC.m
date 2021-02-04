//
//  PreLoadDoubanVC.m
//  QJRouter_Example
//
//  Created by yujie_900 on 2021/2/4.
//  Copyright © 2021 jz. All rights reserved.
//

#import "PreLoadDoubanVC.h"

#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>

static NSString *preLoadurl = @"https://www.163.com/";


@interface PreLoadDoubanVC()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation PreLoadDoubanVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *btn = [[UIButton alloc ] initWithFrame:CGRectMake(10, 90, 100, 40)];
    [btn setTitle:@"goback" forState:UIControlStateNormal];
    [btn setTitle:@"done" forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];

    [btn addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btnRd = [[UIButton alloc ] initWithFrame:CGRectMake(80, 90, 100, 40)];
    [btnRd setTitle:@"reload" forState:UIControlStateNormal];
    [btnRd setTitle:@"done" forState:UIControlStateHighlighted];
    [btnRd setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btnRd setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];

    [btnRd addTarget:self action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRd];
}

-(void)loadView{
    [super loadView];
    [self initWK];
    NSLog(@"vc loadView");
}

-(void)initWK{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(10, 140,370, 600)];
   [self.view addSubview:_webView];

    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:preLoadurl]]];
}

-(void)reload{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:preLoadurl]]];
}

-(void)goback:(UIButton*)btn{
    NSLog(@"click");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"wk load done");
}
@end


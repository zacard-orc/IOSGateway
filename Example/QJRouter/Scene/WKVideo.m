//
//  WKVideo.m
//  QJRouter_Example
//
//  Created by yujie_900 on 2021/1/28.
//  Copyright © 2021 jz. All rights reserved.
//

#import "WKVideo.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>

const NSString *vvurl = @"https://m.baidu.com";

@interface WKVideo()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WKVideo
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
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(10, 140,370, 600)];
   [self.view addSubview:_webView];
      
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:vvurl]]];
    
}

-(void)reload{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:vvurl]]];
}

-(void)goback:(UIButton*)btn{
    NSLog(@"click");
    [self.navigationController popViewControllerAnimated:YES];
}


// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"load start");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"load ttfb");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"load done");
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"load fail");

}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"load trace");

}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{

    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{

     NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}
#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return [[WKWebView alloc]init];
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@",message);
    completionHandler();
}
@end

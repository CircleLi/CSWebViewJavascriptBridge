//
//  CSWebBrowViewController.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/9/2.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSWebBrowViewController.h"
#import <WebKit/WebKit.h>
#import "CSUIWebViewJavascriptBridge.h"
#import "CSWKWebViewJavascriptBridge.h"
#import "CSWebViewJavascriptBridge+Event.h"

@interface CSWebBrowViewController ()

@property (nonatomic,strong) id webView;
@property (nonatomic,strong) __kindof CSWebViewJavascriptBridge *bridge;

@end

@implementation CSWebBrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self addViewControllerlifeCycleEvents];
    [(UIWebView *)self.webView loadRequest:[NSURLRequest requestWithURL:_url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    [self addApplicationNotificationEvents];
   //  [self.bridge dispatchEvent:CSJSWebViewWillAppearEvent data:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  // [self.bridge dispatchEvent:CSJSWebViewDidAppearEvent data:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.bridge dispatchEvent:CSJSWebViewWillDisappearEvent data:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear: animated];
    
    [self.bridge dispatchEvent:CSJSWebViewDisappearEvent data:nil];
    
     [self.bridge removeListenApplicationEvents];
     [self.bridge removeListenViewControllerlifeCycleEvents];
}

- (void)addViewControllerlifeCycleEvents
{
    [self.bridge listenEvent:CSJSWebViewWillAppearEvent eventDispatchBlock:^(id data) {
        [self.bridge callJS:CSJSWebViewWillAppearEvent message:nil JSCompletionBlock:^(id message) {
            
        }];
    }];
    [self.bridge listenEvent:CSJSWebViewDidAppearEvent eventDispatchBlock:^(id data) {
        [self.bridge callJS:CSJSWebViewDidAppearEvent message:nil JSCompletionBlock:^(id message) {
            
        }];
    }];
    [self.bridge listenEvent:CSJSWebViewWillDisappearEvent eventDispatchBlock:^(id data) {
        [self.bridge callJS:CSJSWebViewWillDisappearEvent message:nil JSCompletionBlock:^(id message) {
            
        }];
    }];
    [self.bridge listenEvent:CSJSWebViewDisappearEvent eventDispatchBlock:^(id data) {
        [self.bridge callJS:CSJSWebViewDisappearEvent message:nil JSCompletionBlock:^(id message) {
            
        }];
    }];
}

- (void)addApplicationNotificationEvents
{
    [self.bridge listenApplicationEvent:UIApplicationWillEnterForegroundNotification eventDispatchBlock:^(id data) {
        [self.bridge callJS:UIApplicationWillEnterForegroundNotification message:nil JSCompletionBlock:^(id message) {
            
        }];
    }];
    
    [self.bridge listenApplicationEvent:UIApplicationDidEnterBackgroundNotification eventDispatchBlock:^(id data) {
        [self.bridge callJS:UIApplicationDidEnterBackgroundNotification message:nil JSCompletionBlock:^(id message) {
            
        }];
    }];
    
    [self.bridge listenApplicationEvent:UIApplicationWillResignActiveNotification eventDispatchBlock:^(id data) {
        [self.bridge callJS:UIApplicationWillResignActiveNotification message:nil JSCompletionBlock:^(id message) {
            
        }];
    }];
    
    [self.bridge listenApplicationEvent:UIApplicationDidBecomeActiveNotification eventDispatchBlock:^(id data) {
        [self.bridge callJS:UIApplicationDidBecomeActiveNotification message:nil JSCompletionBlock:^(id message) {
            
        }];
    }];
}

- (void)setUpView
{
    id webView = nil;
    __kindof CSWebViewJavascriptBridge *bridge = nil;
    if(self.webViewType == CSWebBrowControllerTypeUIWebView){
        bridge = [CSUIWebViewJavascriptBridge bridge];
        webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
     
    }else if (self.webViewType == CSWebBrowControllerTypeWKWebView){
        bridge = [CSWKWebViewJavascriptBridge bridge];
        webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:[ (CSWKWebViewJavascriptBridge*)bridge configuration]];
    }
    self.webView = webView;
    [self.view addSubview:webView];
    
    self.bridge = bridge;
    [bridge bridgeForWebView:self.webView];
}

@end

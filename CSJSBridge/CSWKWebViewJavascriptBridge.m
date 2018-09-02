//
//  CSWKWebViewJavascriptBridge.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/8/29.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSWKWebViewJavascriptBridge.h"
#import "CSBridgeConstant.h"

@interface CSWKWebViewJavascriptBridge()<WKScriptMessageHandler>

@end

@implementation CSWKWebViewJavascriptBridge

- (WKWebViewConfiguration *)configuration
{
    if(!_configuration){
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.preferences = [[WKPreferences alloc] init];
        configuration.preferences.minimumFontSize = 30;
        configuration.preferences.javaScriptEnabled = YES;
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        configuration.processPool = [[WKProcessPool alloc] init];
        
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:self name:CSJSNativeObject];
        NSString *javaScriptSource = @"";
        WKUserScript *userScript = [[WKUserScript alloc] initWithSource:javaScriptSource injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
        [userContentController addUserScript:userScript];
        configuration.userContentController = userContentController;
        return configuration;
    }
    return _configuration;
}

- (void)bridgeForWebView:(id)webView
{
    NSParameterAssert([webView isKindOfClass:[WKWebView class]]);
    self.webView = webView;
//    self.webView.navigationDelegate = self;
}


/**
  JS调nativet统一的入口

 @param userContentController <#userContentController description#>
 @param message <#message description#>
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    [super callAppNative:message.body];
}

- (void)callJSWithAction:(NSString *)action script:(NSString *)script JSCompletionBlock:(CSJSCompletionBlock)jsCompletionBlock
{
    NSParameterAssert(script.length > 0);
    if ([[NSThread currentThread] isMainThread]) {
        [self.webView evaluateJavaScript:script completionHandler:^(id _Nullable data, NSError * _Nullable error) {
            jsCompletionBlock(data);
        }];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.webView evaluateJavaScript:script completionHandler:^(id _Nullable data, NSError * _Nullable error) {
                jsCompletionBlock(data);
            }];
        });
    }
}

@end

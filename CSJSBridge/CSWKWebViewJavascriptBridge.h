//
//  CSWKWebViewJavascriptBridge.h
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/8/29.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSWebViewJavascriptBridge.h"
#import <WebKit/WebKit.h>

/**
 CSWKWebViewJavascriptBridge为CSWebViewJavascriptBridge的subClass，为WKWebView提供桥接能力
 */
@interface CSWKWebViewJavascriptBridge : CSWebViewJavascriptBridge<CSWebViewJavascriptBridgeProtocol>

@property(nonatomic,strong) WKWebViewConfiguration *configuration;

@end

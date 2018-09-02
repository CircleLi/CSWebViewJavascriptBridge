//
//  CSUIWebViewJavascriptBridge.h
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/8/29.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "CSWebViewJavascriptBridge.h"

/**
 CSUIWebViewJavascriptBridge为CSWebViewJavascriptBridge的subClass，为UIWebView提供桥接能力
 */
@protocol CSJavaScriptProtocolExport <JSExport>

//UIWebView时候与JS约定的JS调native的最底层方法
- (void)callApp:(id)message;

@end

@interface CSUIWebViewJavascriptBridge : CSWebViewJavascriptBridge<CSWebViewJavascriptBridgeProtocol>

@end

//
//  CSWebViewJavascriptBridge.h
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/8/29.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSJSMessage.h"
#import "CSWebViewJavascriptBridgeProtocol.h"
#import "CSBridgeConstant.h"

@interface CSWebViewJavascriptBridge : NSObject

@property (nonatomic,copy) NSString *jsCallbackFunction;

@property (nonatomic,copy) NSString *nativeCallWebFunction;

@property (nonatomic,strong) id webView;

@property (nonatomic,strong) NSArray<NSString *> *injectJSScriptList;

+ (instancetype)bridge;

- (void)bridgeForWebView:(id)webView;

- (void)callAppNative:(id)message;

- (void)callJS:(NSString *)action
       message:(CSJSMessage *)message
JSCompletionBlock:(CSJSCompletionBlock)jsCompletionBlock;


@end

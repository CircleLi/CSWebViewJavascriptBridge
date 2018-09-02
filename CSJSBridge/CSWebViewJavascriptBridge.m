//
//  CSWebViewJavascriptBridge.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/8/29.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSWebViewJavascriptBridge.h"
#import "CSJSBridgeActionHandlerManager.h"
#import "CSBridgeConstant.h"

@implementation CSWebViewJavascriptBridge

- (instancetype)init
{
    self = [super init];
    if (self) {
        [CSJSBridgeActionHandlerManager shareManager].bridge = self;
        /*
         不写死，通过callApp传递，存储到native端
        self.jsCallbackFunction = CSJSCallbackFunction;
        self.callWebFunction = CSJSNativeCallWebFunction;
         */
    }
    return self;
}

+ (instancetype)bridge
{
    return [[self alloc] init];
}

- (void)bridgeForWebView:(id)webView
{
    //imp by subClass
}

- (void)callAppNative:(id)message
{
    //NSLog(@"callFromJS,data:%@",message);
    if ([message isKindOfClass:[NSDictionary class]])
    {
        CSJSMessage *messageBody = [CSJSMessage messageWithDictionary:message];
        if(![self checkJSMessageParameterValid:messageBody])
        {
            NSLog(@"<<web call app error data formate,no action/handler:%@>>",message);
            return;
        }
        //ios主动调用js，js中对应的对象及方法，如:"jsBridge.nativeCallWeb",动态获取，非写死
        [[CSJSBridgeActionHandlerManager shareManager] callHandler:messageBody.handler message:messageBody JSCallBackBlock:^(CSJSMessage *message) {
            
            self.nativeCallWebFunction = messageBody.nativeCallWebFunction;
           
            //有回调，处理回调:ios回调js，js中对应的对象及方法，如::bridge.callbackWeb,动态获取，非写死
            if (message.callbackID.length) {
                self.jsCallbackFunction = message.callbackFunction;
                NSString* script = [NSString stringWithFormat:@"%@('%@');", self.jsCallbackFunction,[message toJavascriptMessage]];
                NSLog(@"callJSWithScript:%@",script);
                [self callJSWithAction:message.action script:script];
            }
        }];
    }
}

/**
 与js端约定的调用接口：
 可能调用的function类型：
 1.callbackWeb: js主动调oc,oc注册action,callback
 2.callWeb: oc主动调js,js注册action,callBack
 */


/**
  OC主动调js,js完成回调jsCompletionBlock

 @param action <#action description#>
 @param message <#message description#>
 @param jsCompletionBlock <#jsCompletionBlock description#>
 */
- (void)callJS:(NSString *)action
       message:(CSJSMessage *)message
JSCompletionBlock:(CSJSCompletionBlock)jsCompletionBlock
{
    NSString* script = [NSString stringWithFormat:@"%@('%@','%@');", self.nativeCallWebFunction,action,[message toJavascriptMessage]];
    NSLog(@"callJSWithScript:%@",script);
    [self callJSWithAction:action script:script JSCompletionBlock:jsCompletionBlock];
}

/*
 js交互底层方法
 */
- (void)callJSWithAction:(NSString *)action script:(NSString *)script JSCompletionBlock:(CSJSCompletionBlock)jsCompletionBlock;
{
    //imp by subClass
}

- (void)callJSWithAction:(NSString *)action script:(NSString *)script
{
    [self callJSWithAction:action script:script JSCompletionBlock:nil];
}

- (BOOL)checkJSMessageParameterValid:(CSJSMessage *)message
{
    NSString *handler = message.handler;
    NSString *action = message.action;
    BOOL valid = YES;
    if(!handler.length)
    {
        valid = NO;
    }
    if(!action.length)
    {
        valid = NO;
    }
    return valid;
}

@end

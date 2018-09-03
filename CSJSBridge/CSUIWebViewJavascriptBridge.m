//
//  CSUIWebViewJavascriptBridge.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/8/29.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSUIWebViewJavascriptBridge.h"
#import <objc/runtime.h>
#import "CSJSHandlerActionProtocol.h"

@interface CSUIWebViewJavascriptBridge()<UIWebViewDelegate>

@property (nonatomic,strong) JSContext *jsContext;

@end

@implementation CSUIWebViewJavascriptBridge

- (instancetype)init
{
    self = [super init];
    if (self) {
        class_addProtocol([self class], @protocol(CSJavaScriptProtocolExport));
    }
    return self;
}

- (void)bridgeForWebView:(id)webView
{
    NSParameterAssert([webView isKindOfClass:[UIWebView class]]);
    UIWebView *web = (UIWebView *)webView;
    self.webView = web;
    web.delegate = self;
}

/**
 UIWebView传说最佳注入JSContext时机

 @param webView <#webView description#>
 @param ctx <#ctx description#>
 */
- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext *)ctx
{
    [self injectJSContext];
    [self preInjectJS];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
  
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}

/*
 预先注入与native端核心逻辑相匹配的JS端逻辑
 */
- (void)preInjectJS
{
    [self.injectJSScriptList enumerateObjectsUsingBlock:^(NSString * _Nonnull scriptName, NSUInteger idx, BOOL * _Nonnull stop) {
          NSString *path = [[NSBundle mainBundle] pathForResource:scriptName ofType:@"js"];
          NSString *script = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path] encoding:NSUTF8StringEncoding error:nil];
        if (script.length) {
            [self callJS:script];
        }
    }];
}

- (void)injectJSContext
{
    JSContext *jsContext = [self.webView valueForKeyPath:CSJSContext];
    jsContext [CSJSNativeObject] = self;
    self.jsContext = jsContext;
}

/**
 js主动调OC

 @param message <#message description#>
 */
- (void)callApp:(id)message
{
    [super callAppNative:message];
}

- (void)callJS:(NSString *)script
{
    [self callJSWithAction:nil script:script JSCompletionBlock:nil];
}

/*
 js交互底层方法
 */

- (void)callJSWithAction:(NSString *)action script:(NSString *)script JSCompletionBlock:(CSJSCompletionBlock)jsCompletionBlock
{
    NSParameterAssert(script.length > 0);
    
//    JSValue *value = [self.jsContext evaluateScript:script];
//    id result = [value toDictionary];
//    if(result){
//        jsCompletionBlock ? jsCompletionBlock(result) : nil;
//    }else{
//        if(jsCompletionBlock){
//            NSLog(@"error,js no response,may not register Action:%@,please first register the action",action);
//        }
//    }
//    return;
    /*
     线程会对web的线程有影响，web调试器堆栈无，而且无法调适，还有可能xcode crash，如下错误：
     0x1146dc333 <+131>: leaq   0x4122ae(%rip), %rdi      ; @"%s, %p: Tried to obtain the web lock from a thread other than the main thread or the web thread. This may be a result of calling to UIKit from a secondary thread. Crashing now..."
     */
    if ([[NSThread currentThread] isMainThread]) {
        JSValue *value = [self.jsContext evaluateScript:script];
        id result = [value toDictionary];
        if(result){
            jsCompletionBlock ? jsCompletionBlock(result) : nil;
        }else{
            if(jsCompletionBlock){
                NSLog(@"error,js no response,may not register Action,please first register the action");
            }
        }
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            JSValue *value = [self.jsContext evaluateScript:script];
            id result = [value toDictionary];
            if(result){
                 jsCompletionBlock ? jsCompletionBlock(result) : nil;
            }else{
                if(jsCompletionBlock){
                    NSLog(@"error,js no response,may not register Action,please first register the action");
                }
            }
        });
    }
}

@end

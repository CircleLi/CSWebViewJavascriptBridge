//
//  CSJSBridgeActionManager.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/8/29.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSJSBridgeActionHandlerManager.h"
#import "CSJSHandler.h"
#import "CSJSLog.h"

@interface CSJSBridgeActionHandlerManager()

/**
 JS主动调OC，native端支持的handler,从CSJSSupportHandlers.plist获取所有handler的配置
 */
@property (nonatomic,strong) NSMutableDictionary <NSString *,id<CSJSHandlerProtocol>>*supportJSHandlersMap;

@end

@implementation CSJSBridgeActionHandlerManager

- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

+ (instancetype)shareManager
{
    static CSJSBridgeActionHandlerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}


/**
 从CSJSSupportHandlers.plist加载所有JS调native所有handler的，并且通过handlerName,handler映射到内存中，通过动态调用handle模块

 @return <#return value description#>
 */
- (NSMutableDictionary <NSString *,id<CSJSHandlerProtocol>>*)supportJSHandlersMap
{
    if (!_supportJSHandlersMap) {
        _supportJSHandlersMap = [NSMutableDictionary dictionaryWithCapacity:1];
        NSString *mapPath = [[NSBundle mainBundle] pathForResource:@"CSJSSupportHandlers" ofType:@"plist"];
        NSParameterAssert(mapPath);
        NSDictionary *map = [NSDictionary dictionaryWithContentsOfFile:mapPath];
        [map enumerateKeysAndObjectsUsingBlock:^(NSString* _Nonnull handlerName, NSString * _Nonnull handlerClassString, BOOL * _Nonnull stop) {
            Class handlerClass = NSClassFromString(handlerClassString);
            id handler = [[handlerClass alloc] init];
            if(!handler)
            {
                CSLog(@"handlerClass not exist:%@",handlerClassString);
            }
            else{
                if ([handler conformsToProtocol:@protocol(CSJSHandlerProtocol)]) {
                    //registerHandler:
                    [_supportJSHandlersMap setObject:handler forKey:handlerName];
                    CSJSHandler *jsHandler = (CSJSHandler *)handler;
                    jsHandler.handlerName = handlerName;
                }else{
                    CSLog(@"handler:%@ not conform to protocol:%@",handler, NSStringFromProtocol(@protocol(CSJSHandlerProtocol)));
                }
            }
        }];
        CSLog(@"supportJsHandlerMap:%@",_supportJSHandlersMap);
    }
    return _supportJSHandlersMap;
}

/*
 去掉load中handler自注册的方式，改用依靠plist做主动注册的方式
- (void)registerHandler:(NSString *)handlerName handler:(id<CSJSHandlerProtocol>)handler
{
    [self.supportJSHandlersMap setObject:handler forKey:handlerName];
}
 */

- (void)callHandler:(NSString *)handlerName
            message:(CSJSMessage *)message
    JSCallBackBlock:(CSJSCallBackBlock)jsCallBackBlock
{
    id <CSJSHandlerProtocol>handler = self.supportJSHandlersMap[handlerName];
    if (!handler) {
        CSLog(@"error,handler:%@ not register",handlerName);
    }
    else
    {
        if([handler respondsToSelector:@selector(callAppAction:message:jsCallBackBlock:)])
        {
            [handler callAppAction:message.action message:message jsCallBackBlock:jsCallBackBlock];
        }
        else
        {
            NSLog(@"error,handler not respondsToSelector 'callAppActionWithMessage: '");
        }
    }
}

- (void)callJS:(NSString *)action
       message:(CSJSMessage *)message
JSCompletionBlock:(CSJSCompletionBlock)jsCompletionBlock
{
    [self.bridge callJS:action message:message JSCompletionBlock:jsCompletionBlock];
}

+ (id<CSJSHandlerProtocol>)handlerWithName:(NSString *)name
{
    NSParameterAssert(name.length > 0);
    NSMutableDictionary *supportJSHandlersMap = [[self shareManager] supportJSHandlersMap];
    id <CSJSHandlerProtocol> handler = supportJSHandlersMap[name];
    NSParameterAssert(handler != nil);
    if (handler) {
        return handler;
    }
    return nil;
}

@end

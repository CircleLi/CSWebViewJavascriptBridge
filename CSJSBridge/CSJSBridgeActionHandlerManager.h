//
//  CSJSBridgeActionManager.h
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/8/29.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSJSHandlerActionProtocol.h"
#import "CSWebViewJavascriptBridge.h"

@interface CSJSBridgeActionHandlerManager : NSObject

@property (nonatomic,strong) __kindof CSWebViewJavascriptBridge *bridge;

+ (instancetype)shareManager;

+ (id<CSJSHandlerProtocol>)handlerWithName:(NSString *)name;

- (void)callHandler:(NSString *)handlerName message:(CSJSMessage *)message JSCallBackBlock:(CSJSCallBackBlock)jsCallBackBlock;

- (void)callJS:(NSString *)action
       message:(CSJSMessage *)message
JSCompletionBlock:(CSJSCompletionBlock)jsCompletionBlock;

@end

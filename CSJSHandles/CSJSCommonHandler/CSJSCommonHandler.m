//
//  CSJSCommonModule.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/8/29.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSJSCommonHandler.h"
#import "CSJSBridgeActionHandlerManager.h"
#import "CSJSMessage.h"

@implementation CSJSCommonHandler

- (NSMutableDictionary <NSString *,id<CSJSActionProtocol>>*)supportJSActionsMap
{
    return [super supportJSActionsMap];
}

@end

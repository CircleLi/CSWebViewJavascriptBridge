//
//  CSJSShareAction.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/8/31.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSJSShareAction.h"
#import "CSJSHandlerActionProtocol.h"

@implementation CSJSShareAction

- (void)callAppActionWithMessage:(CSJSMessage *)message jsCallBackBlock:(CSJSCallBackBlock)jsCallBackBlock
{
    CSJSMessage *responceMessage  = message;
    //doSth

    jsCallBackBlock ? jsCallBackBlock(responceMessage) : nil;
}

@end

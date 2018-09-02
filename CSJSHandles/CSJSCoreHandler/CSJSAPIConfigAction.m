//
//  CSJSAPIConfigAction.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/9/2.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSJSAPIConfigAction.h"
#import "CSBridgeConstant.h"

//JSAPI控制版本
NSString *const CSCurrentJSAPIVersion = @"12";

@implementation CSJSAPIConfigAction

- (void)callAppActionWithMessage:(CSJSMessage *)message jsCallBackBlock:(CSJSCallBackBlock)jsCallBackBlock
{
    CSJSMessage *responceMessage  = message;
    responceMessage.JSAPIVersion = CSCurrentJSAPIVersion;
    NSLog(@"**JSLog:%@**",responceMessage.data);
    jsCallBackBlock ? jsCallBackBlock(responceMessage) : nil;
}

@end

//
//  CSGetDeviceInfoAction.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/9/2.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSGetDeviceInfoAction.h"

@implementation CSGetDeviceInfoAction

- (void)callAppActionWithMessage:(CSJSMessage *)message jsCallBackBlock:(CSJSCallBackBlock)jsCallBackBlock
{
    CSJSMessage *responceMessage  = message;
    //doSth
    
    jsCallBackBlock ? jsCallBackBlock(responceMessage) : nil;
}

@end

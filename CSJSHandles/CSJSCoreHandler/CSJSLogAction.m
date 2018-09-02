//
//  CSJSLogAction.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/9/2.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSJSLogAction.h"

@implementation CSJSLogAction

- (void)callAppActionWithMessage:(CSJSMessage *)message jsCallBackBlock:(CSJSCallBackBlock)jsCallBackBlock
{
    CSJSMessage *responceMessage  = message;
    //doSth
    NSLog(@"**JSLog:%@**",responceMessage.data);
    jsCallBackBlock ? jsCallBackBlock(responceMessage) : nil;
}

@end

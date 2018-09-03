//
//  CSJSAction.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/9/2.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSJSAction.h"
#import "CSJSLog.h"

@implementation CSJSAction

- (void)callAppActionWithMessage:(CSJSMessage *)message jsCallBackBlock:(CSJSCallBackBlock)jsCallBackBlock
{
    CSLog(@"completion action:%@",NSStringFromClass([self class]));
    jsCallBackBlock ? jsCallBackBlock(message) : nil;
}


@end

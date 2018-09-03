//
//  CSJSLogAction.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/9/2.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSJSLogAction.h"
#import "CSJSLog.h"

@implementation CSJSLogAction

- (void)callAppActionWithMessage:(CSJSMessage *)message jsCallBackBlock:(CSJSCallBackBlock)jsCallBackBlock
{
    CSJSMessage *responceMessage  = message;
    NSDictionary *dic = [responceMessage toDictionary];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    CSLog([[@"<<\n fromJslog: " stringByAppendingString:jsonString] stringByAppendingString:@"\n>>"]);
    jsCallBackBlock ? jsCallBackBlock(responceMessage) : nil;
}

@end

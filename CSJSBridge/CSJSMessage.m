//
//  CSJSMessage.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/8/29.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSJSMessage.h"

@implementation CSJSMessage

+ (instancetype)messageWithDictionary:(NSDictionary *)dic
{
    return [[self alloc] initWithDictionary:dic];
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    _handler ? [dic setObject:_handler forKey:@"handler"] : nil;
    _action ? [dic setObject:_action forKey:@"action"] : nil;
    _callbackFunction ? [dic setObject:_callbackFunction forKey:@"callbackFunction"] : nil;
    _nativeCallWebFunction ? [dic setObject:_nativeCallWebFunction forKey:@"nativeCallWebFunction"] : nil;
    _callbackID ? [dic setObject:_callbackID forKey:@"callbackID"] : nil;
    _data ? [dic setObject:_data forKey:@"data"] : nil;
    _JSAPIVersion ? [dic setObject:_JSAPIVersion forKey:@"JSAPIVersion"] : nil;
    return dic;
}

// JSON Javascript编码处理
- (NSString *)toJavascriptMessage
{
    NSString *message = [self toJsonString];
    [message stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    message = [message stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    message = [message stringByReplacingOccurrencesOfString:@"\'" withString:@"\\\'"];
    message = [message stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    message = [message stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
    message = [message stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
    message = [message stringByReplacingOccurrencesOfString:@"\u2028" withString:@"\\u2028"];
    message = [message stringByReplacingOccurrencesOfString:@"\u2029" withString:@"\\u2029"];
    
    return message;
}

- (NSString *)toJsonString
{
    NSDictionary *dic = [self toDictionary];
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
}

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _handler = dic[@"handler"];
        _action = dic[@"action"];
        _callbackFunction = dic[@"callbackFunction"];
        _nativeCallWebFunction = dic[@"nativeCallWebFunction"];
        _callbackID = dic[@"callbackID"];
        _data = dic[@"data"];
        _JSAPIVersion = dic[@"JSAPIVersion"];
    }
    return self;
}

@end

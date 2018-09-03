//
//  CSJSBridgeManager.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/9/3.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSJSBridgeManager.h"

@interface CSJSBridgeManager()

@property (nonatomic,strong) id<CSJSLoggerProtocol>logger;

@end

@implementation CSJSBridgeManager

+ (instancetype)shareManager
{
    static CSJSBridgeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

+ (void)registerLogger:(id<CSJSLoggerProtocol>)logger
{
    NSParameterAssert(logger);
    [CSJSBridgeManager shareManager].logger = logger;
}

+ (id<CSJSLoggerProtocol>)customLogger
{
    return [[self shareManager] logger];
}

@end

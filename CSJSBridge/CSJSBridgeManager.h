//
//  CSJSBridgeManager.h
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/9/3.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSJSLoggerProtocol.h"

@interface CSJSBridgeManager : NSObject

+ (instancetype)shareManager;

+ (void)registerLogger:(id<CSJSLoggerProtocol>)logger;

+ (id<CSJSLoggerProtocol>)customLogger;

@end

//
//  CSJSLoggerProtocol.h
//  CSWebViewJavascriptBridge
//
//  Created by 余强 on 2018/9/3.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#ifndef CSJSLoggerProtocol_h
#define CSJSLoggerProtocol_h

@protocol CSJSLoggerProtocol <NSObject>

- (void) JSCustomLog:(nullable NSString *) log;

@end


#endif /* CSJSLoggerProtocol_h */

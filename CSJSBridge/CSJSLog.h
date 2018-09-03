//
//  CSJSLog.h
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/9/3.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CSLog(args...) JSLog(@"CSJSLog", __FILE__,__LINE__,__PRETTY_FUNCTION__,args);

@interface CSJSLog : NSObject

 void JSLog(NSString *prefix, const char *file, int lineNumber, const char *funcName, NSString *format,...);

@end

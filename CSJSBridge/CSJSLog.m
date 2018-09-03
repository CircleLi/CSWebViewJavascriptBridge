//
//  CSJSLog.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/9/3.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSJSLog.h"
#import "CSJSBridgeManager.h"

@implementation CSJSLog

 void JSLog(NSString *prefix, const char *file, int lineNumber, const char *funcName, NSString *format,...) {
    
    if ([CSJSBridgeManager customLogger] == nil){
        return;
    }
    
    va_list ap;
    va_start (ap, format);
    format = [format stringByAppendingString:@"\n"];
    NSString *msg = [[NSString alloc] initWithFormat:[NSString stringWithFormat:@"%@",format] arguments:ap];
    va_end (ap);
    if (!msg.length){
       return;
    }
    NSLog(@"%@",msg);
    [[CSJSBridgeManager customLogger] JSCustomLog:msg];
    // write to file
    //fprintf(stderr,"%s%50s:%3d - %s",[prefix UTF8String], funcName, lineNumber, [msg UTF8String]);
}


@end

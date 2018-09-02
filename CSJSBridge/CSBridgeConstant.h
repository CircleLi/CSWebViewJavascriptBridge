//
//  CSBridgeConstant.h
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/8/30.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const CSJSContext;
extern NSString *const CSJSContext;
extern NSString *const CSJSNativeObject;
extern NSString *const CSJSApiVersion;

/*
 用来存储native主动调js所需要保存的function的handler
 */
extern NSString *const CSJSNativeCallWebFunctionHandler;

extern NSString *const CSJSCallbackFunction;

extern NSString *const CSJSNativeCallWebFunction;

extern NSString *const CSJSAPIVersion;

//EVENT
//native Event
extern NSString *const CSJSWebViewWillAppearEvent;

extern NSString *const CSJSWebViewDidAppearEvent;

extern NSString *const CSJSWebViewWillDisappearEvent;

extern NSString *const CSJSWebViewDisappearEvent;

//application event

@interface CSBridgeConstant : NSObject

@end

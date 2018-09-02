//
//  CSJSMessage.h
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/8/29.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSJSMessage: NSObject


/**
  JS主动调native逻辑，分模块定义业务，common,xx,yy等，一个handler代表一个模块
 */
@property (nonatomic, copy, readonly) NSString *handler;

/**
 模块handler中的action事件，多个action构成一个handler
 */
@property (nonatomic, copy, readonly) NSString *action;

/**
 传递的数据
 */
@property (nonatomic, strong) NSDictionary *data;
/**
  回调id标记
 */
@property (nonatomic, copy, readonly) NSString *callbackID;
/**
 JS主动调native，native执行完相关业务后回调JS的函数，该function可写死，也可动态，如"jsBridge.callbackWeb"
 */
@property (nonatomic, copy, readonly) NSString *callbackFunction;
/**
 native主动调用JS的函数，该function可写死，也可动态，"jsBridge.nativeCallWeb"
 */
@property (nonatomic, copy, readonly) NSString *nativeCallWebFunction;

/**
 JSAPI版本号，用来区别不同版本之间JSAPI的不同
 */
@property (nonatomic, copy) NSString *JSAPIVersion;

+ (instancetype)messageWithDictionary:(NSDictionary *)dic;

- (NSString *)toJavascriptMessage;

- (NSDictionary *)toDictionary;

@end

//
//  CSWebViewJavascriptBridge+Event.h
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/9/2.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSWebViewJavascriptBridge.h"

/**
 该catigory用于JS监听native的事件，也即native将某些事件直接分发到JS
 */
@interface CSWebViewJavascriptBridge (Event)

/**
 用来存储JS监听native的事件与业务处理的映射
 */
@property (nonatomic,strong) NSMutableDictionary<NSString *,CSJSEventDispatchBlock> *eventMap;

/**
 JS监听native的事件，

 @param event native事件，可以为controller事件，如VC生命周期事件，viewDidAppear,viewDisappear,也可以为native端业务实践，账号升级了，退出登录了。。
 @param eventDispatchBlock 监听native事件，要做的事情，预先存在eventMap中
 */
- (void)listenEvent:(NSString *)event eventDispatchBlock:(CSJSEventDispatchBlock)eventDispatchBlock;

/**
 JS监听native的application事件,

 @param event application事件，如willEnterForground,didEnterBackground,becomeActive等
 @param eventDispatchBlock 事件触发后的要处理的业务block
 */
- (void)listenApplicationEvent:(NSString *)event eventDispatchBlock:(CSJSEventDispatchBlock)eventDispatchBlock;

/**
 分发监听的事件

 @param event 事件event
 @param data <#data description#>
 */
- (void)dispatchEvent:(NSString *)event data:(id)data;

/**
移除application事件的相关监听
 */
- (void)removeListenApplicationEvents;

/**
 移除VC lifeCycle的相关监听
 */
- (void)removeListenViewControllerlifeCycleEvents;

@end

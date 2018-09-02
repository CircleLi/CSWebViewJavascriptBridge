//
//  CSWebViewJavascriptBridge+Event.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/9/2.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSWebViewJavascriptBridge+Event.h"
#import <objc/runtime.h>

@implementation CSWebViewJavascriptBridge (Event)

@dynamic eventMap;

static char associateMapKey;

- (NSMutableDictionary<NSString *,CSJSEventDispatchBlock> *) eventMap{

    return objc_getAssociatedObject(self, &associateMapKey);
}

- (void) setEventMap:(NSMutableDictionary<NSString *,CSJSEventDispatchBlock> *)eventMap{
    objc_setAssociatedObject(self, &associateMapKey, eventMap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)webViewController
{
    id view = self.webView;
    while (view) {
        view = ((UIResponder *)view).nextResponder;
        if ([view isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return view;
}

- (void)listenEvent:(NSString *)event eventDispatchBlock:(CSJSEventDispatchBlock)eventDispatchBlock
{
    NSParameterAssert(event.length > 0);
    if(!self.eventMap){
        self.eventMap = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    [self.eventMap setObject:eventDispatchBlock forKey:event];
}

- (void)removeListenApplicationEvents
{
    NSArray<NSString *> *applicationEvents = @[
                                   UIApplicationWillEnterForegroundNotification,
                                   UIApplicationWillResignActiveNotification,
                                   UIApplicationDidBecomeActiveNotification,
                                   UIApplicationDidEnterBackgroundNotification
                                   ];
    [applicationEvents enumerateObjectsUsingBlock:^(NSString * _Nonnull event, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeListenApplicationEvent:event];
    }];
}

- (void)removeListenViewControllerlifeCycleEvents
{
    NSArray<NSString *> *viewControllerlifeCycleEvents = @[
                                               CSJSWebViewWillAppearEvent,
                                               CSJSWebViewDidAppearEvent,
                                               CSJSWebViewWillDisappearEvent,
                                               CSJSWebViewDisappearEvent
                                               ];
    [viewControllerlifeCycleEvents enumerateObjectsUsingBlock:^(NSString * _Nonnull event, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeListenEvent:event];
    }];
}


- (void)listenApplicationEvent:(NSString *)event eventDispatchBlock:(CSJSEventDispatchBlock)eventDispatchBlock
{
    NSParameterAssert(event.length > 0);
    if(!self.eventMap){
        self.eventMap = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    [self.eventMap setObject:eventDispatchBlock forKey:event];
    [[NSNotificationCenter defaultCenter] addObserverForName:event object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSString *event = note.name;
        [self dispatchEvent:event data:note.object];
    }];
}

- (void)dispatchEvent:(NSString *)event data:(id)data
{
    CSJSEventDispatchBlock eventBlock = [self.eventMap objectForKey:event];
    eventBlock ? eventBlock(data) : nil;
}

- (void)removeListenApplicationEvent:(NSString *)event
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:event object:nil];
    [self removeListenEvent:event];
}

- (void)removeListenEvent:(NSString *)event
{
    [self.eventMap removeObjectForKey:event];
}

@end

//
//  CSJSHandler.m
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/8/31.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import "CSJSHandler.h"
#import "CSJSAction.h"

@interface CSJSHandler()

@end

@implementation CSJSHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**
 从CSJSXXSupportAction.plist加载JS调native某个handler下的所有action的，并且通过actionName,action映射到内存中，通过动态调用action业务
 
 @return <#return value description#>
 */
- (NSMutableDictionary <NSString *,id<CSJSActionProtocol>>*)supportJSActionsMap
{
    if (!_supportJSActionsMap) {
        _supportJSActionsMap = [NSMutableDictionary dictionaryWithCapacity:1];
        
        NSString *handlerName = [self.handlerName capitalizedStringWithLocale:[NSLocale currentLocale]];
        NSString *plistName = [[@"CSJS" stringByAppendingString:[NSString stringWithFormat:@"%@",handlerName]] stringByAppendingString:@"SupportActions"];
        NSString *mapPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSParameterAssert(mapPath);
        NSDictionary *map = [NSDictionary dictionaryWithContentsOfFile:mapPath];
        [map enumerateKeysAndObjectsUsingBlock:^(NSString* _Nonnull actionName, NSString * _Nonnull actionClassString, BOOL * _Nonnull stop) {
            Class actionClass = NSClassFromString(actionClassString);
            id action = [[actionClass alloc] init];
            if(!action)
            {
                NSLog(@"<< actionClass not exist:%@ >>",actionClassString);
            }
            else{
                if ([action conformsToProtocol:@protocol(CSJSActionProtocol)]) {
                    //registerAction:
                    [_supportJSActionsMap setObject:action forKey:actionName];
                    CSJSAction *jsAction = (CSJSAction *)action;
                    jsAction.actionName = actionName;
                }else{
                    NSLog(@"<< action:%@ not conform to protocol:%@ >>",action, NSStringFromProtocol(@protocol(CSJSHandlerProtocol)));
                }
            }
        }];
        NSLog(@"<< supportJsActiomMap:%@ >>",_supportJSActionsMap);
    }
    return _supportJSActionsMap;
}


/**
 JS主动调native，

 @param actionName action,如share,getUserInfo,getDeviceInfo
 @param message JS传递到native的数据
 @param jsCallBackBlock native回调到JS的Block
 */
- (void)callAppAction:(NSString *)actionName message:(CSJSMessage *)message jsCallBackBlock:(CSJSCallBackBlock)jsCallBackBlock
{
    id <CSJSActionProtocol>action = self.supportJSActionsMap[actionName];
    if (!action) {
        NSLog(@"<< error,action:%@ not register >>",actionName);
    }
    else
    {
        if([action respondsToSelector:@selector(callAppActionWithMessage:jsCallBackBlock:)])
        {
            [action callAppActionWithMessage:message jsCallBackBlock:jsCallBackBlock];
        }
        else
        {
            NSLog(@"<< error,action not respondsToSelector 'callAppActionWithMessage:jsCallBackBlock:'>>");
        }
    }
}

- (id<CSJSActionProtocol>)actionWithName:(NSString *)name
{
    NSParameterAssert(name == nil);
    NSMutableDictionary *supportJSActionsMap = self.supportJSActionsMap;
    id <CSJSActionProtocol> action = supportJSActionsMap[name];
    NSParameterAssert(action == nil);
    if (action) {
        return action;
    }
    return nil;
}


@end

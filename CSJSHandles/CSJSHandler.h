//
//  CSJSHandler.h
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/8/31.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSJSHandlerActionProtocol.h"

@interface CSJSHandler : NSObject<CSJSHandlerProtocol>

//注册到CSJSBridgeActionHandlerManager的名字：{common:CSJSCommonHandler}
@property (nonatomic,copy) NSString *handlerName;

@property (nonatomic,strong) NSMutableDictionary <NSString *,id<CSJSActionProtocol>>*supportJSActionsMap;

@end

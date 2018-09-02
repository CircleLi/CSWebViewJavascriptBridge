//
//  CSWebViewJavascriptBridgeProtocol.h
//  CSWebViewJavascriptBridge
//
//  Created by 余强 on 2018/8/29.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#ifndef CSWebViewJavascriptBridgeProtocol_h
#define CSWebViewJavascriptBridgeProtocol_h

#import "CSJSHandlerActionProtocol.h"

typedef void(^CSJSEventDispatchBlock)(id data);

@class CSJSMessage;
@protocol CSWebViewJavascriptBridgeProtocol <NSObject>

- (void)callJSWithAction:(NSString *)action
                  script:(NSString *)script
       JSCompletionBlock:(CSJSCompletionBlock)jsCompletionBlock;

@end

#endif /* CSWebViewJavascriptBridgeProtocol_h */

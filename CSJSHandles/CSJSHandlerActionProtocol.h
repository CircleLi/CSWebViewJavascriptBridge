//
// CSJSHandlerActionProtocol.h
//  CSWebViewJavascriptBridge
//
//  Created by 余强 on 2018/8/29.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#ifndef CSJSHandlerActionProtocol_h
#define CSJSHandlerActionProtocol_h

@class CSJSMessage;
@protocol CSJSActionProtocol;
//js主动调oc,oc处理完逻辑后回调js的block
typedef void(^CSJSCallBackBlock)(CSJSMessage *message);
//oc主动调js，js处理完逻辑后回调给oc的block
typedef void(^CSJSCompletionBlock)(id message);

@protocol CSJSHandlerProtocol <NSObject>

- (void)callAppAction:(NSString *)actionName message:(CSJSMessage *)message jsCallBackBlock:(CSJSCallBackBlock)jsCallBackBlock;

@end

@protocol CSJSActionProtocol <NSObject>

- (void)callAppActionWithMessage:(CSJSMessage *)message jsCallBackBlock:(CSJSCallBackBlock)jsCallBackBlock;

@end


#endif /* CSJSHandlerActionProtocol_h */

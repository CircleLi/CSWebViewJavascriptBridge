//
//  CSJSAction.h
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/9/2.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSJSHandlerActionProtocol.h"
#import "CSJSMessage.h"

@interface CSJSAction : NSObject<CSJSActionProtocol>

//注册到CSJSHandler的名字：{share:CSJShareAction}
@property (nonatomic,copy) NSString *actionName;

@end

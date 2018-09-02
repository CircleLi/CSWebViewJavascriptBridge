//
//  CSWebViewController.h
//  CSWebViewJavascriptBridge_Example
//
//  Created by 余强 on 2018/9/2.
//  Copyright © 2018年 289067005@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CSWebBrowControllerType)
{
    CSWebBrowControllerTypeUIWebView,
    CSWebBrowControllerTypeWKWebView
};


@interface CSWebBrowViewController : UIViewController

@property (nonatomic,assign) CSWebBrowControllerType webViewType;
@property (nonatomic,strong) NSURL *url;
@end

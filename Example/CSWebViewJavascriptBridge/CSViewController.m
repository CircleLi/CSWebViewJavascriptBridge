//
//  CSViewController.m
//  CSWebViewJavascriptBridge
//
//  Created by 289067005@qq.com on 08/29/2018.
//  Copyright (c) 2018 289067005@qq.com. All rights reserved.
//

#import "CSViewController.h"
#import "CSWebBrowViewController.h"

@interface CSViewController ()

@end

@implementation CSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)webBrowAction:(id)sender {
    
    CSWebBrowViewController *browVc = [[CSWebBrowViewController alloc] init];
    browVc.webViewType = CSWebBrowControllerTypeUIWebView;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"demo.html" ofType:nil];
    browVc.url = [NSURL fileURLWithPath:path];
    [self.navigationController pushViewController:browVc animated:YES];
}

//- (IBAction)shareAction:(id)sender
//{
//    CSJSMessage *msg = [CSJSMessage messageWithDictionary:@{@"action":@"viewDidAppear"}];
//    [self.bridge callJS:CSJSWebViewDidAppearEvent message:msg JSCompletionBlock:^(id message) {
//        
//    }];
//}

@end

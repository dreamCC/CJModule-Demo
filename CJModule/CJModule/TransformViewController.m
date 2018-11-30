//
//  TransformViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/7/5.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "TransformViewController.h"
#import <Masonry.h>
#import <WebKit/WebKit.h>
#import "WKWebView+CJCategory.h"
#import <AFNetworking.h>
#import <QMUIKit.h>


@interface TransformViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,WKScriptMessageHandler> {
    NSURLRequest *_req;
}

@property(nonatomic,weak) WKWebView *webV;
@end

@implementation TransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithBoldTitle:@"Done" target:self action:@selector(rightBarButtonItemClick)];
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.f];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // config 有几个常用属性。preferrences 偏好设置.WKPreferrences
    WKPreferences *preferences = config.preferences;
    preferences.minimumFontSize = 12.f; // 最小字体
    preferences.javaScriptEnabled = YES; // 是否能够js
    preferences.javaScriptCanOpenWindowsAutomatically = NO;  // 是否允许js自动打开window。
    NSLog(@"WKPreferences:%@",preferences);
    
    // processPool 进程池 该属性WKProcessPool，目前没有暴露属性。不需要设置,也不需要初始化。
    NSLog(@"WKProcessPool:%@",config.processPool);
    
    
    // userContentController 用于js交互的。
    WKUserContentController *userContentContoller = config.userContentController;
    //  添加MessageHandler。js中，调用方法。注意需要移除。
    //  window.webkit.messageHandlers.showMobile.postMessage(null)
    //  window.webkit.messageHandlers.showName.postMessage('有一个参数')
    //  window.webkit.messageHandlers.showSendMsg.postMessage(['两个参数One', '两个参数Two'])
    [userContentContoller addScriptMessageHandler:self name:@"showMobile"];
    [userContentContoller addScriptMessageHandler:self name:@"showName"];
    [userContentContoller addScriptMessageHandler:self name:@"showSendMsg"];
    
    // 添加js 代码。这种方法调用js，实在webView加载h5的时候调用的。跟evaluateJavaScript相比，只是调用的时机问题。
    WKUserScript *script = [[WKUserScript alloc] initWithSource:@"alertMobile()"
                                                  injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
                                               forMainFrameOnly:YES];
    [userContentContoller addUserScript:script];
    NSLog(@"每个js 方法-%@",script);
    

    
    WKWebView *webV = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    CJGradientProgressView *progresV = [[CJGradientProgressView alloc] init];
   
   

    webV.gradientProgressView = progresV;
    
    webV.gradientProgressView = [CJGradientProgressView new];
    webV.allowsBackForwardNavigationGestures = YES;
    
    webV.UIDelegate = self;
    webV.navigationDelegate = self;
//    [webV loadRequest:req];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JsToNative.html" ofType:nil];
//    NSURL *baseUrl = [[NSBundle mainBundle] bundleURL];
    
//    [webV loadHTMLString:path baseURL:baseUrl];
    [webV loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    [self.view addSubview:webV];
    self.webV = webV;
    

    
    [webV mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.equalTo(self.view).offset(64);
        }
        make.left.right.bottom.equalTo(self.view);
    }];
    
    

}

-(void)removeMessageHandle {
    [self.webV.configuration.userContentController removeScriptMessageHandlerForName:@"showMobile"];
    [self.webV.configuration.userContentController removeScriptMessageHandlerForName:@"showName"];
    [self.webV.configuration.userContentController removeScriptMessageHandlerForName:@"showSendMsg"];
}

-(void)rightBarButtonItemClick {

//    NSHTTPCookieStorage *cookieStorayge = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    [cookieStorayge.cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"NSHTTPCookie--%@",obj.properties);
//    }];

//    if (@available(iOS 11.0, *)) {
//        WKHTTPCookieStore *wkCookie = self.webV.configuration.websiteDataStore.httpCookieStore;
//        [wkCookie getAllCookies:^(NSArray<NSHTTPCookie *> * _Nonnull cookies) {
//            [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                //NSLog(@"WKHTTPCookieStore--%@",obj.properties);
//            }];
//        }];
//
//        WKWebsiteDataStore *dataStore = [WKWebsiteDataStore defaultDataStore];
//
//        NSLog(@"%@-%@",dataStore,self.webV.configuration.websiteDataStore);
//        NSSet <NSString *> *recordsOfTypes = [WKWebsiteDataStore allWebsiteDataTypes];
//
//        [dataStore fetchDataRecordsOfTypes:recordsOfTypes completionHandler:^(NSArray<WKWebsiteDataRecord *> * recorders) {
//
//            [recorders enumerateObjectsUsingBlock:^(WKWebsiteDataRecord * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSLog(@"---%@:%@",obj.displayName,obj.dataTypes);
//
//            }];
//
//        }];
//
//        [dataStore removeDataOfTypes:recordsOfTypes modifiedSince:[NSDate dateWithTimeIntervalSince1970:1.f] completionHandler:^{
//             NSLog(@"移除完成");
//        }];
//
//    } else {
//
//        WKWebsiteDataStore *dataStore = [WKWebsiteDataStore defaultDataStore];
//
//        NSLog(@"%@",dataStore);
//    }
//
    
    // oc 调用js方法。注意JavaScriptString 是对于，h5中的函数。
    [self.webV evaluateJavaScript:@"alertMobile()" completionHandler:^(id _Nullable response, NSError * _Nullable error) {

        NSLog(@"%@-%@",response,error);
    }];

    [self.webV evaluateJavaScript:@"alertName('一个参数')" completionHandler:^(id _Nullable response, NSError * _Nullable error) {

        NSLog(@"%@-%@",response,error);
    }];

    [self.webV evaluateJavaScript:@"alertSendMsg('我是参数1','我是参数2')" completionHandler:^(id _Nullable response, NSError * _Nullable error) {

        NSLog(@"%@-%@",response,error);
    }];

  
}


#pragma mark --- WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"didReceiveScriptMessage:%@-%@",message.name,message.body);
}


#pragma mark --- WKNavigationDelegate

// 1、在发送请求之前，是否发送请求
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"decidePolicyForNavigationAction");
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 2、开始发送请求。注意理解该方法的调用评率，相对于上面和下面是很低的。我们在web页面内部跳转一般不会调用，偶尔会调用。
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"didStartProvisionalNavigation");
}

// 3、收到响应之前决定是否跳转。
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    NSLog(@"decidePolicyForNavigationResponse");
    decisionHandler(WKNavigationResponsePolicyAllow);

}

// 4、内容开始返回
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"didCommitNavigation");
}

// 5、页面加载完成
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"didFinishNavigation");

}

// 5-1、页面加载失败
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailProvisionalNavigation");

}

// 接收到服务器跳转请求的时候，调用。
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");

}

// 当数据加载发生错误时候调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailNavigation");

}

// 进程结束
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"webViewWebContentProcessDidTerminate");
}


#pragma mark --- WKUIDelegate
// js -- 调用native 几个重要方法。
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    
}

-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    completionHandler(YES); // 回调yes
}

-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
 
    completionHandler(@"123"); // 回调123
}

-(void)dealloc {
    [self removeMessageHandle];
    NSLog(@"%s",__func__);
}



@end

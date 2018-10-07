//
//  TransformViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/7/5.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "TransformViewController.h"
#import <Masonry.h>
@interface TransformViewController ()

@end

@implementation TransformViewController



- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    UIWebView *webView = [[UIWebView alloc] init];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}




@end

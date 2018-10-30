//
//  TransformViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/7/5.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "TransformViewController.h"
#import <Masonry.h>
@interface TransformViewController ()<UIWebViewDelegate>
{
    NSURLRequest *_req;
}
@end

@implementation TransformViewController



- (void)viewDidLoad {
    [super viewDidLoad];
 
    NSURL *url = [NSURL URLWithString:@"http://192.168.5.7/upload/recite/76ae5e9740d09aaa8d7950b5adba9155.doc"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    UIWebView *webV = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webV.delegate = self;
    [webV loadRequest:req];
    [self.view addSubview:webV];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");

}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@",error);
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:YES];
    
}




@end

//
//  CJURLProtocol.m
//  CJModule
//
//  Created by 仁和Mac on 2018/9/6.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJURLProtocol.h"

@implementation CJURLProtocol

// 必须重写的方法。
// 是否处理该请求。
+(BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSLog(@"%@",request);
    return YES;
}

//+(NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
//    return [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.github.com"]];
//}
//
//+(BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
//    return [super requestIsCacheEquivalent:a toRequest:b];
//}
//
//-(void)startLoading {
//   
//}
//
//-(void)stopLoading {
//   
//}

@end

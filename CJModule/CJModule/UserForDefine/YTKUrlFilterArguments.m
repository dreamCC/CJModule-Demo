//
//  YTKUrlFilterArguments.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/30.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "YTKUrlFilterArguments.h"
#import <AFNetworking.h>

@implementation YTKUrlFilterArguments {
    NSDictionary *_arguments;
}

+(instancetype)urlFilterWithArguments:(NSDictionary *)arguments {
    return [[self alloc] initWithArguments:arguments];
}

-(instancetype)initWithArguments:(NSDictionary *)arguments {
    self = [super init];
    if (self) {
        _arguments = arguments;
    }
    return self;
}

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request {
    return [self filterUrl:originUrl appendStringWithArguments:_arguments];
}

-(NSString *)filterUrl:(NSString *)originUrl appendStringWithArguments:(NSDictionary *)arguments {
    NSString *argumentsString  = AFQueryStringFromParameters(arguments);
    if (argumentsString.length == 0) {
        return originUrl;
    }
    NSURLComponents *components = [NSURLComponents componentsWithString:originUrl];
    NSString *query  = components.query; //参数。
    query            = [NSString stringWithFormat:query.length > 0? @"&%@":@"%@",argumentsString];

    components.query = query;
    return components.URL.absoluteString;
}

@end

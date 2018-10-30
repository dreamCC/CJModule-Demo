//
//  CJBaseRequest.m
//  CJModule
//
//  Created by 仁和Mac on 2018/10/10.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJBaseRequest.h"

@implementation CJBaseRequest

-(NSString *)requestUrl {
    return @"http://ol.whrhkj.com/appserver/classbanner";
}

-(NSInteger)cacheTimeInSeconds {
    return 24*60*60;
}


@end

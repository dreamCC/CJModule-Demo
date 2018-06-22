//
//  YTKUrlFilterArguments.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/30.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork.h>

@interface YTKUrlFilterArguments : NSObject<YTKUrlFilterProtocol>

+(instancetype)urlFilterWithArguments:(NSDictionary *)arguments;

@end

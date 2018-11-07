//
//  CJTreeViewObj.m
//  CJModule
//
//  Created by 仁和Mac on 2018/8/9.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJTreeViewObj.h"

@implementation CJTreeViewObj

-(instancetype)initWithName:(NSString *)name chirld:(NSArray *)chirldNoto {
    if (self = [super init]) {
        self.name = name;
        self.chirldNoto = chirldNoto;
    }
    return self;
}

@end

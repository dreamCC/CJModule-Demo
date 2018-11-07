//
//  CJTreeViewObj.h
//  CJModule
//
//  Created by 仁和Mac on 2018/8/9.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJTreeViewObj : NSObject

@property(nonatomic, strong) NSString *name;

@property(nonatomic, strong) NSArray *chirldNoto;

-(instancetype)initWithName:(NSString *)name chirld:(NSArray *)chirldNoto ;
@end

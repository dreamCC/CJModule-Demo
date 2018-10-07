//
//  CJScrollNumberLable.m
//  CJModule
//
//  Created by 仁和Mac on 2018/9/27.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJScrollNumberLable.h"

@interface CJScrollNumberLable()

@property(nonatomic,strong) NSMutableArray<NSString *> *textsCharacter;

@end

@implementation CJScrollNumberLable

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setText:(NSString *)text {
    NSAssert([self validateText:text], @"CJScrollNumberLable text must be number");
    for (int i = 0; i < text.length; i++) {
        NSString *subString = [text substringWithRange:NSMakeRange(i, 1)];
        [self.textsCharacter addObject:subString];
    }
}


-(void)initializelSubViews {
   
}

-(BOOL)validateText:(NSString *)text {
    NSString *regularString = @"^\\d+&";
    NSPredicate *pridicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regularString];
    return [pridicate evaluateWithObject:text];
}


-(NSMutableArray<NSString *> *)textsCharacter {
    if (!_textsCharacter) {
        _textsCharacter = [NSMutableArray array];
    }
    return _textsCharacter;
}

@end

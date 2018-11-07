//
//  CJTableViewCell.m
//  CJModule
//
//  Created by 仁和Mac on 2018/8/9.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJTableViewCell.h"
#import <Masonry.h>
#import <QMUIKit.h>

@interface CJTableViewCell ()

@property(nonatomic,weak) UIImageView *iamgeV;
@property(nonatomic, weak) UILabel *lab;


@end
 
@implementation CJTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = [[UIImage imageNamed:@"rightarrow"] qmui_imageWithTintColor:[UIColor purpleColor]];
        [self.contentView addSubview:imageV];
        _iamgeV = imageV;
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        UILabel *titleLab = [UILabel new];
        titleLab.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:titleLab];
        _lab = titleLab;
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(imageV);
            make.left.equalTo(imageV.mas_right).offset(20);
        }];
        
    }
    return self;
}

-(void)setTreeObj:(CJTreeViewObj *)treeObj level:(NSInteger)level {
    _treeObj = treeObj;
    _level = level;
    
    _lab.text = treeObj.name;
    if (level == 0) {
        
    }else {
        UIImage *img = [[UIImage imageNamed:@"rightarrow"] qmui_imageWithTintColor:[UIColor purpleColor]];
        _iamgeV.image = [img qmui_imageWithOrientation:UIImageOrientationRight];
        [_iamgeV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset(level * 20 + 10);
        }];
    }
    
}


@end

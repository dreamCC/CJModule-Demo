//
//  QMTableViewCell.m
//  CJModule
//
//  Created by 仁和Mac on 2018/9/18.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "QMTableViewCell.h"
#import <Masonry.h>

@interface QMTableViewCell()

@property(nonatomic, weak) UILabel *lab;


@end

@implementation QMTableViewCell

-(void)prepareForReuse {
    [super prepareForReuse];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.backgroundColor = [UIColor whiteColor];
        lab.numberOfLines = 0;
        lab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:lab];
        _lab = lab;
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).offset(5);
            make.bottom.equalTo(self.contentView).offset(-5);
            //make.right.equalTo(self.contentView).offset(-5);

        }];
        UIView *rightV = [UIView new];
        rightV.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:rightV];
        [rightV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(self.contentView).offset(-5);
            make.top.equalTo(self.contentView).offset(5);
            make.left.equalTo(lab.mas_right).offset(10);
            make.width.mas_equalTo(@20);
        }];
        
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
   
}

-(void)setContentString:(NSString *)contentString {
    _contentString = contentString;
    self.lab.text = contentString;
    
    
//    CGFloat sysH = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    CGFloat boundingH = [_contentString boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.contentView.frame) - 10 - 30, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    
//    NSLog(@"systemH:%f-boundingH:%f",sysH,boundingH);

}


@end

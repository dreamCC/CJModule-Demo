//
//  CJTableViewCell.h
//  CJModule
//
//  Created by 仁和Mac on 2018/8/9.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJTreeViewObj.h"

@interface CJTableViewCell : UITableViewCell

@property(nonatomic, strong) CJTreeViewObj *treeObj;

@property(nonatomic, assign) NSInteger level;


-(void)setTreeObj:(CJTreeViewObj *)treeObj level:(NSInteger)level;
@end

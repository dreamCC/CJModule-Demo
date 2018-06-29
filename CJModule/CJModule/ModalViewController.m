//
//  ModalViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/6/25.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "ModalViewController.h"
#import <WebKit/WebKit.h>
#import <QMUIKit.h>

@interface ModalViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSIndexPath *_selectIndexPath ,*_previousIndexPath;
}

@property(nonatomic,weak) UITableView *tablV;

@property(nonatomic, strong) NSMutableArray<NSIndexPath *> *mSelectedIndexPaths;

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tablV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    tablV.delegate = self;
    tablV.dataSource = self;
    tablV.tableFooterView = [UIView new];
    [self.view addSubview:tablV];
    _tablV = tablV;
}

#pragma mark --- delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"indexPath-%zd",indexPath.row];
//    if (_selectIndexPath && indexPath.row == _selectIndexPath.row) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }else {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    if ([self.mSelectedIndexPaths containsObject:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.row == _selectIndexPath.row) {
//        return;
//    }
//    _selectIndexPath = indexPath;
//
//    if (_previousIndexPath) {
//        [tableView reloadRowsAtIndexPaths:@[_previousIndexPath,indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }else {
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//    _previousIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];

    if ([self.mSelectedIndexPaths containsObject:indexPath]) {
        [self.mSelectedIndexPaths removeObject:indexPath];
    }else {
        [self.mSelectedIndexPaths addObject:indexPath];
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(NSMutableArray<NSIndexPath *> *)mSelectedIndexPaths {
    if (!_mSelectedIndexPaths) {
        _mSelectedIndexPaths = [NSMutableArray array];
    }
    return _mSelectedIndexPaths;
}

@end







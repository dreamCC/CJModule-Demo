//
//  CJTableViewIndex.h
//  CJModule
//
//  Created by 仁和Mac on 2017/7/13.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 1、通过[[CJTableViewIndex alloc] init]; 初始化，不用设置frame，默认高度是tableView的高度，宽度18。
 2、设置sectionIndexs
 3、监听。a、可以通过addTarget: forControlEvents:UIControlEventValueChanged
         b、或者通过index.selectIndexChange = ^(UITableView *tableView, NSUInteger selectIndex, NSString *selectString) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:selectIndex];
            [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
         }; 注意，必须使用返回参数的tableView，如果使用[weakSelf.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO]
            会造成循环引用。UITableView->CJTableViewIndex->block->UITableView
 */
@interface CJTableViewIndex : UIControl

/// 索引数据。
@property(nonatomic, strong) NSArray<NSString *> *sectionIndexs;

/// 索引字体大小，默认10。
@property(nonatomic, assign) CGFloat fontSize;

/// 索引的宽度，不设置或者设置小于等于0，都会置为16.f。
@property(nonatomic, assign) CGFloat indexWidth;

/// 选中的索引。
@property(nonatomic, assign) NSUInteger selectIndex;

/// 选中的索引内容。
@property(nonatomic, strong, readonly) NSString *selectString;

/// 是否显示搜索（🔍图标），默认YES。注意：searchIcon的颜色，是和索引字体nomal状态下颜色一样的。
@property(nonatomic, assign, getter=isShowSearchIcon) BOOL showSearchIcon;

/// 当点击或者滑动的时候，是否显示指示器。默认YES。
@property(nonatomic, assign, getter=isShowIndicatorView) BOOL showIndicatorView;

/// selectIndex改变
@property (nonatomic, copy) void(^selectIndexChange)(UITableView *tableView, NSUInteger selectIndex, NSString *selectString);

/// 设置索引字体颜色。默认，nomal-lightGrayColor   selected-whiteColor
-(void)setIndexsColor:(UIColor *)color state:(UIControlState)state;
/// 设置索引背景颜色。默认，nomal-whiteColor    selected-lightGrayColor
-(void)setIndexsBackgroudColor:(UIColor *)color state:(UIControlState)state;


/**
 重置所有索引的状态。
 */
-(void)resetSectionIndexsDisplay;
@end


@interface UITableView (CJSectionIndex)

@property(nonatomic,weak) CJTableViewIndex *cj_tableViewIndex;

@end



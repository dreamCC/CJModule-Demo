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
#import "QMViewController.h"
#import "SearchResultViewController.h"
#import "NSArray+CJCategory.h"
#import "CJTableViewIndex.h"
#import "CJModule.h"


@interface QDRecentSearchView : UIView

@property(nonatomic, strong) QMUILabel *titleLabel;
@property(nonatomic, strong) QMUIFloatLayoutView *floatLayoutView;


@end

@implementation QDRecentSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorWhite;
        
        self.titleLabel = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(14) textColor:[UIColor lightGrayColor]];
        self.titleLabel.text = @"最近搜索";
        self.titleLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
        [self.titleLabel sizeToFit];
        self.titleLabel.qmui_borderPosition = QMUIBorderViewPositionBottom;
        [self addSubview:self.titleLabel];
        
        self.floatLayoutView = [[QMUIFloatLayoutView alloc] init];
        self.floatLayoutView.padding = UIEdgeInsetsZero;
        self.floatLayoutView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
        self.floatLayoutView.minimumItemSize = CGSizeMake(69, 29);
        [self addSubview:self.floatLayoutView];
        
        NSArray<NSString *> *suggestions = @[@"Helps", @"Maintain", @"Liver", @"Health", @"Function", @"Supports", @"Healthy", @"Fat"];
        for (NSInteger i = 0; i < suggestions.count; i++) {
            QMUIGhostButton *button = [[QMUIGhostButton alloc] initWithGhostType:QMUIGhostButtonColorGray];
            [button setTitle:suggestions[i] forState:UIControlStateNormal];
            button.titleLabel.font = UIFontMake(14);
            button.contentEdgeInsets = UIEdgeInsetsMake(6, 20, 6, 20);
            [self.floatLayoutView addSubview:button];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIEdgeInsets padding = UIEdgeInsetsConcat(UIEdgeInsetsMake(26, 26, 26, 26), self.qmui_safeAreaInsets);
    CGFloat titleLabelMarginTop = 20;
    self.titleLabel.frame = CGRectMake(padding.left, padding.top, CGRectGetWidth(self.bounds) - UIEdgeInsetsGetHorizontalValue(padding), CGRectGetHeight(self.titleLabel.frame));
    
    CGFloat minY = CGRectGetMaxY(self.titleLabel.frame) + titleLabelMarginTop;
    self.floatLayoutView.frame = CGRectMake(padding.left, minY, CGRectGetWidth(self.bounds) - UIEdgeInsetsGetHorizontalValue(padding), CGRectGetHeight(self.bounds) - minY);
}

@end




@interface ModalViewController ()<UITableViewDelegate,UITableViewDataSource,QMUISearchControllerDelegate> {
    NSIndexPath *_selectIndexPath ,*_previousIndexPath;
    QMUISearchController *_searchVC;
    NSMutableArray *_searchResults;
}

@property(nonatomic,weak) UITableView *tablV;

@property(nonatomic, strong) NSMutableArray<NSIndexPath *> *mSelectedIndexPaths;

@property(nonatomic, strong) NSArray *dataSourceArray;
@property(nonatomic, strong) NSMutableArray *sectionIndexAry;

@end

@implementation ModalViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    QMUISearchController *searchVC = [[QMUISearchController alloc] initWithContentsViewController:self];
    searchVC.searchResultsDelegate = self;
    searchVC.searchBar.qmui_usedAsTableHeaderView = YES;
    searchVC.searchBar.searchTextPositionAdjustment = UIOffsetMake(20, 0);
    searchVC.hidesNavigationBarDuringPresentation = YES;
    searchVC.launchView = [QDRecentSearchView new];
    _searchVC = searchVC;
    
    _searchResults = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    
    for (NSDictionary *dic in self.dataSourceArray) {
        [self.sectionIndexAry addObject:dic[@"firstLetter"]];
    }
    
    CJTableViewIndex *index = [[CJTableViewIndex alloc] initWithFrame:CGRectMake(0, 64, 18, CGRectGetHeight(self.view.frame)-64)];
    
    index.sectionIndexs = self.sectionIndexAry.copy;
    
    [index setIndexsColor:[UIColor purpleColor] state:UIControlStateNormal];
    [index setIndexsColor:[UIColor cyanColor] state:UIControlStateSelected];
    [index setIndexsBackgroudColor:[UIColor purpleColor] state:UIControlStateSelected];
    
    index.showSearchIcon = YES;
    index.showIndicatorView = YES;
    
    index.selectIndexChange = ^(UITableView *tableView, NSUInteger selectIndex, NSString *selectString) {
        NSLog(@"selectIndex-%@--%zd",selectString,selectIndex);
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:selectIndex];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    };
    //[index addTarget:self action:@selector(indexValueChange:) forControlEvents:UIControlEventValueChanged];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tablV = [[UITableView alloc] initWithFrame:(CGRect){{0,64},{self.view.frame.size.width,self.view.frame.size.height - 64}} style:UITableViewStylePlain];
    tablV.delegate = self;
    tablV.dataSource = self;
    tablV.tableFooterView = [UIView new];
    tablV.tableHeaderView = searchVC.searchBar;
    tablV.cj_tableViewIndex = index;

    [self.view addSubview:tablV];
    _tablV = tablV;

}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage qmui_imageWithColor:[UIColor purpleColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.alpha = 1.f;
}

-(void)indexValueChange:(CJTableViewIndex *)tableViewIndex {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:tableViewIndex.selectIndex];
    [_tablV scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

-(void)searchController:(QMUISearchController *)searchController updateResultsForSearchString:(NSString *)searchString {
    NSLog(@"---%@",searchString);
    [_searchResults addObject:searchString];

    if ([searchString isEqualToString:@"clear"]) {
        [searchController showEmptyViewWithText:@"暂无结果" detailText:nil buttonTitle:nil buttonAction:NULL];
        [_searchResults removeAllObjects];
    }else {
        [searchController hideEmptyView];
    }
    [_searchVC.tableView reloadData];

}

#pragma mark --- delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_searchVC.active) {
        return 1;
    }
    return self.sectionIndexAry.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_searchVC.active) {
        return _searchResults.count;
    }
    return [(NSArray *)self.dataSourceArray[section][@"content"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (_searchVC.active) {
        cell.textLabel.text = [NSString stringWithFormat:@"searchResult-%@",_searchResults[indexPath.row]];

    }else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[(NSArray *)self.dataSourceArray[indexPath.section][@"content"] objectAtIndex:indexPath.row]];
        if ([self.mSelectedIndexPaths containsObject:indexPath]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}






-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    NSLog(@"--%zd",_tablV.indexPathsForVisibleRows.firstObject.section);
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}



-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"default" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"normal" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    
    UITableViewRowAction *action3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"destructive" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    return @[action1,action2,action3];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == _selectIndexPath.row) {
        return;
    }
    if (_searchVC.active) {
        QMViewController *qmvc = [[QMViewController alloc] init];
        [self.navigationController pushViewController:qmvc animated:YES];
    }else {
        if ([self.mSelectedIndexPaths containsObject:indexPath]) {
            [self.mSelectedIndexPaths removeObject:indexPath];
        }else {
            [self.mSelectedIndexPaths addObject:indexPath];
        }
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionIndexAry[section];
}

//-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return self.sectionIndexAry;
//}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
//    [tableView qmui_scrollToRowFittingOffsetY:10 atIndexPath:indexPath animated:YES];
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    return index;
}

-(NSMutableArray<NSIndexPath *> *)mSelectedIndexPaths {
    if (!_mSelectedIndexPaths) {
        _mSelectedIndexPaths = [NSMutableArray array];
    }
    return _mSelectedIndexPaths;
}

- (NSArray *)dataSourceArray {
    if (!_dataSourceArray) {
        NSArray *ary = @[@"卡地亚", @"法兰克穆勒", @"尊皇", @"蒂芙尼", @"艾米龙", @"NOMOS", @"依波路", @"波尔", @"帝舵", @"名士", @"芝柏", @"积家", @"尼芙尔", @"泰格豪雅", @"艾美", @"拉芙兰瑞", @"宝格丽", @"古驰", @"香奈儿", @"迪奥", @"雷达", @"豪利时", @"路易.威登", @"蕾蒙威", @"康斯登", @"爱马仕", @"昆仑", @"斯沃琪", @"WEMPE", @"万宝龙", @"浪琴", @"柏莱士", @"雅克德罗", @"雅典", @"帕玛强尼", @"格拉苏蒂原创", @"伯爵", @"百达翡丽", @"爱彼", @"宝玑", @"江诗丹顿", @"宝珀", @"理查德·米勒", @"梵克雅宝", @"罗杰杜彼", @"萧邦", @"百年灵", @"宝齐莱", @"瑞宝", @"沛纳海", @"宇舶", @"真力时", @"万国", @"欧米茄", @"劳力士", @"朗格",@"@嗯哈"];
        _dataSourceArray = [ary cj_sortArryWithFirstLetter];
    }
    return _dataSourceArray;
}

-(NSMutableArray *)sectionIndexAry {
    if (!_sectionIndexAry) {
        _sectionIndexAry = [NSMutableArray array];
    }
    return _sectionIndexAry;
}

-(void)dealloc {
    NSLog(@"dealloc");
}



- (BOOL)shouldCustomNavigationBarTransitionWhenPushAppearing {
    return YES;
}

- (BOOL)shouldCustomNavigationBarTransitionWhenPushDisappearing {
    return YES;
}

- (BOOL)shouldCustomNavigationBarTransitionWhenPopAppearing {
    return YES;
}

- (BOOL)shouldCustomNavigationBarTransitionWhenPopDisappearing {
    return YES;
}

//-(UIImage *)navigationBarBackgroundImage {
//    return [UIImage qmui_imageWithColor:[UIColor purpleColor]];
//}


@end







//
//  SearchResultViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/7/12.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_results;
    UITableView *_tablv;
}

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    _results = [NSMutableArray array];
    
    UITableView *tablV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    
    tablV.delegate = self;
    tablV.dataSource = self;
    tablV.tableFooterView = [UIView new];
    tablV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:tablV];
    _tablv = tablV;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"SearchResultViewController-%@",searchController.searchBar.text);
    if ([searchController.searchBar.text isEqualToString:@"clear"]) {
        [_results removeAllObjects];
    }else {
        [_results addObject:searchController.searchBar.text];
    }
    [_tablv reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _results.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"--%@",_results[indexPath.row]];
    return cell;
}


@end

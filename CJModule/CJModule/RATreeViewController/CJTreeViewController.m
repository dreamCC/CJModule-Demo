//
//  CJTreeViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/8/9.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJTreeViewController.h"
#import <RATreeView.h>
#import "CJTableViewCell.h"
#import "CJTreeViewObj.h"

@interface CJTreeViewController ()<RATreeViewDelegate,RATreeViewDataSource>

@property(nonatomic, strong) NSArray *sourcesData;

@end

@implementation CJTreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    RATreeView *view = [[RATreeView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.frame.size.height - 64) style:RATreeViewStylePlain];
    
    view.delegate = self;
    view.dataSource = self;
    view.separatorStyle = RATreeViewCellSeparatorStyleSingleLine;
    view.treeFooterView = [UIView new];
    view.rowHeight = 50.f;
    
    [self.view addSubview:view];
    
    [view registerClass:[CJTableViewCell class] forCellReuseIdentifier:@"CJTreeViewObj"];
}

#pragma mark -- delegate && datesource
-(NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item {
    if (item == nil) {
        return self.sourcesData.count;
    }
    
    CJTreeViewObj *obj  = (CJTreeViewObj *)item;
    return obj.chirldNoto.count;
}

-(UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item {
    CJTableViewCell *cell = [treeView dequeueReusableCellWithIdentifier:@"CJTreeViewObj"];
    
    [cell setTreeObj:item level:[treeView levelForCellForItem:item]];
    return cell;
}

-(id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item {
    if (!item) {
        return self.sourcesData[index];
    }
    CJTreeViewObj *obj = item;
    return obj.chirldNoto[index];
}


-(NSArray *)sourcesData {
    if (!_sourcesData) {
        CJTreeViewObj *obj111 = [[CJTreeViewObj alloc] initWithName:@"sub2-0" chirld:nil];
        CJTreeViewObj *obj112 = [[CJTreeViewObj alloc] initWithName:@"sub2-2" chirld:nil];
        CJTreeViewObj *obj113 = [[CJTreeViewObj alloc] initWithName:@"sub2-3" chirld:nil];
        
         CJTreeViewObj *obj = [[CJTreeViewObj alloc] initWithName:@"sub1-0" chirld:@[obj111,obj112,obj113]];
         CJTreeViewObj *obj1 = [[CJTreeViewObj alloc] initWithName:@"sub1-2" chirld:nil];
         CJTreeViewObj *obj2 = [[CJTreeViewObj alloc] initWithName:@"sub1-3" chirld:nil];
         CJTreeViewObj *obj3 = [[CJTreeViewObj alloc] initWithName:@"sub1-4" chirld:nil];
         CJTreeViewObj *obj4 = [[CJTreeViewObj alloc] initWithName:@"sub1-5" chirld:nil];
         CJTreeViewObj *obj5 = [[CJTreeViewObj alloc] initWithName:@"sub1-6" chirld:nil];
         CJTreeViewObj *obj6 = [[CJTreeViewObj alloc] initWithName:@"sub1-7" chirld:nil];
        
        CJTreeViewObj *sectionOne = [[CJTreeViewObj alloc] initWithName:@"one-section" chirld:@[obj,obj1,obj2,obj3,obj4,obj5,obj6]];
        
        CJTreeViewObj *obj20 = [[CJTreeViewObj alloc] initWithName:@"sub2-0" chirld:nil];
        CJTreeViewObj *obj21 = [[CJTreeViewObj alloc] initWithName:@"sub2-2" chirld:nil];
        CJTreeViewObj *obj22 = [[CJTreeViewObj alloc] initWithName:@"sub2-3" chirld:nil];
   
        
        CJTreeViewObj *sectionTwo = [[CJTreeViewObj alloc] initWithName:@"two-section" chirld:@[obj20,obj21,obj22]];
        
        _sourcesData = @[sectionOne,sectionTwo];
    }
    return _sourcesData;
}



@end

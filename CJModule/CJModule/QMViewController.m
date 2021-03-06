//
//  QMViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/7/5.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "QMViewController.h"
#import "CJSnipImageView.h"
#import "ModalViewController.h"
#import "CJScanQRCodeManager.h"
#import <WebKit/WebKit.h>
#import "CJThemeManager.h"
#import "QMUIConfigurationTemplatePinkRose.h"
#import "QMUIConfigurationTemplateGrapefruit.h"
#import <objc/runtime.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <Masonry.h>
#import "QMTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "EmptyDataSetManager.h"


@interface QMViewController ()<UITableViewDelegate,UITableViewDataSource> {
    EmptyDataSetManager *_emptyManager;
}

@property(nonatomic, strong) CJScanQRCodeManager *manager;

@property(nonatomic, strong) NSMutableArray *mAry;
@end

@implementation QMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"--viewDidLoad");

   
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    __weak typeof(self)weakSelf = self;
    EmptyDataSetManager *emptyManager = [[EmptyDataSetManager alloc] init];
  
    emptyManager.emptyDataSetTapView = ^(UITableView * _Nonnull scrollView, UIView * _Nonnull tapView, EmptyDataSetManager * _Nonnull manager) {
        NSLog(@"%@",tapView);
        manager.showCustomView = !manager.isShowingCustomView;
        manager.shouldBeForcedToDisplay = YES;
        for (int i = 0, count = 20; i < count; i++) {
            NSMutableString *mString = [NSMutableString string];
            [mString appendString:@"CocoaChina_让移动开发更简单!!"];

            [weakSelf.mAry addObject:mString];
        }
        [scrollView reloadEmptyDataSet];
        [scrollView reloadData];

    };
    
    emptyManager.emptyDataSetTapButton = ^(__kindof UITableView * _Nonnull scrollView, UIButton * _Nonnull button, EmptyDataSetManager * _Nonnull manager) {
        [manager updateEmptyDataSetImage:[UIImage imageNamed:@"no_network"] title:@"无网络" message:nil buttonTitle:@"查看网络->"];
        manager.titleAttibutes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        [scrollView reloadEmptyDataSet];
    };
    _emptyManager = emptyManager;

    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableV.backgroundColor = [UIColor qmui_randomColor];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.emptyDataSetSource = emptyManager;
    tableV.emptyDataSetDelegate = emptyManager;
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.sectionHeaderHeight = CGFLOAT_MIN;
    tableV.sectionFooterHeight = CGFLOAT_MIN;

    tableV.tableFooterView = [UIView new];
    tableV.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    tableV.estimatedRowHeight = 0;
    [self.view addSubview:tableV];
    [tableV registerClass:[QMTableViewCell class] forCellReuseIdentifier:@"cellId"];
    [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.offset(64);
        }
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
   

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    QMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.contentString = self.mAry[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat h = [tableView fd_heightForCellWithIdentifier:@"cellId" cacheByIndexPath:indexPath configuration:^(QMTableViewCell *cell) {
        cell.contentString = self.mAry[indexPath.row];

    }];

    return h;
 
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (@available(iOS 11.0, *)) {
        NSLog(@"%@",NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
    } else {
        // Fallback on earlier versions
        NSLog(@"%@",self.view);
    }
}

-(NSMutableArray *)mAry {
    if (!_mAry) {
        _mAry = [NSMutableArray array];
    }
    return _mAry;
}


static BOOL is_applyTheme;
-(void)getClassList {
    if (is_applyTheme) {
        return;
    }
    
//    Protocol *protocol = @protocol(QMUIConfigurationTemplateProtocol);
//
//    int  classList = objc_getClassList(NULL, 0); // 获取的注册的所有类。
//    if (classList > 0) {
//        Class *classes =  (Class *)malloc(sizeof(Class) * classList); // 获取注册所有类，所需要内存空间。 通过class * 来保存。
//        classList = objc_getClassList(classes, classList); //  获取所有类，并且存放在classes 里面，相当于上面一步Class * 里面填充数据。同时，所有类的个数是classList。
//        for (int i = 0; i < classList; i++) {
//            Class cls = classes[i]; // 逐个遍历class。
//            // 接下来就可以做，自己业务。
//            if ([NSStringFromClass(cls) hasPrefix:@"QMUIConfiguration"] && [cls conformsToProtocol:protocol]) {
//                if ([cls instancesRespondToSelector:@selector(shouldApplyTemplateAutomatically)]) {
//                    id<QMUIConfigurationTemplateProtocol> obj = [[cls alloc] init];
//                    if ([obj shouldApplyTemplateAutomatically]) {
//                        [obj applyConfigurationTemplate];
//                        is_applyTheme = YES;
//                        break; //一般只需要遍历一次就可以了。
//                    }
//                }
//
//            }
//
//        }
//
//        free(classes);
//    }
}

-(CGSize)preferredContentSizeInModalPresentationViewController:(QMUIModalPresentationViewController *)controller keyboardHeight:(CGFloat)keyboardHeight limitSize:(CGSize)limitSize {
    return CGSizeMake(200, 400);
}

-(void)dealloc {
    NSLog(@"%s",__func__);
}

@end

//
//  ViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/6/22.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "ViewController.h"
#import <QMUIKit.h>
#import "CJAppearanceView.h"
#import "CJModule.h"
#import "CJMarqueeLabel.h"
#import "ModalViewController.h"
#import "CJRollingAdView.h"
#import "TransformViewController.h"
#import "CJSnipImageView.h"
#import "CJCropBoxView.h"
#import "QMViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "CJTableViewIndex.h"
#import "CJBarbuttonItem.h"
#import <YYKit.h>
#import "CJNavigationBar.h"
#import "CJRequest.h"
#import "UIWindowModalViewController.h"
#import "CJRateView.h"
#import <Masonry.h>
#import "UICountingLabel.h"
#import "CJCountingLable.h"
#import "SPScrollNumLabel.h"

@interface ViewController ()<QMUIImagePreviewViewDelegate,UIScrollViewDelegate,QMUIAlbumViewControllerDelegate,QMUIImagePickerViewControllerDelegate> {
    NSMutableArray *_imagesAry;
    QMUIImagePreviewViewController *_previewVC;
    QMUIAssetsGroup *_assetGroup;
    QMUIZoomImageView *_imgV;
    
    CJSnipImageView *_snipImageV;

    UIBarButtonItem *_barButtonItem;
    UINavigationItem *_item1;
    CGFloat _alpha;
    
    NSURLSession *_urlSession;
    SPScrollNumLabel *_scrollNumLab;
}



@property(nonatomic, strong) UIWindow *windo;

@property(nonatomic, strong) QMUIModalPresentationViewController *presentation;


@end

@implementation ViewController {
    QMUIEmotionInputManager *_manager;
    CJRateView *_rateView;
}

-(void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"titleLab";
    titleLab.backgroundColor = [UIColor cyanColor];
    [titleLab sizeToFit];
    _barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
//    _barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:titleLab];
    self.navigationItem.leftBarButtonItem = _barButtonItem;
    QMUINavigationTitleView *titleV = [[QMUINavigationTitleView alloc] initWithStyle:QMUINavigationTitleViewStyleDefault];
    titleV.needsLoadingView = YES;
    titleV.loadingViewHidden = NO;
    titleV.userInteractionEnabled = YES;
    titleV.title = @"nTitleView";
    titleV.accessoryType = QMUINavigationTitleViewAccessoryTypeDisclosureIndicator;


    
    QMUIAssetsManager *assetManager = [QMUIAssetsManager sharedInstance];
    [assetManager enumerateAllAlbumsWithAlbumContentType:QMUIAlbumContentTypeOnlyPhoto showEmptyAlbum:YES showSmartAlbumIfSupported:YES usingBlock:^(QMUIAssetsGroup *resultAssetsGroup) {

        NSLog(@"%@-%zd",resultAssetsGroup.name,resultAssetsGroup.numberOfAssets);
        if ([resultAssetsGroup.name isEqualToString:@"相机胶卷"]) {
            self->_assetGroup = resultAssetsGroup;
            return;
        }
    }];

    CJSnipImageView *snipImageView = [[CJSnipImageView alloc] init];
    
    snipImageView.frame = CGRectMake(10, 100, self.view.qmui_width - 20, 300);
    snipImageView.zoomImageView.image = [UIImage imageNamed:@"image0"];
    [self.view addSubview:snipImageView];
    _snipImageV = snipImageView;
    
    
    
    UINavigationItem *item1 = [[UINavigationItem alloc] initWithTitle:@"naviagtionItem"];
    item1.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
    _item1 = item1;

    self.navigationItem.titleView = titleLab;
    
    [[PHAsset cj_ivarNames] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    
    
   
    
    self.navigationItem.title = @"firsTitle";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage qmui_imageWithColor:[UIColor cyanColor]] forBarMetrics:UIBarMetricsDefault];
    

    self.navigationController.tabBarItem.badgeValue = @"2";
    
    self.navigationController.tabBarController.tabBar.backgroundColor = [UIColor purpleColor];
    
    NSLog(@"%@",NSHomeDirectory());
    
    

    
    SPScrollNumLabel *scrollNum = [[SPScrollNumLabel alloc] initWithFrame:CGRectMake(20, 500, 100, 40)];
    scrollNum.targetNumber = 10;
    [self.view addSubview:scrollNum];
    _scrollNumLab  = scrollNum;
    
 
}



-(void)rateChange:(CJRateView *)rateView {
    NSLog(@"---%f",rateView.currentRate);
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 
}



-(NSUInteger)numberOfImagesInImagePreviewView:(QMUIImagePreviewView *)imagePreviewView {
    return _imagesAry.count;
}

-(void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView renderZoomImageView:(QMUIZoomImageView *)zoomImageView atIndex:(NSUInteger)index {
    if (index == 2) {
        zoomImageView.image = nil;
        [zoomImageView showLoading];
        
    }else {
        zoomImageView.image = _imagesAry[index];
        [zoomImageView hideEmptyView];
    }
}

-(void)singleTouchInZoomingImageView:(QMUIZoomImageView *)zoomImageView location:(CGPoint)location {
    [_previewVC endPreviewFading];
}

-(void)leftItemClick:(UIBarButtonItem *)item {
    

//    ModalViewController *modal = [ModalViewController new];
//
//    [self.navigationController pushViewController:modal animated:YES];

//    UIWindowModalViewController *windoModal = [[UIWindowModalViewController alloc] init];
//
//    QMUIModalPresentationViewController *presentation = [[QMUIModalPresentationViewController alloc] init];
//    presentation.contentViewController = windoModal;
//    presentation.animationStyle = QMUIModalPresentationAnimationStyleSlide;
//    [presentation showWithAnimated:YES completion:^(BOOL finished) {
//
//    }];
    

//    TransformViewController *transV = [[TransformViewController alloc] init];
//    [self.navigationController pushViewController:transV animated:YES];

    
//    QMViewController *qm_vc = [[QMViewController alloc] init];


//    [self.navigationController pushViewController:qm_vc animated:YES];
    
    
 
}



-(QMUIImagePickerViewController *)imagePickerViewControllerForAlbumViewController:(QMUIAlbumViewController *)albumViewController {
    QMUIImagePickerViewController *pickerV = [[QMUIImagePickerViewController alloc] init];
    
    pickerV.imagePickerViewControllerDelegate = self;
    
    pickerV.allowsMultipleSelection = YES;
    
    return pickerV;
}

-(void)imagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController didSelectImageWithImagesAsset:(QMUIAsset *)imageAsset afterImagePickerPreviewViewControllerUpdate:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController {
    
    NSLog(@"didSelectImageWithImagesAsset-%@",imagePickerPreviewViewController);
    
}



-(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewControllerForImagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController {
    QMUIImagePickerPreviewViewController *previewV = [[QMUIImagePickerPreviewViewController alloc] init];

    return previewV;
}



-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}



@end

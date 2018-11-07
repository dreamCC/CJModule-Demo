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
#import "UIWindowModalViewController.h"
#import "CJRateView.h"
#import <Masonry.h>
#import "UICountingLabel.h"
#import "CJCountingLable.h"
#import "SPScrollNumLabel.h"
#import <YTKNetwork.h>
#import <AFNetworking.h>
#import "CJBaseRequest.h"
#import <QuickLook/QuickLook.h>
#import <WebKit/WebKit.h>

@interface ViewController ()<QMUIImagePreviewViewDelegate,UIScrollViewDelegate,QMUIAlbumViewControllerDelegate,QMUIImagePickerViewControllerDelegate> {
    NSMutableArray *_imagesAry;
    QMUIImagePreviewViewController *_previewVC;
    QMUIAssetsGroup *_assetGroup;
    QMUIZoomImageView *_imgV;
    
    CJSnipImageView *_snipImageV;

    UIBarButtonItem *_barButtonItem;
    UINavigationItem *_item1;
    CGFloat _alpha;
    
    
    YYAnimatedImageView *_yy_imageV;
 
}



@property(nonatomic, strong) UIWindow *windo;

@property(nonatomic, strong) QMUIModalPresentationViewController *presentation;


@end

@implementation ViewController {
    QMUIEmotionInputManager *_manager;
    CJRateView *_rateView;
    CJGradientProgressView *_progressView;
}

-(void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
   
    _barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];

    self.navigationItem.leftBarButtonItem = _barButtonItem;
    QMUINavigationTitleView *titleV = [[QMUINavigationTitleView alloc] initWithStyle:QMUINavigationTitleViewStyleDefault];
    titleV.needsLoadingView = YES;
    titleV.loadingViewHidden = NO;
    titleV.userInteractionEnabled = YES;
    titleV.title = @"nTitleView";
    titleV.accessoryType = QMUINavigationTitleViewAccessoryTypeDisclosureIndicator;
    titleV.backgroundColor = [UIColor purpleColor];

    
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
    


    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"titleLab";
    titleLab.backgroundColor = [UIColor cyanColor];
    titleLab.frame = CGRectMake(0, 0, 100, 50);
    self.navigationItem.titleView = titleV;
    
    [[PHAsset cj_ivarNames] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    
   
    
//    self.navigationItem.title = @"标题1";

    
    NSLog(@"%@",NSHomeDirectory());

    
    UIImage *img = [UIImage imageNamed:@"DefaultLS.png"];
    
    
    CGImageRef imgRef = img.CGImage;
    NSLog(@"%@",imgRef);
    
    if (@available(iOS 9.0, *)) {
        NSLog(@"UTType-%@",CGImageGetUTType(imgRef));
    } else {
        
    }
    NSLog(@"%zu",CGImageGetWidth(imgRef));
    NSLog(@"%d",CGImageGetBitmapInfo(imgRef));
    
    
    CGImageRef copyImgRef = CGImageCreateCopy(imgRef);
    
    if (@available(iOS 9.0, *)) {
        NSLog(@"UTType-%@",CGImageGetUTType(copyImgRef));
    } else {
        
    }
    NSLog(@"%zu",CGImageGetWidth(copyImgRef));
    NSLog(@"%d",CGImageGetBitmapInfo(copyImgRef));
    
    YYAnimatedImageView *imgV = [[YYAnimatedImageView alloc] init];
    imgV.backgroundColor = [UIColor lightGrayColor];
    imgV.image = [self grayImageWithImage:[UIImage imageNamed:@"image0.png"]];
    [self.view addSubview:imgV];
    _yy_imageV = imgV;
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(snipImageView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    

    CJGradientProgressView *progressV = [[CJGradientProgressView alloc] initWithFrame:CGRectMake(10, 410, CGRectGetWidth(self.view.frame) - 20, 2)];
    
    progressV.startColor = [UIColor colorWithRed:208/255.f green:208/255.f blue:208/255.f alpha:1.0];

    progressV.endColor = [UIColor greenColor];
    [self.view addSubview:progressV];

    _progressView = progressV ;
    
    
    

}

-(UIImage *)grayImageWithImage:(UIImage *)image {
    CGImageRef imageRef = CGImageCreateCopyWithColorSpace(image.CGImage, CGColorSpaceCreateDeviceRGB());
    UIImage *grayImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];

    return grayImage;
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    
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
    

    TransformViewController *transV = [[TransformViewController alloc] init];
    [self.navigationController pushViewController:transV animated:YES];

    
//    QMViewController *qm_vc = [[QMViewController alloc] init];
//
//
//    [self.navigationController pushViewController:qm_vc animated:YES];

    
//    CJBaseRequest *baseRequest = [[CJBaseRequest alloc] init];
//    [baseRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"success-%@",request.responseJSONObject);
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"erroro");
//    }];
//
//    static CGFloat pro = 0.f;
//    _progressView.progress = pro;
//    pro += 0.5;
//    
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

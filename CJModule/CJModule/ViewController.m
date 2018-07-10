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

@interface ViewController ()<QMUIImagePreviewViewDelegate,UIScrollViewDelegate,QMUIAlbumViewControllerDelegate,QMUIImagePickerViewControllerDelegate> {
    NSMutableArray *_imagesAry;
    QMUIImagePreviewViewController *_previewVC;
    QMUIAssetsGroup *_assetGroup;
    QMUIZoomImageView *_imgV;
    UIImageView *_imageV;
    
    CJSnipImageView *_snipImageV;
}



@property(nonatomic, strong) UIWindow *windo;



@end

@implementation ViewController {
    QMUIEmotionInputManager *_manager;
    
}

-(void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
    QMUINavigationTitleView *titleV = [[QMUINavigationTitleView alloc] initWithStyle:QMUINavigationTitleViewStyleDefault];
    titleV.needsLoadingView = YES;
    titleV.loadingViewHidden = NO;
    titleV.userInteractionEnabled = YES;
    titleV.title = @"nTitleView";
    titleV.accessoryType = QMUINavigationTitleViewAccessoryTypeDisclosureIndicator;

    self.navigationItem.titleView = titleV;
    
 
    UIInterpolatingMotionEffect *motionX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    motionX.minimumRelativeValue = @(-50);
    motionX.maximumRelativeValue = @50;

    UIInterpolatingMotionEffect *motionY = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    motionX.minimumRelativeValue = @(-50);
    motionX.maximumRelativeValue = @50;
    [self.view addMotionEffect:motionY];
    

    _imagesAry = [NSMutableArray array];
    for (int i = 0,count = 7; i < count; i++) {
        NSString *name = [NSString stringWithFormat:@"image%d",i];
        [_imagesAry addObject:UIImageMake(name)];
    }

   
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList([NSNotificationCenter class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        const char *char_name = ivar_getName(ivar);
        NSString *name = [NSString stringWithUTF8String:char_name];
        NSLog(@"%@",name);
    }
    
    
    QMUIAssetsManager *assetManager = [QMUIAssetsManager sharedInstance];
    [assetManager enumerateAllAlbumsWithAlbumContentType:QMUIAlbumContentTypeOnlyPhoto showEmptyAlbum:YES showSmartAlbumIfSupported:YES usingBlock:^(QMUIAssetsGroup *resultAssetsGroup) {

        NSLog(@"%@-%zd",resultAssetsGroup.name,resultAssetsGroup.numberOfAssets);
        if ([resultAssetsGroup.name isEqualToString:@"相机胶卷"]) {
            self->_assetGroup = resultAssetsGroup;
            return;
        }
    }];

//    QMUIZoomImageView *zoomImageView = [[QMUIZoomImageView alloc] init];
//    zoomImageView.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:zoomImageView];
//    _imgV = zoomImageView;
//    [_imgV showLoading];

    CJSnipImageView *snipImageView = [[CJSnipImageView alloc] init];
    
    snipImageView.frame = CGRectMake(10, 100, self.view.qmui_width - 20, 300);
    snipImageView.zoomImageView.image = [UIImage imageNamed:@"image0"];
    [self.view addSubview:snipImageView];
    _snipImageV = snipImageView;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 410, 200, 200)];
    imageV.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:imageV];
    _imageV = imageV;
}

-(BOOL)shouldHideKeyboardWhenTouchInView:(UIView *)view {
    return YES;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return scrollView.subviews.firstObject;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [scrollView flashScrollIndicators];
    NSLog(@"scrollViewDidZoom-%f",scrollView.zoomScale);
}

-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    
    NSLog(@"scrollViewWillBeginZooming");
}



-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _imgV.frame =  CGRectMake(10, 210, self.view.frame.size.width - 20, 400);
//    _imgV.viewportRect = CGRectMake(0, 0, 100, 100);
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
    NSLog(@"左边点击-%@",NSStringFromCGRect(CGRectApplyAffineTransform(_imgV.frame, CGAffineTransformMakeScale(0.5, 0.5))));
    
    UIImage *image = [_snipImageV snipCircleImageBoardWidth:3.f boardColor:[UIColor whiteColor]];
    
    _imageV.frame = CGRectMake(100, 410, image.size.width,image.size.height);
    _imageV.image = image;
//        ModalViewController *modal = [ModalViewController new];
//        [self.navigationController pushViewController:modal animated:YES];

//    [_assetGroup enumerateAssetsWithOptions:QMUIAlbumSortTypeReverse usingBlock:^(QMUIAsset *resultAsset) {
//        [resultAsset requestOriginImageWithCompletion:^(UIImage *result, NSDictionary<NSString *,id> *info) {
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                self->_imgV.image = result;
//                [self->_imgV hideEmptyView];
//            }];
//            return;
//        } withProgressHandler:^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
//
//        }];
//
//    }];
    
//    QMViewController *qm_vc = [QMViewController new];
//    [self.navigationController pushViewController:qm_vc animated:YES];
   
    
}

-(QMUIImagePickerViewController *)imagePickerViewControllerForAlbumViewController:(QMUIAlbumViewController *)albumViewController {
    QMUIImagePickerViewController *pickerV = [[QMUIImagePickerViewController alloc] init];
    
    pickerV.imagePickerViewControllerDelegate = self;
    
    pickerV.allowsMultipleSelection = YES;
//    pickerV.maximumSelectImageCount = 1;
    
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





-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
  
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}


@end

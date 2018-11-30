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
#import <libkern/OSAtomic.h>
#import "CJCalendarViewController.h"
#import <SafariServices/SafariServices.h>
#import "MultitudeDelegateViewController.h"


@interface ViewController ()<QMUIImagePreviewViewDelegate,UIScrollViewDelegate,QMUIAlbumViewControllerDelegate,QMUIImagePickerViewControllerDelegate, NSURLSessionDelegate> {
    NSMutableArray *_imagesAry;
    QMUIImagePreviewViewController *_previewVC;
    QMUIAssetsGroup *_assetGroup;
    QMUIZoomImageView *_imgV;
    
    CJSnipImageView *_snipImageV;

    UIBarButtonItem *_barButtonItem;
    UINavigationItem *_item1;
    CGFloat _alpha;
    
    
   
    
}


@property(nonatomic, weak) YYAnimatedImageView *yy_imageV;


@property(nonatomic, strong) NSMutableArray *mAry;

// handle weak obj
@property(nonatomic, strong) NSPointerArray *pointAry;
@property(nonatomic, strong) NSHashTable *hashTable;
@property(nonatomic, strong) NSMapTable *mapTable;


@property(nonatomic, strong) UIWindow *windo;

@property(nonatomic, strong) QMUIModalPresentationViewController *presentation;


@end

@implementation ViewController {
    QMUIEmotionInputManager *_manager;

    YYMemoryCache *_mCache;
    YYDiskCache *_disCache;
    YYCache *_yy_cache;
    NSHashTable *_hashTable;
    NSMapTable *_mapTable;
    UIViewPropertyAnimator *_propertyAnimator;
}

-(void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
   

 

    
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
    

    
    NSLog(@"%@",NSHomeDirectory());

 

    
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"DefaultLS@3x.png" ofType:@""];
//
//    NSData *data = [NSData dataWithContentsOfFile:path];
//
//    UIImage *img = [UIImage imageWithData:data];
    UIImage *img = [UIImage imageNamed:@"DefaultLS"];
    
    // 获取原始数据。10969344 远大于419168压缩后的图片。所以图片显示必须要解码。
    CFDataRef dataRef = CGDataProviderCopyData(CGImageGetDataProvider(img.CGImage));
    CFIndex bufferLength = CFDataGetLength(dataRef);
    NSData *rawData = CFBridgingRelease(dataRef);
    NSLog(@"%ld-%lu",(long)bufferLength,(unsigned long)rawData.length);
    
    CGImageRef imgRef = img.CGImage;
    NSLog(@"%@",imgRef);
    
    
    
    
    UIImage *maskImg = [UIImage imageNamed:@"image1"];
    CGImageRef maksImgRef = maskImg.CGImage;
    CGImageRef imgRef1 = CGImageMaskCreate(CGImageGetWidth(maksImgRef),
                                           CGImageGetHeight(maksImgRef),
                                           CGImageGetBitsPerComponent(maksImgRef),
                                           CGImageGetBitsPerPixel(maksImgRef),
                                           CGImageGetBytesPerRow(maksImgRef),
                                           CGImageGetDataProvider(maksImgRef),
                                           CGImageGetDecode(maksImgRef),
                                           CGImageGetShouldInterpolate(maksImgRef));
    CGImageRef newImgRef = CGImageCreateWithMask(imgRef, imgRef1);
    
    UIImage *newImage = [UIImage imageWithCGImage:newImgRef];
    
    
    UIImage *decodeImage = [[UIImage imageNamed:@"DefaultLS"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    
//    CGImageRef rref = CGImageCreateWithJPEGDataProvider(CGImageGetDataProvider(maskImg.CGImage), CGImageGetDecode(maskImg.CGImage), CGImageGetShouldInterpolate(maskImg.CGImage),CGImageGetRenderingIntent(maskImg.CGImage));
    
    
 
    YYAnimatedImageView *imgV = [[YYAnimatedImageView alloc] initWithImage:decodeImage];
    imgV.tintColor = [UIColor purpleColor];
    [self.view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(120);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    _yy_imageV = imgV;
    
    
 
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
 
    NSString *allPath = [path stringByAppendingPathComponent:@"MyCache"];
    YYCache *cahe = [[YYCache alloc] initWithPath:allPath];
 
    
    [cahe setObject:decodeImage forKey:@"image"];
    NSLog(@"%@-%@-%@",cahe,cahe.diskCache,cahe.memoryCache);

    QMUIGhostButton *fillBtn = [[QMUIGhostButton alloc] init];
    [fillBtn setTitleColor:QMUICMI.buttonTintColor  forState:UIControlStateNormal];
    fillBtn.layer.borderColor = QMUICMI.buttonTintColor.CGColor;
    [fillBtn setTitle:@"fillBtn" forState:UIControlStateNormal];
    
    [self.view addSubview:fillBtn];
    [fillBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgV);
        make.top.equalTo(imgV.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    self.mAry = [NSMutableArray array];
    self.pointAry = [NSPointerArray weakObjectsPointerArray];
    self.hashTable = [NSHashTable weakObjectsHashTable];
    self.mapTable = [NSMapTable strongToStrongObjectsMapTable];
    
    
    objc_property_t property_t = class_getProperty([self class], "view");
    NSLog(@"%s",property_getName(property_t));

    
    
}



-(void)initSubviews {
    [super initSubviews];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem qmui_closeItemWithTarget:self action:@selector(leftItemClick:)];
    QMUINavigationTitleView *titleV = self.titleView;
    titleV.needsLoadingView = YES;
    titleV.loadingViewHidden = NO;
    titleV.userInteractionEnabled = YES;
    titleV.title = @"nTitleView";
    titleV.accessoryType = QMUINavigationTitleViewAccessoryTypeDisclosureIndicator;
 
}



-(void)didReceiveMemoryWarning {
    NSLog(@"didReceiveMemoryWarning");
}


// 到收到服务器响应为401
-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
 
    
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

}



-(void)leftItemClick:(UIBarButtonItem *)item {

    
    MultitudeDelegateViewController *multitudeVc = [[MultitudeDelegateViewController alloc] init];

    [self.navigationController pushViewController:multitudeVc animated:YES];
    
//    CJCalendarViewController *calendarVc = [[CJCalendarViewController alloc] init];
//    [self.navigationController pushViewController:calendarVc


    //CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)@"UISimulatedMemoryWarningNotification", NULL, NULL, true);

    
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
//
//    [self.navigationController pushViewController:transV animated:YES];

    
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

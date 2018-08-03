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

  
//    unsigned int outCount = 0;
//    Ivar *ivars = class_copyIvarList(NSClassFromString(@"UITableView"), &outCount);
//    for (int i = 0; i < outCount; i++) {
//        Ivar ivar = ivars[i];
//        const char *ivar_name = ivar_getName(ivar);
//        NSString *ivarName = [NSString stringWithUTF8String:ivar_name];
//        NSLog(@"%@",ivarName);
//    }


    
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
    

    CJBarbuttonItem *ite = [CJBarbuttonItem layer];
    
    ite.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.85].CGColor;
    ite.frame = CGRectMake(10, 64, 100, 100);
    [self.view.layer addSublayer:ite];
    

    
    
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarContentView")]) {
            NSLog(@"%@",view.subviews);
        }
    }
    
    UINavigationItem *item1 = [[UINavigationItem alloc] initWithTitle:@"naviagtionItem"];
    item1.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
    _item1 = item1;
    
//    self.navigationItem.title = @"title";
//    UILabel *titleLab = [[UILabel alloc] init];
//    titleLab.text = @"titleLab";
//    titleLab.backgroundColor = [UIColor cyanColor];
//    [titleLab sizeToFit];
    self.navigationItem.titleView = titleLab;
    
    [[UINavigationBar cj_ivarNames] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    

   
    
    self.navigationItem.title = @"firsTitle";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage qmui_imageWithColor:[UIColor cyanColor]] forBarMetrics:UIBarMetricsDefault];
    
    // http://aixue.whrhkj.com/mobile/cityTree

    self.navigationController.tabBarItem.badgeValue = @"2";
    
    self.navigationController.tabBarController.tabBar.backgroundColor = [UIColor purpleColor];
    
    NSLog(@"%@",NSHomeDirectory());
    

    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //config.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;
    
    config.timeoutIntervalForRequest = 2;
    config.allowsCellularAccess = YES;
    config.HTTPAdditionalHeaders = @{};
    
    
    _urlSession = [NSURLSession sessionWithConfiguration:config];
    
   
    

    CJRateView *rateView = [[CJRateView alloc] initWithFrame:CGRectMake(100, 450, 0, 0)];

    rateView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:rateView];

    [rateView addTarget:self action:@selector(rateChange:) forControlEvents:UIControlEventValueChanged];
    
    _rateView = rateView;

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
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            view.backgroundColor = [UIColor purpleColor];
        }
    }
   
    
    
//    QMViewController *qm_vc = [[QMViewController alloc] init];
//
//    [self.navigationController pushViewController:qm_vc animated:YES];



//    self.navigationController.navigationBar.alpha = alpha;
//      [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor cyanColor] colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.barTintColor = [UIColor purpleColor];
  
//    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor magentaColor]]];
//    self.navigationController.navigationBar.backgroundColor = [UIColor purpleColor];

    
    
//    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *cookie in storage.cookies) {
//        NSLog(@"%@-%@-%@",cookie.expiresDate,cookie.value,cookie.name);
//    }

    
    
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
    

    ModalViewController *modal = [ModalViewController new];

    [self.navigationController pushViewController:modal animated:YES];

//    UIWindowModalViewController *windoModal = [[UIWindowModalViewController alloc] init];
//
//    QMUIModalPresentationViewController *presentation = [[QMUIModalPresentationViewController alloc] init];
//    presentation.contentViewController = windoModal;
//    presentation.animationStyle = QMUIModalPresentationAnimationStyleSlide;
//    [presentation showWithAnimated:YES completion:^(BOOL finished) {
//
//    }];
    
//    _windo = [[UIWindow alloc] initWithFrame:self.view.bounds];
//    _windo.rootViewController = windoModal;
//    _windo.hidden = NO;
    
    
//    QMViewController *qm_vc = [[QMViewController alloc] init];
//
//    [self.navigationController pushViewController:qm_vc animated:YES];
 
   // [self.navigationController setViewControllers:@[modal,qm_vc] animated:NO];
    
//    //http://blog.cnrainbird.com
//    //http://aixue.whrhkj.com/app/index/appcheck
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//
//    //request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
//    request.timeoutInterval = 5;
//    //request.HTTPMethod = @"POST";
//
//    NSURLCache *cache = [NSURLCache sharedURLCache];
//
//    NSCachedURLResponse *cacheResponse = [cache cachedResponseForRequest:request];
//    if (cacheResponse) {
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)cacheResponse.response;
//        NSLog(@"%@",httpResponse.allHeaderFields);
//        NSLog(@"cacheData----%@",[NSJSONSerialization JSONObjectWithData:cacheResponse.data options:kNilOptions error:nil]);
//    }
//
//    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
 
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



@end

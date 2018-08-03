//
//  QMViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/7/5.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "QMViewController.h"
#import <QMUIKit.h>
#import "CJSnipImageView.h"
#import "ModalViewController.h"
#import "CJScanQRCodeManager.h"
#import <WebKit/WebKit.h>

@interface QMViewController ()<QMUIImagePreviewViewDelegate>

@property(nonatomic, strong) CJScanQRCodeManager *manager;

@property(nonatomic, strong) NSMutableArray *mAry;
@end

@implementation QMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];

//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//    WKWebView *webV = [[WKWebView alloc] initWithFrame:self.view.bounds];
//    [webV loadRequest:[NSURLRequest requestWithURL:url]];
//
//    [self.view addSubview:webV];
    
    QMUIImagePreviewView *preview = [[QMUIImagePreviewView alloc] init];
    preview.backgroundColor = [UIColor purpleColor];
    preview.frame = self.view.bounds;
    preview.delegate = self;
    [self.view addSubview:preview];
    
    NSMutableArray *mAry = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d",i]];
        [mAry addObject:image];
    }

    _mAry = mAry;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(NSUInteger)numberOfImagesInImagePreviewView:(QMUIImagePreviewView *)imagePreviewView {
    return self.mAry.count;
}

-(void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView renderZoomImageView:(QMUIZoomImageView *)zoomImageView atIndex:(NSUInteger)index {
    zoomImageView.image = self.mAry[index];
   
    NSLog(@"%@-%zd",zoomImageView,index);
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_manager setVideoZoomFactor:2];
}

@end

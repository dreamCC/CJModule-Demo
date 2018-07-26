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

@interface QMViewController ()<CJScanQRCodeManagerDelegate>

@property(nonatomic, strong) CJScanQRCodeManager *manager;

@end

@implementation QMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
 
    CJScanQRCodeView *scanView = [[CJScanQRCodeView alloc] initWithFrame:self.view.bounds];
    
 
    if ([CJScanQRCodeManager cameraAuthorizeStatus] == CJAuthorizationStatusAuthorized) {
        CJScanQRCodeManager *manger = [CJScanQRCodeManager defaultManager];
        [manger setupScanQRCodeManagerWithSessionPreset:nil metadataObjectTypes:nil previewView:self.view scanView:scanView delegate:self];
        _manager = manger;
    }else {
        [CJScanQRCodeManager requestCameraAuthorizeStatus:^(CJAuthorizationStatus status) {
            if (status) {
                CJScanQRCodeManager *manger = [CJScanQRCodeManager defaultManager];
                [manger setupScanQRCodeManagerWithSessionPreset:nil metadataObjectTypes:nil previewView:self.view scanView:scanView delegate:self];
                self->_manager = manger;
            }else {
                NSLog(@"未授权");
            }
        }];
    }

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
   [_manager startScan];
   
    
}



-(void)scanQRCodeManager:(CJScanQRCodeManager *)scanQRCodeManager didOutputMetadataObject:(AVMetadataMachineReadableCodeObject *)metadataMachineObject {
    NSLog(@"扫描结果----%@",metadataMachineObject);
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_manager setVideoZoomFactor:2];
}

@end

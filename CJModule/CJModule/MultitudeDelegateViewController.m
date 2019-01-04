//
//  MultitudeDelegateViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/11/26.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "MultitudeDelegateViewController.h"
#import <GLKit/GLKit.h>
#import <QMUIKit.h>
#import "CJPasswordTextField.h"
#import "CJThemeManager/CJThemeManager.h"
#import <Masonry.h>
#import <IQKeyboardManager.h>
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <YYKit.h>
#import "CJBaseRequest.h"
#import "CJModalPresentViewController.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MoviePlayerViewController.h"
#import "DefineTransformViewController.h"


@interface CJRefreshHeader : MJRefreshNormalHeader


@end

@implementation CJRefreshHeader {
    __weak UIImageView *_imageV;
}

-(void)prepare {
    [super prepare];
    UIImage *img = [UIImage imageNamed:@"image0"];
    UIImage *newImg = [img qmui_imageResizedInLimitedSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1000)];
    UIImageView *imgv = [[UIImageView alloc] initWithImage:newImg];
    imgv.contentMode = UIViewContentModeBottom;
    [self insertSubview:_imageV = imgv atIndex:0];
}

-(void)placeSubviews {
    [super placeSubviews];
    _imageV.frame = self.bounds;
}

@end


static void *CJObserverContext = &CJObserverContext; // 可以用于监听的observerContext。
@interface MultitudeDelegateViewController ()<UITableViewDelegate,UITableViewDataSource,NSStreamDelegate,UIImagePickerControllerDelegate>

@end

@implementation MultitudeDelegateViewController {
    QMUILabel*_cj_labe;
    UITextField *_textField;
    UITableView *_tableView;
    NSProgress *_progress;
    
    NSInputStream *_inputStream;
    NSOutputStream *_outputStream;
    UIImageView *_imgV;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    UITableView *tablV = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 200) style:UITableViewStyleGrouped];
    
    tablV.backgroundColor = [UIColor qmui_randomColor];
    tablV.delegate = self;
    tablV.dataSource = self;
    tablV.tableFooterView = [UIView new];
    tablV.sectionHeaderHeight = 40.1f;
    tablV.sectionFooterHeight = 0.1f;
    tablV.estimatedRowHeight = 0.f;
    tablV.estimatedSectionFooterHeight = 0.f;
    tablV.estimatedSectionHeaderHeight = 0.f;
    [self.view addSubview:_tableView = tablV];
    [tablV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];

    
    [tablV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.offset(100);
    }];

    CJRefreshHeader *header = [CJRefreshHeader headerWithRefreshingBlock:^{
        NSLog(@"mj_header:开始刷新");
    }];
    header.ignoredScrollViewContentInsetTop = 10;
    header.backgroundColor = [UIColor magentaColor];
    header.automaticallyChangeAlpha = YES;
    tablV.mj_header = header;
    
    
    
    tablV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"mj_footer:开始刷新");
    }];
    
   
}

-(BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return NO;
}


-(UIImage *)navigationBarBackgroundImage {
    return [UIImage qmui_imageWithColor:[UIColor purpleColor]];
}

-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    
    switch (eventCode) {
        case NSStreamEventNone: // 无事件
            NSLog(@"NSStreamEventNone");
            break;
        case NSStreamEventOpenCompleted: // 打开完成
            NSLog(@"NSStreamEventOpenCompleted");
            break;
        case NSStreamEventErrorOccurred: // 出现错误
            NSLog(@"NSStreamEventErrorOccurred:%@",_inputStream.streamError);
            break;
        case NSStreamEventEndEncountered: // 结束
            NSLog(@"NSStreamEventEndEncountered");
            [_inputStream close];
            [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            _inputStream = nil;
            break;
        case NSStreamEventHasBytesAvailable: // 读
        {
            uint8_t readBuffer[1];

            NSInteger readLenth = [_inputStream read:readBuffer maxLength:sizeof(readBuffer)];
            NSLog(@"%zd:%d",readLenth,_inputStream.hasBytesAvailable);
            if (readLenth) {
                NSData *readData = [NSData dataWithBytes:readBuffer length:readLenth];
                NSString *readString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
                NSLog(@"readString:%@",readString);
            }
        }
            
            break;
        case NSStreamEventHasSpaceAvailable: // 写
        {
           
            
        }
            break;
        default:
            break;
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
   
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%zd",section];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.textLabel.text = [NSString stringWithFormat:@"===%zd:%zd",indexPath.section,indexPath.row];
  
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 1) {
#if 1
        NSURL *fileUrl = [[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].firstObject;
        NSURL *destinationUrl = [fileUrl URLByAppendingPathComponent:@"str.txt"];
        _inputStream = [NSInputStream inputStreamWithURL:destinationUrl];
        [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        _inputStream.delegate = self;
        [_inputStream open];
#else
        UIImage *img = [UIImage imageNamed:@"-hot"];
        NSData *data = UIImagePNGRepresentation(img);
        _inputStream = [NSInputStream inputStreamWithData:data];
        [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        _inputStream.delegate = self;
        [_inputStream open];
#endif
        
    }else if (indexPath.row == 2) {
        NSString *str = @"hello,world!";
        NSURL *fileUrl = [[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].firstObject;
        NSURL *destinationUrl = [fileUrl URLByAppendingPathComponent:@"str.txt"];
        [str writeToURL:destinationUrl atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }else if (indexPath.row == 3) {
        NSURL *fileUrl = [[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].firstObject;
        NSURL *destinationUrl = [fileUrl URLByAppendingPathComponent:@"str.txt"];
        _outputStream = [NSOutputStream outputStreamWithURL:destinationUrl append:YES];
        [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        _outputStream.delegate = self;
        [_outputStream open];
    }else if (indexPath.row == 4) {
        NSString *writeStirng = @"NSStreamEventHasSpaceAvailable";
        NSData *writeData = [writeStirng dataUsingEncoding:NSUTF8StringEncoding];
        [_outputStream write:writeData.bytes maxLength:writeData.length];
    }else if (indexPath.row == 5) {
        QMUIModalPresentationViewController *modalPresentV = [[QMUIModalPresentationViewController alloc] init];
        modalPresentV.contentViewController = [[CJModalPresentViewController alloc] init];
        modalPresentV.contentViewMargins = UIEdgeInsetsZero;
        [self presentViewController:modalPresentV animated:NO completion:nil];
        
    }else if (indexPath.row == 6) {
         
        MoviePlayerViewController *mp = [[MoviePlayerViewController alloc] init];
        
        [self.navigationController pushViewController:mp animated:YES];
        
    }else if (indexPath.row == 7) {
        
        DefineTransformViewController *defineVc = [[DefineTransformViewController alloc] init];
        
        defineVc.modalPresentationStyle = UIModalPresentationCustom;

        [self presentViewController:defineVc animated:YES completion:nil];
        
        
    }
}


-(void)dealloc {
    NSLog(@"dealloc");
}





@end

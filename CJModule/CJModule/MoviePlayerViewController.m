//
//  MoviePlayerViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/12/25.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "MoviePlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

@interface MoviePlayerViewController ()

@property(nonatomic,strong) MPMoviePlayerController *mpvc;
@property(nonatomic, strong) AVPlayer *av_player;
@property(nonatomic, strong) AVAudioPlayer *audio_player;
@end

@implementation MoviePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    BOOL isSucess = [session setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionAllowBluetooth error:nil];
//    if (isSucess) {
//        NSLog(@"AVAudioSessionCategoryPlayback set success");
//    }else {
//        NSLog(@"AVAudioSessionCategoryPlayback set fail");
//    }
//    [session setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
//
//    NSLog(@"AVAudioSessionCategor:%@",[AVAudioSession sharedInstance].category);
//    NSLog(@"AVAudioSessionCategoyOptions:%lu",(unsigned long)[AVAudioSession sharedInstance].categoryOptions);
    
    
    // 被电话打断。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionInterrruption:) name:AVAudioSessionInterruptionNotification object:nil];
    // 耳机的插入和拔出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionRouteChange:) name:AVAudioSessionRouteChangeNotification object:nil];
    // AVAudioSession 被其它app进行了修改。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionSilenceSecondaryAudioHint:) name:AVAudioSessionSilenceSecondaryAudioHintNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];

}

-(void)audioSessionInterrruption:(NSNotification *)notify {
    NSLog(@"audioSessionInterrruption:%@",notify);
    
}

-(void)audioSessionRouteChange:(NSNotification *)notify {
    NSLog(@"audioSessionRouteChange:%@",notify);
   
}

-(void)audioSessionSilenceSecondaryAudioHint:(NSNotification *)notify {
    NSLog(@"audioSessionSilenceSecondaryAudioHint:%@",notify);
    
    if ([notify.userInfo[AVAudioSessionSilenceSecondaryAudioHintTypeKey] integerValue]) {
        // 被其它app占用。
    }else {
        // 其它app占用完成。
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryAmbient withOptions:kNilOptions error:nil];
        [session setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    }
    
}


//网络视频地址 http://baobab.wdjcdn.com/14525705791193.mp4

//MPMoviePlayerController 在ios 9之后不建议使用，建议使用AVPlayerViewController。而且只能基于contentUrl
-(void)initializeMoviePlayer {
    
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"不能说的秘密" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:moviePath];
    
    NSURL *urlString = [NSURL URLWithString:@"http://data.vod.itc.cn/?rb=1&key=jbZhEJhlqlUN-Wj_HEI8BjaVqKNFvDrn&prod=flash&pt=1&new=/137/113/vITnGttPQmaeWrZ3mg1j9H.mp4"];
    MPMoviePlayerController *mpvc = [[MPMoviePlayerController alloc] initWithContentURL:urlString];
    mpvc.view.frame = CGRectMake(0, 200, CGRectGetWidth(self.view.frame), 400);
    mpvc.backgroundView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:mpvc.view];
    [mpvc prepareToPlay];
    self.mpvc = mpvc;
}

// MPMoviewPlayerViewController 在ios 9之后不见已使用。而且只能基于contentUrl 是MPMoviewPlayerController的及你不封装。其效果和上面的一样。
-(void)initializeMoverPlayerVC {
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"不能说的秘密" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:moviePath];
    
    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    
    [self presentViewController:vc animated:YES completion:nil];
}

// AVPlayerViewController是AVKit框架里面的一个播放器。系统播放。而且我们发现AVPlayerViewController的UI和MP的UI是不一样的。而且只能播放本地视频。
// 其展示可以有两种方式，1.直接操作控制器，这个时候不能控制view的大小。2、通过addView的方式，将AVPlayerViewController的viewd添加到view上面。
-(void)initailizalAVPlayerViewController {
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"不能说的秘密" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:moviePath];
    NSURL *urlString = [NSURL URLWithString:@"http://data.vod.itc.cn/?rb=1&key=jbZhEJhlqlUN-Wj_HEI8BjaVqKNFvDrn&prod=flash&pt=1&new=/137/113/vITnGttPQmaeWrZ3mg1j9H.mp4"];

    AVPlayer *player  = [[AVPlayer alloc] initWithURL:urlString];
   
    
    AVPlayerViewController *avplayerVc = [[AVPlayerViewController alloc] init];
    avplayerVc.player = player;
    //[self.navigationController pushViewController:avplayerVc animated:YES];
    avplayerVc.view.frame = CGRectMake(0, 84, CGRectGetWidth(self.view.frame), 300);
    
    [self addChildViewController:avplayerVc];
    [self.view addSubview:avplayerVc.view];

}

//AVPlayer的形式。AVPlayer的形式是可以播放网络视频的。
-(void)initializalAVPlayer {
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"不能说的秘密" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:moviePath];
    NSURL *urlString = [NSURL URLWithString:@"http://data.vod.itc.cn/?rb=1&key=jbZhEJhlqlUN-Wj_HEI8BjaVqKNFvDrn&prod=flash&pt=1&new=/137/113/vITnGttPQmaeWrZ3mg1j9H.mp4"];
    //https://www.bilibili.com/video/av11484157?from=search&seid=18394333363759410543
    //http://data.vod.itc.cn/?rb=1&key=jbZhEJhlqlUN-Wj_HEI8BjaVqKNFvDrn&prod=flash&pt=1&new=/137/113/vITnGttPQmaeWrZ3mg1j9H.mp4
//    AVPlayer *av_player = [[AVPlayer alloc] initWithURL:url];
//
//    [av_player play];
//    self.av_player = av_player;
    
    NSDictionary *optionsDic = @{AVURLAssetPreferPreciseDurationAndTimingKey:@(YES)
                                 };
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:urlString options:optionsDic];
    
    NSArray *keys = @[@"tracks",@"metadata"];
    [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        for (NSString *key in keys) {
            AVKeyValueStatus status = [asset statusOfValueForKey:key error:nil];
            switch (status) {
                case AVKeyValueStatusFailed:
                    NSLog(@"失败");
                    break;
                case AVKeyValueStatusLoaded:
                {
                    NSLog(@"---点击");
                    NSLog(@"---%f",CMTimeGetSeconds(asset.duration));
                    NSLog(@"---%f",asset.preferredVolume);
                    NSLog(@"---%f",asset.preferredRate);
                    
                    NSLog(@"commonMetadata---%@",asset.commonMetadata);
                    
                    NSLog(@"metadata--%@",asset.metadata);
                    
                    // 视频资源中，所包含的元数据格式。
                    // 其中，苹果支持的有三种。 @[AVMetadataFormatQuickTimeMetadata,AVMetadataFormatID3Metadata,AVMetadataFormatiTunesMetadata];
            
                    NSLog(@"availableMetadataFormats--%@",asset.availableMetadataFormats);
                    NSLog(@"---点击");
                }
                    break;
                default:
                    break;
            }
        }
    }];
  
   
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event  {
    [self initializalAVPlayer];
    
}

@end

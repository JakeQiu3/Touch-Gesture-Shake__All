//
//  RemoteControlViewController.m
//  摇晃事件 大全
//
//  Created by 邱少依 on 15/12/29.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "RemoteControlViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface RemoteControlViewController ()
{
    UIButton *_playBtn;
    BOOL _isPlaying;
    AVPlayer *_player;
}
@end

@implementation RemoteControlViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"曲婉婷 - 我的歌声里" ofType:@"mp3"];
    _player = [[AVPlayer alloc]initWithURL:[NSURL fileURLWithPath:filePath]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
    // Do any additional setup after loading the view.
}

- (BOOL)canBecomeFirstResponder {
    return NO;
}
- (void)initLayout {
//    初始化专辑封面
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageV.image = [UIImage imageNamed:@"banner2"];
    imageV.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:imageV];
// 播放控制面板
    UIView *viewV = [[UIView alloc] initWithFrame:CGRectMake(0, 480, [UIScreen mainScreen].bounds.size.width, 80)];
    viewV.backgroundColor = [UIColor lightGrayColor];
    viewV.alpha = 0.9;
    [self.view addSubview:viewV];
    
//   添加播放按钮
    _playBtn = [[UIButton alloc]initWithFrame:CGRectMake(140, 15, 50, 50)];
    _playBtn.backgroundColor = [UIColor redColor];
    [self changeUIState];
    [_playBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewV addSubview:_playBtn];
}
//界面状态改变
- (void)changeUIState {
    if (_isPlaying) {// 播放时显示暂停图标
        [_playBtn setImage:[UIImage imageNamed:@"playing_btn_pause_n.png"] forState:UIControlStateNormal];
         [_playBtn setImage:[UIImage imageNamed:@"playing_btn_pause_h.png"] forState:UIControlStateHighlighted];
    } else {// 显示播放状态图标
        [_playBtn setImage:[UIImage imageNamed:@"playing_btn_play_n.png"] forState:UIControlStateNormal];
        [_playBtn setImage:[UIImage imageNamed:@"playing_btn_play_h.png"] forState:UIControlStateHighlighted];
    }
}

- (void)btnClick:(UIButton *)btn {
    if (_isPlaying) {
        [_player pause];
    } else {
         [_player play];
    }
    _isPlaying = !_isPlaying;//将相反的状态给自己
    [self changeUIState];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//远程控制事件
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    NSLog(@"%i,%i",event.type,event.subtype);
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                NSLog(@"UIEventSubtypeRemoteControlPlay");
                [_player play];
                _isPlaying = YES;
                break;
            case UIEventSubtypeRemoteControlTogglePlayPause:
                NSLog(@"TogglePlayPause");
                if (_isPlaying) {
                    [_player pause];
                } else {
                    [_player play];
                }
                _isPlaying = !_isPlaying;
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"Next...");
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"Previous...");
                break;
            case UIEventSubtypeRemoteControlBeginSeekingForward:
                NSLog(@"Begin seek forward...");
                break;
            case UIEventSubtypeRemoteControlEndSeekingForward:
                NSLog(@"End seek forward...");
                break;
            case UIEventSubtypeRemoteControlBeginSeekingBackward:
                NSLog(@"Begin seek backward...");
                break;
            case UIEventSubtypeRemoteControlEndSeekingBackward:
                NSLog(@"End seek backward...");
                break;
            default:
                break;
        }
        [self changeUIState];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

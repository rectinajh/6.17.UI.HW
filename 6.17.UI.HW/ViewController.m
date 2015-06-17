//
//  ViewController.m
//  6.17.UI.HW
//
//  Created by rimi on 15/6/17.
//  Copyright (c) 2015年 rectinajh. All rights reserved.
//

#import "ViewController.h"
@import AVFoundation;

NSInteger arrayIndex = 0;//定义一个全局变量来表示数组下标

@interface ViewController ()<AVAudioPlayerDelegate>

@property(strong,nonatomic)AVAudioPlayer        *player;
@property(strong,nonatomic)UILabel              *musicCurrentTimeLabel;
@property(strong,nonatomic)UILabel              *musicLastTimeLabel;
@property(strong,nonatomic)UIButton             *musicPlayButton;
@property(strong,nonatomic)NSTimer              *sliderTimer;
@property(strong,nonatomic)NSArray              *array;     //存放歌曲名的数组

- (void)initializeDataSource;
- (void)initializeUserInterface;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initializeUserInterface];
    [self initializeDataSource];
}

- (void)initializeDataSource
{
    NSArray *array = @[@"Deemo Title Song - Website Version", @"Release My Soul",@"Rё.L",@"Wings of piano"];
    NSURL *url = [[NSBundle mainBundle]URLForResource:array[arrayIndex] withExtension:@"mp3"];
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    [self.player prepareToPlay];            // 放入缓存池
    self.player.delegate =self;             // 设置代理
    self.player.volume = 0.1;               // 设置音量(0-1)
    self.player.numberOfLoops = -1;         // 设置循环次数，-1为一直循环（单曲循环）
    self.array = array;                     // 关联数组
    
}

- (void)initializeUserInterface
{
#pragma mark - 歌曲名
    UILabel *musicNameLabel = [[UILabel alloc]init];
    self.MusicName = musicNameLabel;
    [musicNameLabel setTextAlignment:NSTextAlignmentCenter];
    musicNameLabel.text = self.array[arrayIndex];
    [self.view addSubview:musicNameLabel];
    
#pragma mark - 歌曲当前播放时间
    UILabel *musicCurrentTime = [[UILabel alloc]init];
    [self.view addSubview:musicCurrentTime];
    self.musicCurrentTimeLabel = musicCurrentTime;
    
#pragma mark - 歌曲剩余播放时间
    UILabel *musicLastTime = [[UILabel alloc]init];
    [self.view addSubview:musicCurrentTime];
    self.musicLastTimeLabel = musicLastTime;

#pragma mark - 歌曲时间滑条
    UISlider *slider = [[UISlider alloc]init];
    [self.view addSubview:slider];
    [slider setThumbImage:[UIImage imageNamed:@"indicator"] forState:UIControlStateNormal];
    NSTimer *sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
    slider.maximumValue = self.player.duration;
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    self.timeSlider = slider;
    self.sliderTimer = sliderTimer;

#pragma mark - 上一曲按钮
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [self.view addSubview:button1];
    [button1 addTarget:self action:@selector(handleBackMusicButtonEvent:) forControlEvents:UIControlEventTouchUpInside
     ];
    self.lastSong = button1;
    
#pragma mark - 播放安妮
    UIButton *playMusicButton = [[UIButton alloc]init];
    [playMusicButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [playMusicButton addTarget:self action:@selector(handlePlayMusicButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark - 下一曲按钮
    UIButton *nextMusicButton = [[UIButton alloc]init];
    [nextMusicButton setImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [nextMusicButton addTarget:self action:@selector(handleNextMusicButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    
}
//点击播放事件
- (void)handlePlayMusicButtonEvent:(UIButton *)sender
{
    if ([self.player isPlaying]) {
        
        [self.player pause];
        [self.musicPlayButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    } else {
        
        [self.player play];
        [self.musicPlayButton setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    
    }

}

//滑条改变
- (IBAction)sliderChanged:(UISlider *)sender
{
    [_player stop];
    [_player setCurrentTime:_timeSlider.value];
    [_player prepareToPlay];
    [_player play];

}

//音乐播放完毕调用方法,循环播放不会调用
- (void)andioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{

    if (flag) {
        //清空时间
        [self.sliderTimer invalidate];
    }
}

//更新播放进度
- (void)updateSlider
{
    self.timeSlider.value = self.player.currentTime;
    _musicCurrentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)_player.currentTime / 60, (int)_player.currentTime % 60];
    _musicLastTimeLabel.text = [NSString stringWithFormat:@"-%02d:%02d",(int)(_player.duration - (int)_player.currentTime) / 60, (int)(_player.duration - (int)_player.currentTime) % 60];
    
    
}
//点击上一曲按钮事件
- (void)handleBackMusicButtonEvent:(UIButton *)sender
{
    arrayIndex --;
    if (arrayIndex == -1) {
        arrayIndex = 3;
    }
    [self initializeDataSource];
    [_player play];
    _MusicName.text = _array[arrayIndex];
}


//点击下一曲按钮
- (void)handleNextMusicButtonEvent:(UIButton *)sender
{
    arrayIndex ++;
    if (arrayIndex == 4) {
        arrayIndex = 0;
    }
    
    [self initializeDataSource];
    [_player play];
    _MusicName.text = _array[arrayIndex];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

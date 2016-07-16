//
//  MGViewController.m
//  QQMusic
//
//  Created by 殿阁刘 on 16/7/7.
//  Copyright © 2016年 殿阁刘. All rights reserved.
//

#import "MGViewController.h"
#import "MGMusicTool.h"
#import "MGAudioTool.h"
#import "MGMusic.h"
#import "NSString+MGCategory.h"
#import "CALayer+PauseAimate.h"
#import "MGLrcScrollerView.h"
#define BaseAnimationKey @"baseAnimation"
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MGViewController ()<UIScrollViewDelegate>
//相关的成员变量
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
//顶部view
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *topLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *topRightButton;
@property (weak, nonatomic) IBOutlet UILabel *songLable;
@property (weak, nonatomic) IBOutlet UILabel *singerLable;
//底部的view
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *currentLable;
@property (weak, nonatomic) IBOutlet UILabel *durationLable;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseButton;
//icon和歌词view
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *bottomSongLable;
//播放器
@property (strong, nonatomic) AVAudioPlayer*  audioPlayer;
//其它的相关的声明
@property (strong, nonatomic) NSTimer* timer;
//歌词相关
@property (weak, nonatomic) IBOutlet MGLrcScrollerView *lrcScrollerView;






@end
@implementation MGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置scrollerview的相关的属性
    [self setScrollerView];
    // 播放音乐
    [self startPlayMusic];
 
}
/**
 *  设置scrollerview的相关的属性
 */
-(void)setScrollerView
{
    self.lrcScrollerView.contentSize = CGSizeMake(ScreenWidth*2.0, 0);
    self.lrcScrollerView.pagingEnabled = YES;
}
-(void)awakeFromNib
{
    //添加毛玻璃的效果
    UIToolbar* toolBar = [[UIToolbar alloc]initWithFrame:self.view.bounds];
    [toolBar setBarStyle:UIBarStyleBlack];
    [self.backImageView addSubview:toolBar];
    //设置进度条的样式
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    //变换iconview的样式
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.width*0.5;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconImageView.layer.borderWidth = 8.0;
    
}
#pragma mark - sliderde事件的响应
/**
 *开始事件，就是touchdown
 */
- (IBAction)startSlider:(UISlider *)sender {
    [self removeTimer];
}
/**
 *  状态改变 也就是valuechange的时候
 */
- (IBAction)changedSlider:(UISlider *)sender {
    self.currentLable.text = [NSString stringWithTime:sender.value*self.audioPlayer.duration];
}
/**
 *  结束  就是touch up inside
 */
- (IBAction)endSlider:(UISlider *)sender {
    //从什么时刻开始播放
    self.audioPlayer.currentTime = sender.value*self.audioPlayer.duration;
    self.currentLable.text = [NSString stringWithTime:sender.value*self.audioPlayer.duration];
    [self addTimerObserve];
}
#pragma mark - 手势监听
- (IBAction)clickAction:(UITapGestureRecognizer *)sender {
   CGPoint tapPoint = [sender locationInView:sender.view];
   CGFloat offsetTap = tapPoint.x/self.progressSlider.bounds.size.width;
   self.currentLable.text = [NSString stringWithTime:offsetTap*self.audioPlayer.duration];
   self.audioPlayer.currentTime = offsetTap*self.audioPlayer.duration;
}
#pragma  mark － 其他事件的响应
/**
 *  播放音乐
 */
-(void)startPlayMusic
{
    
    //播放音乐
    MGMusic* musicModel = [MGMusicTool playingMusic];
    self.audioPlayer =  [MGAudioTool playMusicWithName:musicModel.filename];
    //界面修改的其他的信息
    [self changedtherUI:musicModel];
    //先调用一下界面的修改的信息
    [self changedUI];
    //设置界面的相关的属性
    [self setUpAttributes:self.audioPlayer];
    //设置歌词
    self.lrcScrollerView.lrcName = musicModel.lrcname;
    //开始动画
    [self startAnimation];
}
/**
 *  界面修改的其他的信息
 */
-(void)changedtherUI:(MGMusic*)musicModel
{
    self.backImageView.image = [UIImage imageNamed:musicModel.singerIcon];
    self.iconImageView.image = [UIImage imageNamed:musicModel.icon];
    self.songLable.text = musicModel.name;
    self.singerLable.text = musicModel.singer;
    
}
/**
 *  设置界面的相关的属性
 */
-(void)setUpAttributes:(AVAudioPlayer*)player
{
    self.currentLable.text = [NSString stringWithTime:player.currentTime];
    self.durationLable.text =[NSString stringWithTime:player.duration];
    //添加事件观察
    [self addTimerObserve];
    
}
/**
 *  添加事件观察
 */
-(void)addTimerObserve
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changedUI) userInfo:nil repeats:YES];
}
-(void)removeTimer
{
   [self.timer invalidate];
    
}
/**
 *  修改ui
 */
-(void)changedUI
{
    self.currentLable.text = [NSString stringWithTime:self.audioPlayer.currentTime];
    self.durationLable.text = [NSString stringWithTime:self.audioPlayer.duration];
    CGFloat offsetPoint = self.audioPlayer.currentTime/self.audioPlayer.duration;
    self.progressSlider.value = offsetPoint;
    self.playOrPauseButton.selected = self.audioPlayer.isPlaying;
    
}
/**
 *  开始动画
 */
-(void)startAnimation
{
    CABasicAnimation* baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置属性
    baseAnimation.fromValue = @(0);
    baseAnimation.delegate = self;
    baseAnimation.toValue = @(M_PI*2);
    baseAnimation.repeatCount = NSIntegerMax;
    baseAnimation.duration = 30.0;
    [self.iconImageView.layer addAnimation:baseAnimation forKey:BaseAnimationKey];
}
/**
 *  添加时间观察者
 */
//-(void)setAudioPlayer:(AVAudioPlayer *)audioPlayer
//{
////    [_audioPlayer removeObserver:self forKeyPath:@"currentTime"];
////    [_audioPlayer removeObserver:self forKeyPath:@"duration"];
//    _audioPlayer = audioPlayer;
//    [_audioPlayer addObserver:self forKeyPath:@"currentTime" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void * _Nullable)(self.audioPlayer)];
//    [_audioPlayer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void * _Nullable)(self.audioPlayer)];
//  
//}
/**
 *  观察者
 */
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"currentTime"]) {
//        NSLog(@"%@",change);
//    }else if ([keyPath isEqualToString:@"duration"])
//    {
//    
//    }
//}

/**
 *  停止动画
 */
-(void)stopAnimation
{
    [self.iconImageView.layer removeAnimationForKey:BaseAnimationKey];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 播放 暂停 上一首 下一首 
- (IBAction)playOrPauseAction:(UIButton *)sender {
    self.playOrPauseButton.selected = !self.playOrPauseButton.selected;
    if (self.audioPlayer.playing) {
        [self.audioPlayer pause];
        [self.iconImageView.layer pauseAnimate];
        [self removeTimer];
    }else
    {
       [self.audioPlayer play];
       [self addTimerObserve];
       [self.iconImageView.layer resumeAnimate];
    }
}
- (IBAction)previousAction:(id)sender {
  
    MGMusic* musicModel = [MGMusicTool previousMusic];
    [self playingMusicWith:musicModel];
    
}
- (IBAction)nextAction:(id)sender {
    MGMusic* musicModel = [MGMusicTool nextMusic];
    [self playingMusicWith:musicModel];

}
-(void)playingMusicWith:(MGMusic*)music
{
    [self removeTimer];
    [MGAudioTool playMusicWithName:music.filename];
    [MGMusicTool setPlayingMusic:music];
    [self startPlayMusic];

}
#pragma mark - scrollerView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    CGFloat ratro = 1 - point.x/ScreenWidth;
    self.iconImageView.alpha = ratro;
    self.bottomSongLable.alpha = ratro;
}





@end

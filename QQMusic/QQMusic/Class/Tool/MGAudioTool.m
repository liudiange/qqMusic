//
//  MGAudioTool.m
//  QQMusic
//
//  Created by 殿阁刘 on 16/7/8.
//  Copyright © 2016年 殿阁刘. All rights reserved.
//

#import "MGAudioTool.h"

@implementation MGAudioTool

static AVAudioPlayer* _audioPlayer;
static NSMutableDictionary* _musics;


+(void)initialize
{
    _musics = [NSMutableDictionary dictionary];

}
+(AVAudioPlayer*)playMusicWithName:(NSString*)musicName
{
    if (_audioPlayer) {
        _audioPlayer = nil;
    }
    if (musicName == nil) return nil;
     NSURL* url =  _musics[musicName];
    if (url == nil) {
        url = [[NSBundle mainBundle]URLForResource:musicName withExtension:nil];
        [_musics setObject:url forKey:musicName];
    }
    _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    [_audioPlayer play];
    return _audioPlayer;
}
//暂停歌曲
+(void)pause
{
    [_audioPlayer pause];
}
//停止播放
+(void)stop
{
    [_audioPlayer stop];
    _audioPlayer = nil;
}


@end

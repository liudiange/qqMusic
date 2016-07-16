//
//  MGMusicTool.m
//  QQMusic
//
//  Created by 殿阁刘 on 16/7/8.
//  Copyright © 2016年 殿阁刘. All rights reserved.
//

#import "MGMusicTool.h"
#import "MJExtension.h"


@implementation MGMusicTool

static  NSMutableArray* _musics;
static  MGMusic * _playingMusic;

+(void)initialize
{
    if (_musics == nil) {
        _musics = [MGMusic objectArrayWithFilename:@"Musics.plist"];
    }
    if (_playingMusic == nil) {
        _playingMusic = _musics[0];
    }
}
//返回所有的音乐
+(NSArray*)Music
{
    return _musics;
}
//返回当前正在播放的音乐
+(MGMusic*)playingMusic
{
    return _playingMusic;
}
//设置当前播放的音乐
+(void)setPlayingMusic:(MGMusic*)music
{
    _playingMusic = music;
}
//播放下一首音乐
+(MGMusic*)nextMusic
{
    NSUInteger index = [_musics indexOfObject:_playingMusic];
    MGMusic* nextMusic = nil;
    if (index == _musics.count - 1) {
         nextMusic = _musics[0];
    }else
    {
     nextMusic = _musics[(index + 1)];
    }
    return nextMusic;
}
//播放上一首音乐
+(MGMusic*)previousMusic
{
    NSUInteger index = [_musics indexOfObject:_playingMusic];
     MGMusic* nextMusic = nil;
    if (index == 0) {
        nextMusic = _musics[(_musics.count - 1)];
    }
    else
    {
      nextMusic = _musics[(index - 1)];
    }
    return nextMusic;
}
















@end

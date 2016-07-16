//
//  MGMusicTool.h
//  QQMusic
//
//  Created by 殿阁刘 on 16/7/8.
//  Copyright © 2016年 殿阁刘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGMusic.h"
@interface MGMusicTool : NSObject

//返回所有的音乐
+(NSArray*)Music;
//返回当前正在播放的音乐
+(MGMusic*)playingMusic;
//设置当前播放的音乐
+(void)setPlayingMusic:(MGMusic*)music;
//播放下一首音乐
+(MGMusic*)nextMusic;
//播放上一首音乐
+(MGMusic*)previousMusic;

@end

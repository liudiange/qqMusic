//
//  MGAudioTool.h
//  QQMusic
//
//  Created by 殿阁刘 on 16/7/8.
//  Copyright © 2016年 殿阁刘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface MGAudioTool : NSObject

//传递一个名字 开始播放歌曲
+(AVAudioPlayer*)playMusicWithName:(NSString*)musicName;
//暂停歌曲
+(void)pause;
//停止播放
+(void)stop;


@end

//
//  MGLrcModel.h
//  QQMusic
//
//  Created by 刘殿阁 on 16/7/10.
//  Copyright © 2016年 殿阁刘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGLrcModel : NSObject

//歌词
@property (copy, nonatomic) NSString* text;
//时间
@property (assign, nonatomic) NSTimeInterval lrcTime;

- (instancetype)initWithLrcName:(NSString*)lrcName;

+ (instancetype)lrcWithLrcName:(NSString*)lrcName;

@end

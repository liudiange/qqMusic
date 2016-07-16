//
//  MGLrcModel.m
//  QQMusic
//
//  Created by 刘殿阁 on 16/7/10.
//  Copyright © 2016年 殿阁刘. All rights reserved.
//

#import "MGLrcModel.h"


@implementation MGLrcModel

- (instancetype)initWithLrcName:(NSString*)lrcName
{
    if (self == [super init]) {
      //[00:29.00]仍然听见小提琴如泣似诉再挑逗
        NSArray* lrcArray = [lrcName componentsSeparatedByString:@"]"];
        self.text = [lrcArray lastObject];
        NSString* timeString = [lrcArray firstObject];
        self.lrcTime = [self lrcTimeWithString:[[timeString componentsSeparatedByString:@"["]lastObject]];
    }
    return self;
}

+ (instancetype)lrcWithLrcName:(NSString*)lrcName
{
    return [[self alloc] initWithLrcName:lrcName];
}
#pragma mark - 计算时间的方法
-(NSTimeInterval)lrcTimeWithString:(NSString*)timeString
{
    //00:29.00
    NSInteger min = [[[timeString componentsSeparatedByString:@":"] firstObject] integerValue];
    NSString* lastString = [[timeString componentsSeparatedByString:@":"] lastObject];
    NSInteger second = [[[lastString componentsSeparatedByString:@"."] firstObject] integerValue];
    NSInteger haoMiao =  [[[lastString componentsSeparatedByString:@"."] lastObject] integerValue];
    return (min*60 + second + haoMiao*0.01);
}

@end

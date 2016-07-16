//
//  NSString+MGCategory.m
//  QQMusic
//
//  Created by 刘殿阁 on 16/7/8.
//  Copyright © 2016年 殿阁刘. All rights reserved.
//

#import "NSString+MGCategory.h"

@implementation NSString (MGCategory)
+(NSString*)stringWithTime:(NSTimeInterval)time
{
    NSInteger minute = (NSInteger)time/60;
    NSInteger second = (NSInteger)time%60;
    NSString* text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    return text;
}
@end

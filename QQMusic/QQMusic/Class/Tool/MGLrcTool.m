//
//  MGLrcTool.m
//  QQMusic
//
//  Created by 刘殿阁 on 16/7/10.
//  Copyright © 2016年 殿阁刘. All rights reserved.
//

#import "MGLrcTool.h"
#import "MGLrcModel.h"

@implementation MGLrcTool
+(NSArray*)lrcWithName:(NSString*)lrcName
{
    //获得路径
    NSString* pathString = [[NSBundle mainBundle]pathForResource:lrcName ofType:nil];
    //获得歌词的string
    NSString* lrcString = [NSString stringWithContentsOfFile:pathString encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray* tmpArray = [NSMutableArray array];
    //截取字符串
    NSArray* lrcTmpArray = [lrcString componentsSeparatedByString:@"\n"];
    for (NSString* sonString in lrcTmpArray) {
        //去掉不符合规矩的数组
        if ([sonString hasPrefix:@"[ti:"]||[sonString hasPrefix:@"[ar:"]||[sonString hasPrefix:@"[al:"]||![sonString hasPrefix:@"["]) {
            continue;
        }
        MGLrcModel* lrcModel = [MGLrcModel lrcWithLrcName:sonString];
        [tmpArray addObject:lrcModel];
    }
    return tmpArray;

}
@end

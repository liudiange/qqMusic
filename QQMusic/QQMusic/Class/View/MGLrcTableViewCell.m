//
//  MGLrcTableViewCell.m
//  QQMusic
//
//  Created by 刘殿阁 on 16/7/9.
//  Copyright © 2016年 殿阁刘. All rights reserved.
//

#import "MGLrcTableViewCell.h"

@implementation MGLrcTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
    }
    return self;
}

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView
{
    static NSString* cell_id = @"lrcCell";
    MGLrcTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[MGLrcTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end

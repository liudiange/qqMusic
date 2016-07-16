//
//  MGLrcTableViewCell.h
//  QQMusic
//
//  Created by 刘殿阁 on 16/7/9.
//  Copyright © 2016年 殿阁刘. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MGLrcTableViewCell : UITableViewCell

//声明一个lable
@property (strong, nonatomic) UILabel*  lrcLable;
+ (instancetype)lrcCellWithTableView:(UITableView *)tableView;
@end

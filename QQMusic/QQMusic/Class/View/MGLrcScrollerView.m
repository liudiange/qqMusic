//
//  MGLrcScrollerView.m
//  QQMusic
//
//  Created by 刘殿阁 on 16/7/9.
//  Copyright © 2016年 殿阁刘. All rights reserved.
//

#import "MGLrcScrollerView.h"
#import "Masonry.h"
#import "MGLrcTableViewCell.h"
#import "MGLrcTool.h"
#import "MGLrcModel.h"
@interface MGLrcScrollerView ()<UITableViewDataSource>
@property (strong, nonatomic) UITableView* tableView;
//数组列表
@property (strong, nonatomic) NSArray* lrcList;


@end

@implementation MGLrcScrollerView
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder]) {
        //创建tableview
        [self setUpTableView];
    }
    return self;
}
/**
 *  创建tableview
 */
-(void)setUpTableView
{
    UITableView* tableView = [[UITableView alloc]init];
    [self addSubview:tableView];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView = tableView;
    
}
-(void)awakeFromNib
{
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 35.0;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(self.mas_height);
        make.left.equalTo(self.mas_left).offset(self.bounds.size.width);
        make.right.equalTo(self.mas_right);
        make.width.equalTo(self.mas_width);
    }];
}
#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lrcList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   MGLrcTableViewCell* cell = [MGLrcTableViewCell lrcCellWithTableView:tableView];
   MGLrcModel* model  = self.lrcList[indexPath.row];
    cell.textLabel.text = model.text;
   return cell;
}
#pragma mark - 歌词解析
-(void)setLrcName:(NSString *)lrcName
{
    _lrcName = [lrcName copy];
    //解析获得数组
    NSArray* lrcArray = [MGLrcTool lrcWithName:_lrcName];
    self.lrcList = lrcArray;
    [self.tableView reloadData];
    
}






















@end

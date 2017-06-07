//
//  CustomCell.m
//  SimultaneousTest
//
//  Created by Leon.Hwa on 17/4/28.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "CustomCell.h"
#import "LHTabView.h"

#import "MainView.h"
#import "WeiboView.h"
#import "VideoView.h"
#import "PhotoView.h"
@interface CustomCell()
@property (nonatomic, strong) LHTabView *tabView;
@end

@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        MainView *mainView = [[MainView alloc] init];
        WeiboView *weiboView = [[WeiboView alloc] init];
        VideoView *videoView = [[VideoView alloc] init];
        PhotoView *photoView = [[PhotoView alloc] init];
        _tabView = [[LHTabView alloc] initWithItemsName:@[@"主页",@"微博",@"视频",@"相册"] childrenView:@[mainView,weiboView,videoView,photoView]];
        [self.contentView addSubview:_tabView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tabView.frame = self.bounds;
}
@end

//
//  ItemBaseView.m
//  SimultaneousTest
//
//  Created by Leon.Hwa on 17/4/28.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "ItemBaseView.h"

@interface ItemBaseView()

@end
@implementation ItemBaseView


- (UITableView *)tableView{
    if(_tableView == nil){
        _tableView= [[UITableView  alloc] init];
    }
    return _tableView;
}
- (void)renderWithIndex:(NSInteger)index
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];

    __weak typeof(self) weakSelf = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
        self.frame = CGRectMake(WIDTH * index, 0, WIDTH, HEIGHT - NavigationHeight - TitleViewHeight);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollAction:) name:TabViewScrollToTopNotification object:nil];
    
}

- (void)scrollAction:(NSNotification *)noti{
    BOOL ret = [noti.object boolValue];
    self.shouldScroll = ret;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY <= 0){
        [[NSNotificationCenter defaultCenter]  postNotificationName:ItemScrollToTopNotification object:@(YES)];
    }
    if(self.shouldScroll  == NO){
        [scrollView setContentOffset:CGPointZero];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

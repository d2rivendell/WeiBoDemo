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

    self.frame = CGRectMake(WIDTH * index, 0, WIDTH, HEIGHT - NavigationHeight - TitleViewHeight);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollAction:) name:TabViewScrollToTopNotification object:nil];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
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


@end

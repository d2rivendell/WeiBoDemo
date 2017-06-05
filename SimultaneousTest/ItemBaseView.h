//
//  ItemBaseView.h
//  SimultaneousTest
//
//  Created by Leon.Hwa on 17/4/28.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemBaseView : UIView<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, assign) BOOL shouldScroll;

@property (nonatomic, strong) UITableView *tableView;

- (void)renderWithIndex:(NSInteger)index;
@end

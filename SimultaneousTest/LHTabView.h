//
//  LHTabView.h
//  SimultaneousTest
//
//  Created by Leon.Hwa on 17/4/28.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemBaseView,LHTabView;
@protocol LHTabViewDelegate <NSObject>

- (void)LHTabViewDidScroll:(LHTabView*)tabView;

- (void)LHTabViewDidEndDecelerating:(LHTabView *)tabView;
@end
@interface LHTabView : UIView
@property (nonatomic, weak) id <LHTabViewDelegate> delegate;
@property (nonatomic, assign) CGPoint offset;
- (instancetype)initWithItemsName:(NSArray *)itemsName childrenView:(NSArray <ItemBaseView *>*)childrenView;
@end

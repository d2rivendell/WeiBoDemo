//
//  LHTitleView.h
//  SimultaneousTest
//
//  Created by Leon.Hwa on 17/4/28.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHTabView.h"
typedef void (^LHTitleViewSelectRow)(NSInteger row);

@interface LHTitleView : UIView<LHTabViewDelegate>

@property (nonatomic, copy) LHTitleViewSelectRow  selectRow;

- (instancetype)initWithTitles:(NSArray *)titles;

@end

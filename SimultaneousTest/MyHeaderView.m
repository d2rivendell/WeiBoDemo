//
//  MyHeaderView.m
//  SimultaneousTest
//
//  Created by Leon.Hwa on 17/4/28.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "MyHeaderView.h"

@interface MyHeaderView()
@property (nonatomic, strong) UIImageView  *avatarView;

@end
@implementation MyHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _avatarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar"]];
        [self addSubview:_avatarView];
        [self autoLayout];
        
    }
    return self;
}

- (void)autoLayout{
    __weak typeof(self) weakSelf = self;
 [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.centerX.equalTo(weakSelf.mas_centerX);
     make.centerY.equalTo(weakSelf.mas_centerY).offset(-20);
     make.width.equalTo(@50);
     make.height.equalTo(@50);

 }];
  self.avatarView.layer.cornerRadius = 25;
  self.avatarView.clipsToBounds = YES;

}
@end

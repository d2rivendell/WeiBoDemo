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
        self.avatarView.layer.cornerRadius = 25;
        self.avatarView.clipsToBounds = YES;
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
     self.avatarView.frame = CGRectMake((self.width - 50)/2, (self.height - 50)/2, 50, 50);

}
@end

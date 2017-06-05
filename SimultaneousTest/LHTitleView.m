//
//  LHTitleView.m
//  SimultaneousTest
//
//  Created by Leon.Hwa on 17/4/28.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LHTitleView.h"

const CGFloat margin = 42;
const CGFloat titleWidth = 32;
@interface LHTitleView()
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableDictionary *pointsDict;
@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, assign) CGFloat lineTotalWidth;
@property (nonatomic, assign) CGFloat lineWidth;
@end

@implementation LHTitleView

- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        _titles = titles;
        _pointsDict = [NSMutableDictionary dictionaryWithCapacity:titles.count];
        self.frame = CGRectMake(0, 0, WIDTH, 44);
        NSInteger midIndex= titles.count/2;
        UIButton *midBtn  = nil;
        if(titles.count % 2 == 0){
         midBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH+ margin)/2, 0, titleWidth, TitleViewHeight)];
        }else{
            midBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH)/2, 0, titleWidth,TitleViewHeight)];
        }
        [self setupBtn:midBtn index:midIndex];
        [self setupLeftBtn:midBtn index:midIndex-1];
        [self setupRightBtn:midBtn index:midIndex +1];
        
        self.lineLayer = [CAShapeLayer layer];
        self.lineLayer.cornerRadius = 1.5;
        self.lineLayer.lineWidth = 3;
        self.lineLayer.fillColor = [UIColor clearColor].CGColor;
        self.lineLayer.strokeColor = [UIColor orangeColor].CGColor;
        self.lineLayer.lineCap = @"round";
        self.lineLayer.speed = 2.5;
        self.bezierPath = [UIBezierPath bezierPath];
        
        self.lineTotalWidth = [self.pointsDict[@(titles.count-1)][@"end"] floatValue] - [self.pointsDict[@(0)][@"start"] floatValue];
        self.lineWidth = [self.pointsDict[@(0)][@"end"] floatValue] - [self.pointsDict[@(0)][@"start"] floatValue];
        
        [self.bezierPath moveToPoint:CGPointMake([self.pointsDict[@(0)][@"start"] floatValue], TitleViewHeight - 4)];
         [self.bezierPath addLineToPoint:CGPointMake([self.pointsDict[@(titles.count-1)][@"end"] floatValue], TitleViewHeight - 4)];
        
        self.lineLayer.path = self.bezierPath.CGPath;
        
        self.lineLayer.strokeStart = 0;
        self.lineLayer.strokeEnd = self.lineWidth/self.lineTotalWidth;
        [self.layer addSublayer:self.lineLayer];
        
        UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, TitleViewHeight-1, WIDTH, 1)];
        bottomBorder.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
        [self addSubview:bottomBorder];
        
    }
    return self;
}

- (void)setupLeftBtn:(UIButton *)rightBtn index:(NSInteger)index{
    if(index < 0){
        return;
    }
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(rightBtn.x - margin -titleWidth , 0, titleWidth, TitleViewHeight)];
    [self setupBtn:leftBtn index:index];
    [self setupLeftBtn:leftBtn index:--index];
}
- (void)setupRightBtn:(UIButton *)leftBtn index:(NSInteger)index{
    if(index > self.titles.count - 1){
        return;
    }
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftBtn.frame) + margin, 0, titleWidth, TitleViewHeight)];
    [self setupBtn:rightBtn index:index];
    [self setupRightBtn:rightBtn index:++index];
}

- (void)setupBtn:(UIButton *)btn index:(NSInteger)index{
    self.pointsDict[@(index)] = @{@"start":@(btn.x + 2),@"end":@(CGRectGetMaxX(btn.frame)-2)};
    [btn setTitle:self.titles[index] forState:UIControlStateNormal];
    [btn setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor: [UIColor grayColor] forState:UIControlStateSelected];
    btn.tag = index;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];

    [self addSubview:btn];
}

- (void)btnClick:(UIButton *)btn{
    [self layoutLineWithIndex:btn.tag];
    if(self.selectRow){
        self.selectRow( btn.tag);
    }
}

- (void)LHTabViewDidScroll:(LHTabView *)tabView{
    CGFloat offsetX = tabView.offset.x;
    NSInteger index = offsetX/WIDTH;
    
    CGFloat zero =  [self.pointsDict[@(0)][@"start"] floatValue];
    
    CGFloat currentStart =  [self.pointsDict[@(index)][@"start"] floatValue];
    
    CGFloat currentEnd =  [self.pointsDict[@(index)][@"end"] floatValue];
    
    CGFloat nextStart =  [self.pointsDict[@(index+1)][@"start"] floatValue];
    CGFloat nextEnd =  [self.pointsDict[@(index+1)][@"end"] floatValue];
    
   
    
    CGFloat PhysicsDelta = offsetX - index * WIDTH;
    
//    CGFloat delta = nextStart - currentEnd;
//    
//    delta = (PhysicsDelta/WIDTH) * delta;
//    
    CGFloat end,start;
    CGFloat delta = nextEnd - currentEnd;
    if(PhysicsDelta <= WIDTH/2){
        delta = (PhysicsDelta/(WIDTH/2)) * delta;
        end = currentEnd + delta;
//          NSLog(@"index=%ld  currentEnd = %f  eee = %f",index,currentEnd,(currentEnd - zero));
        
        self.lineLayer.strokeStart = (currentStart - zero)/self.lineTotalWidth;
        self.lineLayer.strokeEnd = (end - zero)/self.lineTotalWidth;
    }else{
        delta = nextStart - currentStart;
        PhysicsDelta = PhysicsDelta - WIDTH/2;
        
        delta = (PhysicsDelta/(WIDTH/2)) * delta;
        start = currentStart + delta;
        NSLog(@"index=%ld  start=%f   end=%f",index,(start - zero),(nextEnd - zero))
        self.lineLayer.strokeStart = (start - zero)/self.lineTotalWidth;
        self.lineLayer.strokeEnd = (nextEnd - zero)/self.lineTotalWidth;
    }
    

}
- (void)LHTabViewDidEndDecelerating:(LHTabView *)tabView{
    CGFloat offsetX = tabView.offset.x;
    NSInteger index = offsetX/WIDTH;
   [self layoutLineWithIndex:index];
}

- (void)layoutLineWithIndex:(NSInteger)index{
    CGFloat zero =  [self.pointsDict[@(0)][@"start"] floatValue];
    CGFloat start =  [self.pointsDict[@(index)][@"start"] floatValue];
    CGFloat end =  [self.pointsDict[@(index)][@"end"] floatValue];
    self.lineLayer.strokeStart = (start - zero)/self.lineTotalWidth;
    self.lineLayer.strokeEnd = (end - zero)/self.lineTotalWidth;
   
}
@end

//
//  ViewController.m
//  SimultaneousTest
//
//  Created by Leon.Hwa on 17/4/28.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableView.h"
#import "MyHeaderView.h"
#import "CustomCell.h"
const CGFloat HeaderHeight = 240;
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) IBOutlet CustomTableView *tableView;
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, weak) UIImageView *navigationBarView;

@property (nonatomic, assign) BOOL shouldScroll;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBg];
    [self setupTableView];
    _shouldScroll = YES;
    //导航栏底部线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    _navigationBarView = self.navigationController.navigationBar.subviews.firstObject;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
     self.navigationBarView.alpha = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addNotification];
}

- (void)addNotification{
    __weak typeof(self) weakSlef = self;
 [[NSNotificationCenter defaultCenter] addObserverForName:ItemScrollToTopNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
     weakSlef.shouldScroll = [note.object boolValue];
 }];

}
- (void)setupBg{
    self.bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header"]];
    self.bgView.frame = CGRectMake(0, -70, WIDTH, WIDTH);
    [self.view insertSubview: self.bgView atIndex:0];
  
}
- (void)setupTableView{
   
    MyHeaderView *headerView = [[MyHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HeaderHeight)];
    self.tableView.tableHeaderView = headerView;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = HEIGHT - NavigationHeight;
    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"CustomCell"];
    self.tableView.showsVerticalScrollIndicator = NO;
   
}

-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
//    NSLog(@"%f",offsetY);
    if(offsetY > (HeaderHeight - 64 * 2)){
        CGFloat delta = offsetY - (HeaderHeight - 64 * 2);
        CGFloat alpha = delta/64.0;
        self.navigationBarView.alpha = alpha > 1? 1 :alpha ;
//            NSLog(@"alpha~~~~~~%f",alpha);
    }else{
      self.navigationBarView.alpha = 0;
    }
    
    if(offsetY <= 0){
        if(offsetY > -160){
            self.bgView.y = -offsetY/2 + (- 70);
        }
    }else{
        self.bgView.y = -offsetY + (- 70);
    }
    
    
    if(offsetY >= HeaderHeight - 64){
       [[NSNotificationCenter defaultCenter] postNotificationName:TabViewScrollToTopNotification object:@(YES)];
        self.shouldScroll = NO;
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:TabViewScrollToTopNotification object:@(NO)];
    }
    if(self.shouldScroll == NO){
     [scrollView setContentOffset:CGPointMake(0, HeaderHeight - 64)];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

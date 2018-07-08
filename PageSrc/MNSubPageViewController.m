//
//  MNSubPageViewController.m
//  CarTestDemo
//
//  Created by 蔡杰 on 2018/7/8.
//  Copyright © 2018年 AllanCai. All rights reserved.
//

#import "MNSubPageViewController.h"
#import "MNPageView.h"
#import "UIScrollView+MNPageExtend.h"
#import "UIViewController+MNPageExtend.h"
#import "MNSegmentView.h"
@interface MNSubPageViewController ()<MNPageViewDelegate,MNPageViewDataSource,MNSegmentViewDelegate>



@property (nonatomic,strong) MNSegmentView *segmentView;

@property (nonatomic, strong) MNPageView *contentView;

@end

@implementation MNSubPageViewController {
    
    CGRect _tableViewFrame;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupSegment];
    [self setupContentView];
    
    _tableViewFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)- CGRectGetHeight(_segmentView.frame));
}

- (void)setupSegment {
    
    NSArray *items = [self subPageItemsTagList];
    
    if (![items count]) {
        return;
    }
    _segmentView = [[MNSegmentView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40)];
    _segmentView.delegate = self;
    _segmentView.itemWidth = CGRectGetWidth(self.view.bounds) / [items count];
    _segmentView.itemFont = [UIFont systemFontOfSize:15];
    _segmentView.itemNormalColor = [UIColor colorWithRed:155.0 / 255 green:155.0 / 255 blue:155.0 / 255 alpha:1];
    _segmentView.itemSelectColor = [UIColor colorWithRed:244.0 / 255 green:67.0 / 255 blue:54.0 / 255 alpha:1];
    _segmentView.bottomLineWidth = 40;
    _segmentView.bottomLineHeight = 2;
    _segmentView.itemList = items;
    [self.view addSubview:_segmentView];
}

- (void)setupContentView {
    self.contentView = [[MNPageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_segmentView.frame), CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - CGRectGetHeight(_segmentView.frame))];
    _contentView.delegate = self;
    _contentView.dataSource = self;
    [self.view addSubview:_contentView];
    
    
}
#pragma mark - Delegate

- (NSUInteger)numberOfPagesInPageView:(MNPageView *)pageView {
    
    return [self numbersOfTabeView];
}

- (UIView *)pageView:(MNPageView *)pageView pageAtIndex:(NSUInteger)index {
    
    UITableView *tableView =
    [self tableViewsAtIndex:index frame:_tableViewFrame];
    
    [self mn_observerScrollView:tableView];
    return tableView;
}

- (void)pageView:(MNPageView *)pageView didScrollToIndex:(NSUInteger)index {
        [_segmentView scrollToIndex:index];
}


#pragma mark - Public

- (NSArray<NSString *> *)subPageItemsTagList {
    return nil;
}

- (NSInteger)numbersOfTabeView {
    return 0;
}

- (UITableView *)tableViewsAtIndex:(NSInteger)index frame:(CGRect)frame {
    
    return nil;
}

#pragma mark - MFSegmentViewDelegate

- (void)segmentView:(MNSegmentView *)segmentView didScrollToIndex:(NSUInteger)index {
    
    [_contentView scrollToIndex:index];
}

#pragma mark - Private
- (void)mn_observerScrollView:(UIScrollView *)scrollView {
    scrollView.mn_observerDidScrollView = YES;
    __weak typeof(self) weakSelf = self;
    scrollView.mn_pageScrollViewDidScrollView = ^(UIScrollView *scrollView) {
        [weakSelf mn_pageScrollViewDidScrollView:scrollView];
    };
}

- (void)mn_pageScrollViewDidScrollView:(UIScrollView *)scrollView {
    if (!self.mn_subPageCanScroll) {
        // 这里通过固定contentOffset，来实现不滚动
        scrollView.contentOffset = CGPointZero;
    } else if (scrollView.contentOffset.y <= 0) {
        self.mn_subPageCanScroll = NO;
        // 通知容器可以开始滚动
        //_nestTableView.canScroll = YES;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.nestTableView.scroll" object:@{@"scroll":@(YES),@"VC":self}];
        
    }
    scrollView.showsVerticalScrollIndicator = self.mn_subPageCanScroll;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

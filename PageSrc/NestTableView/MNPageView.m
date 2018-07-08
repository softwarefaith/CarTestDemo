//
//  MNPageView.m
//  CarTest
//
//  Created by Allan on 2018/7/8.
//  Copyright © 2018年 Allan. All rights reserved.
//

#import "MNPageView.h"


@interface MNPageCollectionView : UICollectionView


@end


@implementation MNPageCollectionView

@end







static NSString * const kMNPageViewReuseIdentifier = @"MNPageViewReuseIdentifier";

@interface MNPageView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) MNPageCollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;

@end

@implementation MNPageView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 调整所有item的尺寸，保证item高度和pageView高度相等
    _collectionView.frame = [self bounds];
    _collectionViewLayout.itemSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    [_collectionView reloadData];
}

#pragma mark - public methods

- (void)scrollToIndex:(NSUInteger)index {
    
    if (!_collectionView) {
        return;
    }
    
    NSInteger pageCount = [self collectionView:_collectionView numberOfItemsInSection:0];
    if (index >= pageCount) {
        return;
    }
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark - private methods

- (void)commonInit {
    
    [self createCollectionViewLayout];
    
    _collectionView = [[MNPageCollectionView alloc] initWithFrame:[self bounds] collectionViewLayout:_collectionViewLayout];
    [self addSubview:_collectionView];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kMNPageViewReuseIdentifier];
    
   
    
    if (@available(iOS 11.0, *)) {
        if (_collectionView) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
}

- (void)createCollectionViewLayout {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置间距
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    //设置item尺寸
    CGFloat itemW = CGRectGetWidth(self.frame);
    CGFloat itemH = CGRectGetHeight(self.frame);
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 设置水平滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _collectionViewLayout = flowLayout;
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.dataSource &&
        [self.dataSource respondsToSelector:@selector(numberOfPagesInPageView:)]) {
        return [self.dataSource numberOfPagesInPageView:self];
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMNPageViewReuseIdentifier forIndexPath:indexPath];
    
    if (self.dataSource &&
        [self.dataSource respondsToSelector:@selector(pageView:pageAtIndex:)]) {
        UIView *view = [self.dataSource pageView:self pageAtIndex:indexPath.row];
        [cell.contentView addSubview:view];
        view.frame = cell.bounds;
    }
    
    return cell;
}




// 这个方法只有拖动界面会调用，调用scrollToItemAtIndexPath: atScrollPosition:方法不会调用
- (void)scrollViewDidEndDecelerating:(UICollectionView *)collectionView {
    
    CGFloat offset = collectionView.contentOffset.x;
    NSInteger pageNum = round(offset / CGRectGetWidth(self.frame));
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageView:didScrollToIndex:)]) {
        [self.delegate pageView:self didScrollToIndex:pageNum];
    }
}

@end











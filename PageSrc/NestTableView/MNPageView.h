//
//  MNPageView.h
//  CarTest
//
//  Created by Allan on 2018/7/8.
//  Copyright © 2018年 Allan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MNPageView;

@protocol MNPageViewDataSource <NSObject>

- (NSUInteger)numberOfPagesInPageView:(MNPageView *)pageView;
- (UIView *)pageView:(MNPageView *)pageView pageAtIndex:(NSUInteger)index;

@end

@protocol MNPageViewDelegate <NSObject>

- (void)pageView:(MNPageView *)pageView didScrollToIndex:(NSUInteger)index;

@end

@interface MNPageView : UIView

@property (nonatomic, weak) id<MNPageViewDataSource> dataSource;
@property (nonatomic, weak) id<MNPageViewDelegate> delegate;

- (void)scrollToIndex:(NSUInteger)index;

@end

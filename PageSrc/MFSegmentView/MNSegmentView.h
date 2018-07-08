//
//  MNSegmentView.h
//  CarTest
//
//  Created by Allan on 2018/7/8.
//  Copyright © 2018年 Allan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MNSegmentView;

@protocol MNSegmentViewDelegate <NSObject>

- (void)segmentView:(MNSegmentView *)segmentView didScrollToIndex:(NSUInteger)index;

@end


@interface MNSegmentView : UIView

@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, strong) UIFont *itemFont;
@property (nonatomic, strong) UIColor *itemNormalColor;
@property (nonatomic, strong) UIColor *itemSelectColor;
@property (nonatomic, assign) CGFloat bottomLineWidth;
@property (nonatomic, assign) CGFloat bottomLineHeight;

@property (nonatomic, strong) NSArray <NSString *> *itemList;

@property (nonatomic, weak) id<MNSegmentViewDelegate> delegate;

- (void)scrollToIndex:(NSUInteger)index;

@end

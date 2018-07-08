//
//  UIScrollView+MNPageExtend.h
//  CarTestDemo
//
//  Created by 蔡杰 on 2018/7/8.
//  Copyright © 2018年 AllanCai. All rights reserved.
//

#import <UIKit/UIKit.h>
//扩展目的就是为了监听ScrollViewDidScrollView

typedef void(^MNPageScrollViewDidScrollViewBlock)(UIScrollView *scrollView);
@interface UIScrollView (MNPageExtend)


@property (nonatomic, assign) BOOL mn_observerDidScrollView;

@property (nonatomic, copy) MNPageScrollViewDidScrollViewBlock mn_pageScrollViewDidScrollView;

@end

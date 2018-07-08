//
//  MNPageViewController.h
//  CarTestDemo
//
//  Created by 蔡杰 on 2018/7/8.
//  Copyright © 2018年 AllanCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MNPageViewController;

@protocol MNPageViewControllerDataSource <NSObject>
@required


- (NSInteger)numbersOfChildControllersInPageController:(MNPageViewController *)pageController;


- (__kindof UIViewController *)pageController:(MNPageViewController *)pageController viewControllerAtIndex:(NSInteger)index;

//子VC对应的Key - //子VC 标题名，同时缓存VC key 不允许同名

- (NSString *)pageController:(MNPageViewController *)pageController titleAtIndex:(NSInteger)index;


- (UIScrollView *)pageViewController:(MNPageViewController *)pageViewController
                        pageForIndex:(NSInteger )index;

@end


@interface MNPageViewController : UIViewController



@property (nonatomic,weak) id <MNPageViewControllerDataSource> dataSource;


//代表 当前审核的进度
@property (nonatomic, assign) NSInteger currentProgress;

// 当前页面index
@property (nonatomic, assign, readonly) NSInteger pageIndex;

/**
 选中页码
 */
- (void)setSelectedPageIndex:(NSInteger)pageIndex;

/**
 *  当前PageScrollViewVC作为子控制器
 */
- (void)addSelfToParentViewController:(UIViewController *)parentViewControler;

/**
 *  从父类控制器里面移除自己（PageScrollViewVC）
 */
- (void)removeSelfViewController;

@end

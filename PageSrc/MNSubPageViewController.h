//
//  MNSubPageViewController.h
//  CarTestDemo
//
//  Created by 蔡杰 on 2018/7/8.
//  Copyright © 2018年 AllanCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNSubPageViewController : UIViewController


//子类需要覆盖以下方法



- (UIView *)footerView;

-(NSArray <NSString *> *)subPageItemsTagList;

- (NSInteger)numbersOfScrollView;

- (__kindof UIScrollView *)ScrollViewAtIndex:(NSInteger)index frame:(CGRect)frame;

@end

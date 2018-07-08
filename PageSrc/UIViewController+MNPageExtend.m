//
//  UIViewController+MNPageExtend.m
//  CarTestDemo
//
//  Created by 蔡杰 on 2018/7/8.
//  Copyright © 2018年 AllanCai. All rights reserved.
//

#import "UIViewController+MNPageExtend.h"
#import <objc/runtime.h>

@implementation UIViewController (MNPageExtend)

- (BOOL)mn_subPageCanScroll {
    return [objc_getAssociatedObject(self, @selector(mn_subPageCanScroll)) boolValue];
}
- (void)setMn_subPageCanScroll:(BOOL)mn_subPageCanScroll {
    objc_setAssociatedObject(self, @selector(mn_subPageCanScroll), @(mn_subPageCanScroll), OBJC_ASSOCIATION_ASSIGN);
}

@end

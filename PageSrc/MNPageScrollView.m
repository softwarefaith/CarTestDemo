//
//  MNPageScrollView.m
//  CarFinanceMondule
//
//  Created by 蔡杰 on 2018/7/5.
//  Copyright © 2018年 AllanCai. All rights reserved.
//

#import "MNPageScrollView.h"

@implementation MNPageScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
   // return NO;
    
    
//    if ([self panBack:gestureRecognizer]) {
//        return YES;
//    }
    return YES;
}

- (BOOL)panBack:(UIGestureRecognizer *)gestureRecognizer {
    
    int location_X = 0.15 * [UIScreen mainScreen].bounds.size.width;
    
    if (gestureRecognizer == self.panGestureRecognizer) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [pan translationInView:self];
        UIGestureRecognizerState state = gestureRecognizer.state;
        if (UIGestureRecognizerStateBegan == state || UIGestureRecognizerStatePossible == state) {
            CGPoint location = [gestureRecognizer locationInView:self];
            if (point.x > 0 && location.x < location_X && self.contentOffset.x <= 0) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
//    if ([self panBack:gestureRecognizer]) {
//        return NO;
//    }
    return YES;
}

@end

//
//  UIScrollView+MNPageExtend.m
//  CarTestDemo
//
//  Created by 蔡杰 on 2018/7/8.
//  Copyright © 2018年 AllanCai. All rights reserved.
//

#import "UIScrollView+MNPageExtend.h"

#import <objc/runtime.h>

@implementation  UIScrollView (MNPageExtend)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:NSSelectorFromString(@"_notifyDidScroll") withMethod:@selector(mn_scrollViewDidScrollView)];
    });
}

- (void)mn_scrollViewDidScrollView {
    [self mn_scrollViewDidScrollView];
    if (self.mn_observerDidScrollView && self.mn_pageScrollViewDidScrollView) {
        self.mn_pageScrollViewDidScrollView(self);
    }
}

#pragma mark - Getter - Setter

- (BOOL)mn_observerDidScrollView {
    return [objc_getAssociatedObject(self, @selector(mn_observerDidScrollView)) boolValue];
}
- (void)setMn_observerDidScrollView:(BOOL)mn_observerDidScrollView {
    objc_setAssociatedObject(self, @selector(mn_observerDidScrollView), @(mn_observerDidScrollView), OBJC_ASSOCIATION_ASSIGN);
}

- (MNPageScrollViewDidScrollViewBlock)mn_pageScrollViewDidScrollView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setMn_pageScrollViewDidScrollView:(MNPageScrollViewDidScrollViewBlock)mn_pageScrollViewDidScrollView {
    objc_setAssociatedObject(self, @selector(mn_pageScrollViewDidScrollView), mn_pageScrollViewDidScrollView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma amrk - Swizzle
+ (void)swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    Class cls = [self class];
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    if (class_addMethod(cls,
                        origSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        class_replaceMethod(cls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        class_replaceMethod(cls,
                            newSelector,
                            class_replaceMethod(cls,
                                                origSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}


@end


//
//  MNTransparentNavigationBar.m
//  CarTest
//
//  Created by Allan on 2018/4/29.
//  Copyright © 2018年 Allan. All rights reserved.
//

#import "MNTransparentNavigationBar.h"

@interface MNTransparentNavigationBar ()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation MNTransparentNavigationBar

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Private methods

- (void)commonInit
{
    // 将原来的背景设置透明
    UIImage *transparentImage = [[UIImage alloc] init];
    [self setBackgroundImage:transparentImage forBarMetrics:UIBarMetricsDefault];
    
    // 去除分割线
    UIImage *shadowImage = [[UIImage alloc] init];
    [self setShadowImage:shadowImage];
    
    self.backgroundColor = [UIColor colorWithWhite:1 alpha: 0];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    but.frame = CGRectMake(0, 22, 44, 44);
    UIImage *buttonimage = [UIImage imageNamed:@"barbuttonicon_back"];
    [but setImage:buttonimage forState:UIControlStateNormal];
    but.tintColor = [UIColor colorWithWhite:0 alpha: 1];
    self.leftBut = but;
    [self addSubview:but];
}

#pragma mark - public methods

- (void)setBackgroundAlpha:(CGFloat)alpha
{
    alpha = alpha > 1 ? 1 : alpha;
    alpha = alpha < 0 ? 0 : alpha;
    
    if (!_bgView) {
        UIView *backgroundView = [[self subviews] firstObject];
        UIView *view = [[UIView alloc] initWithFrame:backgroundView.bounds];
        self.bgView = view;view.backgroundColor = [UIColor redColor];
        self.bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [backgroundView insertSubview:_bgView atIndex:0];
    }
    
    _bgView.backgroundColor = [UIColor colorWithWhite:1 alpha:alpha];
    [self updateItemsWithAlpha:alpha];
}

#pragma mark - private methods

- (void)updateItemsWithAlpha:(CGFloat)alpha {
    
    self.leftBut.tintColor = [UIColor colorWithWhite:(1 - alpha) alpha:1];
    for (MNTransparentBarButtonItem *item in self.topItem.rightBarButtonItems) {
        if ([item isKindOfClass:[MNTransparentBarButtonItem class]]) {
            item.selected = alpha > 0.95;
        }
    }
    for (MNTransparentBarButtonItem *item in self.topItem.leftBarButtonItems) {
        if ([item isKindOfClass:[MNTransparentBarButtonItem class]]) {
            item.selected = alpha > 0.95;
        }
    }
    UIView *titleView = self.topItem.titleView;
    titleView.hidden = alpha <= 0.95;
}

@end

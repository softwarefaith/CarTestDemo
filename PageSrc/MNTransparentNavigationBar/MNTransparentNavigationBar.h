//
//  MNTransparentNavigationBar.h
//  CarTest
//
//  Created by Allan on 2018/4/29.
//  Copyright © 2018年 Allan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MNTransparentBarButtonItem.h"

@interface MNTransparentNavigationBar : UINavigationBar

@property (nonatomic, strong) UIButton *leftBut;


- (void)setBackgroundAlpha:(CGFloat)alpha;

@end

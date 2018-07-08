//
//  MNTransparentBarButtonItem.h
//  CarTest
//
//  Created by Allan on 2018/7/8.
//  Copyright © 2018年 Allan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNTransparentBarButtonItem : UIBarButtonItem

@property (nonatomic, strong) UIView *viewNormal;
@property (nonatomic, strong) UIView *viewSelected;
@property (nonatomic, assign) BOOL selected;

- (instancetype)initWithFrame:(CGRect)frame;

@end

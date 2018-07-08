//
//  MNStepView.h
//  SCPay
//
//  Created by 蔡杰 on 2018/7/8.
//  Copyright © 2018年 weihongfang. All rights reserved.
//

#import <UIKit/UIKit.h>
//
//#define TINTCOLOR [UIColor colorWithRed:35/255.f green:135/255.f blue:255/255.f alpha:1]

#define TINTCOLOR [UIColor redColor]

@interface MNStepConfig : NSObject

@property (nonatomic,assign) CGFloat circleWH;

@property (nonatomic, strong) UIColor *lineNomalColor;

@property (nonatomic, strong) UIColor *lineSuccessColor;

@end

@interface MNStepView : UIView

@property (nonatomic, assign)int stepIndex;

@property (nonatomic, strong) MNStepConfig *config;

@property (nonatomic,strong) void (^buttonClick)(UIButton * button,NSInteger  index);

- (instancetype)initWithFrame:(CGRect)frame config:(MNStepConfig *)config;

- (void)setStepIndex:(int)stepIndex Animation:(BOOL)animation;

@end

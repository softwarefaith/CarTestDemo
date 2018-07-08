
//
//  MNStepView.m
//  SCPay
//
//  Created by 蔡杰 on 2018/7/8.
//  Copyright © 2018年 weihongfang. All rights reserved.
//

#import "MNStepView.h"


@implementation MNStepConfig


- (instancetype)init {
    if(self = [super init]){
        [self configData];
    }
    return self;
}

- (void)configData {
    _circleWH = 24;
    _lineNomalColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
    _lineSuccessColor = [UIColor colorWithRed:18/255.0 green:212/255.0 blue:99/255.0 alpha:1/1.0];
}


@end

@interface MNStepView()

@property (nonatomic, strong)UIView *lineUndo;
@property (nonatomic, strong)UIView *lineDone;

@property (nonatomic, retain)NSMutableArray *cricleMarks;


@property (nonatomic, assign) NSInteger count;

@end


@implementation MNStepView {
    
}

- (instancetype)initWithFrame:(CGRect)frame config:(MNStepConfig *)config
{
    if ([super initWithFrame:frame])
    {
        
        self.backgroundColor = [UIColor purpleColor];
        _stepIndex = 2;
        _config = config ?:[[MNStepConfig alloc] init];
        _count = 5;
        
        
        //最下边细线
        _lineUndo = [[UIView alloc]init];
        _lineUndo.backgroundColor =_config.lineNomalColor;
        [self addSubview:_lineUndo];
        
        //最上边细线
        _lineDone = [[UIView alloc]init];
        _lineDone.backgroundColor = _config.lineSuccessColor;
        [self addSubview:_lineDone];
        
        for (int i = 0; i < _count ; i++)
        {
            UIButton *circleButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            circleButton.frame = CGRectMake(0, 14, _config.circleWH, _config.circleWH);
            circleButton.backgroundColor = [UIColor lightGrayColor];
            circleButton.layer.cornerRadius = _config.circleWH / 2;
            
            [circleButton setBackgroundColor:  [UIColor colorWithRed:140/255.0 green:140/255.0 blue:162/255.0 alpha:1/1.0]];
            
            [circleButton setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
            circleButton.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
            circleButton.layer.borderColor = [UIColor blueColor].CGColor;
            
            [circleButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            
            circleButton.tag = 100 + i;
            
            [self addSubview:circleButton];
            [self.cricleMarks addObject:circleButton];
        }

    }
    return self;
}

#pragma mark - Action

- (void)clickAction:(UIButton *)sender {
    
    self.buttonClick(sender, sender.tag - 100);
}

#pragma mark - method

- (void)layoutSubviews
{
    NSInteger perWidth = self.frame.size.width / _count;
    
    _lineUndo.frame = CGRectMake(0, 26, self.frame.size.width - perWidth, 1);
    _lineUndo.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    CGFloat startX = _lineUndo.frame.origin.x;
    
    for (int i = 0; i < _count; i++)
    {
        UIView *cricle = [_cricleMarks objectAtIndex:i];
        if (cricle != nil)
        {
            cricle.center = CGPointMake(i * perWidth + startX, _lineUndo.center.y);
        }
    }
    
    self.stepIndex = _stepIndex;
}

- (NSMutableArray *)cricleMarks
{
    if (_cricleMarks == nil)
    {
        _cricleMarks = [NSMutableArray arrayWithCapacity:_count];
    }
    return _cricleMarks;
}


#pragma mark - public method

- (void)setStepIndex:(int)stepIndex
{
    if (stepIndex >= 0 && stepIndex < _count) {
        _stepIndex = stepIndex;
        
        CGFloat perWidth = self.frame.size.width / _count;
        _lineDone.frame = CGRectMake(_lineUndo.frame.origin.x, _lineUndo.frame.origin.y, perWidth * _stepIndex, _lineUndo.frame.size.height);
        
        for (int i = 0; i < _count; i++){
            UIView *cricle = [_cricleMarks objectAtIndex:i];
            if (cricle != nil) {
                if (i <= _stepIndex){
                    cricle.backgroundColor = TINTCOLOR;
                }
                else{
                    cricle.backgroundColor = [UIColor lightGrayColor];
                }
            }
        }
    }
}

- (void)setStepIndex:(int)stepIndex Animation:(BOOL)animation {
    if (stepIndex >= 0 && stepIndex < _count) {
        if (animation) {
            [UIView animateWithDuration:0.5 animations:^{
                self.stepIndex = stepIndex;
            }];
        } else {
            self.stepIndex = stepIndex;
        }
    }
}


@end

//
//  PSAlertView.m
//  PSAlertView
//
//  Created by 刘旭 on 15/10/21.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#define kAlertWidth 250.0f
#define kAlertHeight 175.0f
#define kLeftMargin 15.0f

#import "PSAlertView.h"


@interface PSAlertView ()

@property (nonatomic, strong) UIView *bgView;//alertView背景颜色
@property (nonatomic, strong) UIView *overlayView;//蒙层颜色
@property (nonatomic, strong) UIButton *closeButton;//关闭按钮
@property (nonatomic, strong) UIButton *confirmButton;//底部确认按钮
@property (nonatomic, strong) UIImageView *confirmImageView;//确认按钮图片
@property (nonatomic, strong) UILabel *titleLabel;//中间文字

@end

@implementation PSAlertView

- (id)initWithAlertTitle:(NSString *)alertTitle {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self buildView];
        self.titleLabel.text = alertTitle;
    }
    return self;
}
- (void)buildView {
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(kLeftMargin, kLeftMargin, kAlertWidth-kLeftMargin, kAlertHeight)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgView];
    
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setImage:[UIImage imageNamed:@"alert_close"] forState:UIControlStateNormal];
    self.closeButton.frame = CGRectMake(0, 0, 33, 34);
    [self addSubview:self.closeButton];
    [self.closeButton addTarget:self action:@selector(closeAlert) forControlEvents:UIControlEventTouchDown];
    
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftMargin, self.bgView.frame.origin.y + 60, self.bgView.frame.size.width, 14)];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmButton.backgroundColor = [UIColor blackColor];
    self.confirmButton.frame = CGRectMake(0, self.bgView.frame.size.height - 45, self.bgView.frame.size.width, 45);
    [self.bgView addSubview:self.confirmButton];
    [self.confirmButton addTarget:self action:@selector(confirmAlert) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.confirmImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 19, 19)];
    self.confirmImageView.image = [UIImage imageNamed:@"alert_confirm"];
    [self.confirmButton addSubview:self.confirmImageView];
    self.confirmImageView.center = CGPointMake(self.confirmImageView.superview.frame.size.width / 2, self.confirmImageView.superview.frame.size.height / 2);
}

#pragma mark - show
- (void)show {
    UIViewController *vc = [self RootViewController];
    self.frame = CGRectMake((CGRectGetWidth(vc.view.bounds) - kAlertWidth - kLeftMargin) * 0.5, (CGRectGetHeight(vc.view.bounds) - kAlertHeight - kLeftMargin) * 0.5, kAlertWidth, kAlertHeight);
    [self setStartState];
    [vc.view addSubview:self];
}

- (UIViewController *)RootViewController {
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVc = vc;
    while (topVc.presentedViewController) {
        topVc = topVc.presentedViewController;
    }
    return topVc;
}

-(void)setStartState {
    self.transform = CGAffineTransformMakeScale(0,0);;
}

-(void)setEndState {
    self.transform = CGAffineTransformMakeScale(1.0,1.0);
}

#pragma mark - confirm
- (void)confirmAlert {
    [self removeView];
    if (self.confirmBlock) {
        self.confirmBlock(YES);
    }
}

#pragma mark - close
- (void)closeAlert {
    [self removeView];
    if (self.confirmBlock) {
        self.confirmBlock(NO);
    }
}

- (void)removeView {
    [self.overlayView removeFromSuperview];
    self.overlayView = nil;
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self setStartState];
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self RootViewController];
    if (!self.overlayView) {
        self.overlayView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.overlayView.backgroundColor = [UIColor blackColor];
        self.overlayView.alpha = 0.6f;
        self.overlayView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.overlayView];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self setEndState];
    } completion:^(BOOL finished) {
        
    }];
    
    [super willMoveToSuperview:newSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

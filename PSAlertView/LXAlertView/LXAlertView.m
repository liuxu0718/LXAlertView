//
//  PSAlertView.m
//  PSAlertView
//
//  Created by 刘旭 on 15/10/21.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#define kAlertWidth 250.0f
#define kAlertHeight 175.0f

#import "LXAlertView.h"


@interface LXAlertView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *backgroundView;//alertView背景颜色
@property (nonatomic, strong) UIView *overlayView;//蒙层颜色
@property (nonatomic, strong) UIButton *closeButton;//关闭按钮
@property (nonatomic, strong) UIButton *confirmButton;//确认按钮
@property (nonatomic, strong) UILabel *titleLabel;//中间文字
@property (nonatomic, strong) UITextField *textField;//输入框

@end

@implementation LXAlertView

- (id)initWithAlertTitle:(NSString *)alertTitle
           WithAlertType:(AlertType)alertType {
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.type = alertType;
        
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAlertWidth, kAlertHeight)];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backgroundView];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = alertTitle;
        [self.backgroundView addSubview:self.titleLabel];
        
        self.textField = [[UITextField alloc]init];
        self.textField.textColor = [UIColor blackColor];
        self.textField.layer.borderColor = [UIColor blackColor].CGColor;
        self.textField.layer.borderWidth = 0.5;
        self.textField.font = [UIFont systemFontOfSize:12];
        self.textField.placeholder = @"helloworld";
        self.textField.delegate = self;
        self.textField.returnKeyType = UIReturnKeyDone;
        [self.backgroundView addSubview:self.textField];
        
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.confirmButton.backgroundColor = [UIColor blackColor];
        self.confirmButton.tag = 301;
        [self.confirmButton addTarget:self action:@selector(buttonAlert:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundView addSubview:self.confirmButton];
        
        self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.closeButton.backgroundColor = [UIColor blackColor];
        self.closeButton.tag = 300;
        [self.closeButton addTarget:self action:@selector(buttonAlert:) forControlEvents:UIControlEventTouchDown];
        [self.backgroundView addSubview:self.closeButton];
        
        if (AlertDefault == self.type || AlertLand == self.type) {
            self.closeButton.hidden = YES;
            self.textField.hidden = YES;
            //title
            self.titleLabel.frame = CGRectMake(0, 0, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height - 45);
            //confirm
            [self.confirmButton setImage:[UIImage imageNamed:@"alert_confirm"] forState:UIControlStateNormal];
            self.confirmButton.frame = CGRectMake(0, self.backgroundView.frame.size.height - 45, self.backgroundView.frame.size.width, 45);
        }
        else if (AlertSelect == self.type) {
            self.closeButton.hidden = NO;
            self.textField.hidden = YES;
            self.titleLabel.frame = CGRectMake(0, 0, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height - 45);
            [self.closeButton setTitle:@"取消" forState:UIControlStateNormal];
            self.closeButton.frame = CGRectMake(0, self.backgroundView.frame.size.height - 45, self.backgroundView.frame.size.width / 2, 45);
            [self.confirmButton setTitle:@"确认" forState:UIControlStateNormal];
            self.confirmButton.frame = CGRectMake(self.backgroundView.frame.size.width / 2, self.backgroundView.frame.size.height - 45, self.backgroundView.frame.size.width / 2, 45);
        }
        else if (AlertTextField == self.type) {
            self.closeButton.hidden = NO;
            self.textField.hidden = NO;
            self.titleLabel.frame = CGRectMake(0, 0, self.backgroundView.frame.size.width, (self.backgroundView.frame.size.height - 45) / 2);
            self.textField.frame = CGRectMake(0, (self.backgroundView.frame.size.height - 45) / 2, self.backgroundView.frame.size.width - 50, 30);
            self.textField.center = CGPointMake(self.backgroundView.center.x, self.textField.center.y);
            [self.closeButton setTitle:@"取消" forState:UIControlStateNormal];
            self.closeButton.frame = CGRectMake(0, self.backgroundView.frame.size.height - 45, self.backgroundView.frame.size.width / 2, 45);
            [self.confirmButton setTitle:@"确认" forState:UIControlStateNormal];
            self.confirmButton.frame = CGRectMake(self.backgroundView.frame.size.width / 2, self.backgroundView.frame.size.height - 45, self.backgroundView.frame.size.width / 2, 45);
        }
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

#pragma mark - show
- (void)show {
    UIViewController *vc = [self RootViewController];
    [vc.view addSubview:self];
    if (AlertLand == self.type) {
        self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - kAlertWidth) * 0.5, 0, kAlertWidth, kAlertHeight);
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - kAlertWidth) * 0.5, ([UIScreen mainScreen].bounds.size.height - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
        }];
    }
    else {
        self.frame = CGRectMake((CGRectGetWidth(vc.view.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(vc.view.bounds) - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
        [self setStartState];
    }
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
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);;
}

-(void)setEndState {
    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
}

#pragma mark - confirm
- (void)buttonAlert:(UIButton *)sender {
    [self removeView];
    if (300 == sender.tag) {
        if (self.block) {
            self.block(false, nil);
        }
    }
    else {
        if (AlertTextField == self.type) {
            self.block(true, self.textField.text);
        }
        else {
            self.block(true, nil);
        }
    }
}

- (void)removeView {
    if (AlertLand == self.type) {
        [self.overlayView removeFromSuperview];
        self.overlayView = nil;
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - kAlertWidth) * 0.5, [UIScreen mainScreen].bounds.size.height, kAlertWidth, kAlertHeight);
            self.alpha = 0;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else {
        [self.overlayView removeFromSuperview];
        self.overlayView = nil;
        [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self setStartState];
        } completion:^(BOOL finished) {
            [super removeFromSuperview];
        }];
    }
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

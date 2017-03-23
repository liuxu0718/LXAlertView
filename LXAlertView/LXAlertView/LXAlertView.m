//
//  LXAlertView.m
//  LXAlertView
//
//  Created by 刘旭 on 15/10/21.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#define kAlertWidth 250.0
#define kAlertHeight 175.0

#import "LXAlertView.h"


@interface LXAlertView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView      *backgroundView;//alertView背景颜色
@property (nonatomic, strong) UIView      *overlayView;//蒙层颜色
@property (nonatomic, strong) UIButton    *closeButton;//关闭按钮
@property (nonatomic, strong) UIButton    *confirmButton;//确认按钮
@property (nonatomic, strong) UILabel     *titleLabel;//中间文字
@property (nonatomic, strong) UITextField *textField;//输入框

@end

@implementation LXAlertView

- (id)initWithTitle:(NSString *)title Type:(LXAlertViewType)type {
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _type                           = type;

        _backgroundView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAlertWidth, kAlertHeight)];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backgroundView];

        _titleLabel                     = [[UILabel alloc]init];
        _titleLabel.textColor           = [UIColor blackColor];
        _titleLabel.font                = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment       = NSTextAlignmentCenter;
        _titleLabel.text                = title;
        _titleLabel.frame               = CGRectMake(0, 0, _backgroundView.frame.size.width, _backgroundView.frame.size.height - 45);

        [_backgroundView addSubview:_titleLabel];

        _textField                      = [[UITextField alloc]init];
        _textField.textColor            = [UIColor blackColor];
        _textField.layer.borderColor    = [UIColor blackColor].CGColor;
        _textField.layer.borderWidth    = 0.5;
        _textField.font                 = [UIFont systemFontOfSize:12];
        _textField.placeholder          = @"helloworld";
        _textField.delegate             = self;
        _textField.returnKeyType        = UIReturnKeyDone;
        _textField.frame                = CGRectMake(0, (_backgroundView.frame.size.height - 45) / 2, _backgroundView.frame.size.width - 50, 30);
        _textField.center               = CGPointMake(_backgroundView.center.x, _textField.center.y);
        [_backgroundView addSubview:_textField];

        _confirmButton                  = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.backgroundColor  = [UIColor blackColor];
        _confirmButton.tag              = 1;
        _confirmButton.frame            = CGRectMake(_backgroundView.frame.size.width / 2, _backgroundView.frame.size.height - 45, self.backgroundView.frame.size.width / 2, 45);
        [_confirmButton addTarget:self action:@selector(buttonAlert:) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundView addSubview:_confirmButton];

        _closeButton                    = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.backgroundColor    = [UIColor blackColor];
        _closeButton.tag                = 2;
        _closeButton.frame              = CGRectMake(0, _backgroundView.frame.size.height - 45, _backgroundView.frame.size.width / 2, 45);

        [_closeButton addTarget:self action:@selector(buttonAlert:) forControlEvents:UIControlEventTouchDown];
        [_backgroundView addSubview:_closeButton];
        
        if (LXAlertViewTypeDefault == _type || LXAlertViewTypeLand == _type) {
            _closeButton.hidden = YES;
            _textField.hidden = YES;
            
            //设置成图片
            [_confirmButton setImage:[UIImage imageNamed:@"alert_confirm"] forState:UIControlStateNormal];
            _confirmButton.frame = CGRectMake(0, _backgroundView.frame.size.height - 45, _backgroundView.frame.size.width, 45);
        } else if (LXAlertViewTypeSelect == _type) {
            _closeButton.hidden = NO;
            _textField.hidden = YES;
            
            //设置成文字
            [_closeButton setTitle:@"取消" forState:UIControlStateNormal];
            [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        } else if (LXAlertViewTypeTextField == _type) {
            _closeButton.hidden = NO;
            _textField.hidden = NO;
            
            _titleLabel.frame = CGRectMake(0, 0, _backgroundView.frame.size.width, (_backgroundView.frame.size.height - 45) / 2);
            //设置成文字
            [_closeButton setTitle:@"取消" forState:UIControlStateNormal];
            [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        }
    }
    return self;
}

- (UIView *)overlayView {
    if (!_overlayView) {
        _overlayView = [[UIView alloc]initWithFrame:[self appRootViewController].view.bounds];
        _overlayView.backgroundColor = [UIColor blackColor];
        _overlayView.alpha = 0.6;
        _overlayView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _overlayView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

#pragma mark - show
- (void)show {
    if (LXAlertViewTypeLand == _type) {
        self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - kAlertWidth) * 0.5, 0, kAlertWidth, kAlertHeight);
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - kAlertWidth) * 0.5, ([UIScreen mainScreen].bounds.size.height - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
        }];
    } else {
        self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - kAlertWidth) * 0.5, ([UIScreen mainScreen].bounds.size.height - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
        [self setStartState];
    }
    UIViewController *topVC = [self appRootViewController];
    [topVC.view addSubview:self];
}

-(void)setStartState {
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
}

-(void)setEndState {
    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
}

- (UIViewController *)appRootViewController {
    UIViewController *appRootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    //如果是模态.
    while (appRootVc.presentedViewController) {
        appRootVc = appRootVc.presentedViewController;
    }
    return appRootVc;
}

#pragma mark - confirm
- (void)buttonAlert:(UIButton *)sender {
    [self removeFromSuperview];
    if ([_delegate respondsToSelector:@selector(lxAlertView:withButtonIndex:withObject:)]) {
        [_delegate lxAlertView:self withButtonIndex:sender.tag withObject:_textField.text];
    }
}

- (void)removeFromSuperview {
    [_overlayView removeFromSuperview];
    _overlayView = nil;
    if (LXAlertViewTypeLand == _type) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - kAlertWidth) * 0.5, [UIScreen mainScreen].bounds.size.height, kAlertWidth, kAlertHeight);
            self.alpha = 0;
        }completion:^(BOOL finished) {
            [super removeFromSuperview];
        }];
    } else {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
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
    [[self appRootViewController].view addSubview:self.overlayView];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self setEndState];
    } completion:^(BOOL finished) {
        [super willMoveToSuperview:newSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

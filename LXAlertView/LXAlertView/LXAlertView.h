//
//  LXAlertView.h
//  LXAlertView
//
//  Created by 刘旭 on 15/10/21.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXAlertView;

@protocol LXAlertViewDelegate <NSObject>

- (void)lxAlertView:(LXAlertView *)alertView withButtonIndex:(NSInteger)buttonIndex withObject:(NSString *)object;

@end

typedef NS_ENUM(NSInteger, LXAlertViewType) {
    LXAlertViewTypeDefault = 1,
    LXAlertViewTypeSelect,
    LXAlertViewTypeTextField,
    LXAlertViewTypeLand,
};

@interface LXAlertView : UIView

@property(nonatomic, assign) LXAlertViewType type;
@property(nonatomic, weak) id<LXAlertViewDelegate> delegate;


- (id)initWithAlertTitle:(NSString *)alertTitle
               AlertType:(LXAlertViewType)alertType;
- (void)show;

@end

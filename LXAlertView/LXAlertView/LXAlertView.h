//
//  LXAlertView.h
//  LXAlertView
//
//  Created by 刘旭 on 15/10/21.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXAlertViewDelegate <NSObject>

- (void)LXAlertViewClickButtonIndex:(NSInteger)buttonIndex
                             Object:(NSString *)object;

@end

typedef NS_ENUM(NSInteger, AlertType) {
    AlertDefault = 1,
    AlertSelect,
    AlertTextField,
    AlertLand,
};

@interface LXAlertView : UIView

@property (nonatomic, assign) AlertType type;
@property (nonatomic, weak) id<LXAlertViewDelegate> delegate;


- (id)initWithAlertTitle:(NSString *)alertTitle
               AlertType:(AlertType)alertType;
- (void)show;

@end

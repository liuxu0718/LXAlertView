//
//  PSAlertView.h
//  PSAlertView
//
//  Created by 刘旭 on 15/10/21.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PSAlertViewBlock)(BOOL isConfirm);

@interface PSAlertView : UIView

@property (nonatomic, copy) PSAlertViewBlock confirmBlock;

- (id)initWithAlertTitle:(NSString *)alertTitle;
- (void)show;

@end

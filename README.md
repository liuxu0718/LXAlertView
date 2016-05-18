# LXAlertView

自定义的AlertView


初始化方法.
- (id)initWithAlertTitle:(NSString *)alertTitle
               AlertType:(AlertType)alertType

传值通过delegate
- (void)LXAlertViewClickButtonIndex:(NSInteger)buttonIndex Object:(NSString *)object 
//buttonIndex 1为确定 2为取消    object为textField.text的值.

show方法.
- (void)show

动画开始.
- (void)setStartState {

self.transform = CGAffineTransformMakeScale(0.01, 0.01);

}

动画结束.
- (void)setEndState {

self.transform = CGAffineTransformMakeScale(1.0, 1.0);

}

show时将会先调用动画开始方法, 在self即将添加到父视图时将会触发下面这个方法，进行蒙层的添加和动画结束的操作
- (void)willMoveToSuperview:(UIView *)newSuperview

源码不到200行, 这里只展示了四种样式, 可根据具体需求 重构UI 动效.
如果问题issue我或者将问题发到我的邮箱472443138@qq.com, 谢谢.

![image](https://github.com/liuxu0718/PSAlertView/blob/master/screenshot.gif)

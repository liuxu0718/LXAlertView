# LXAlertView

自定义的AlertView


### 初始化方法.（init）
- (id)initWithTitle:(NSString *)title 
               Type:(LXAlertViewType)type

### 传值通过delegate (result)
- (void)lxAlertView:(LXAlertView *)alertView withButtonIndex:(NSInteger)buttonIndex withObject:(NSString *)object 
//buttonIndex 1为确定 2为取消  object为textField.text的值.

### show方法. （show）
- (void)show

### 动画开始. (startAnimation)
- (void)setStartState {

self.transform = CGAffineTransformMakeScale(0.01, 0.01);

}

### 动画结束.(endAnimation)
- (void)setEndState {

self.transform = CGAffineTransformMakeScale(1.0, 1.0);

}

### 原理：show时将会先调用动画开始方法, 在self即将添加到父视图时将会触发下面这个方法，进行蒙层的添加和动画结束的操作
- (void)willMoveToSuperview:(UIView *)newSuperview

### 源码不到200行, 这里只展示了四种样式, 可根据具体需求重构UI和动效.从设计上还有一些不足，如果问题issue我或者将问题发到我的邮箱472443138@qq.com, 谢谢.

![image](https://github.com/liuxu0718/LXAlertView/blob/master/screenshot.gif)

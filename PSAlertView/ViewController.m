//
//  ViewController.m
//  PSAlertView
//
//  Created by 刘旭 on 15/10/21.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "ViewController.h"
#import "LXAlertView.h"
@interface ViewController ()
{
    NSArray *_dataArray;
}

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _dataArray = @[@"AlertDefault", @"AlertSelect", @"AlertTextField", @"AlertLand"];

    for (int i = 0; i < _dataArray.count; i++) {
        UIButton *showButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        showButton.center = CGPointMake(self.view.center.x, 50 * (i + 3));
        [showButton setTitle:_dataArray[i] forState:UIControlStateNormal];
        showButton.tag = i + 1;
        showButton.backgroundColor = [UIColor grayColor];
        [showButton addTarget:self action:@selector(showButtonAction:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:showButton];
    }
}

- (void)showButtonAction:(UIButton *)sender {
    LXAlertView *alert = [[LXAlertView alloc]initWithAlertTitle:@"Hello World" WithAlertType:sender.tag];
    [alert show];
    alert.block = ^(BOOL isConfirm, NSString *text) {
        if (isConfirm) {
            NSLog(@"%@\n%@", @"true", text);
        }
        else {
            NSLog(@"%@\n%@", @"false", text);
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

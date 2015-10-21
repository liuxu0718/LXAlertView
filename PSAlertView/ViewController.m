//
//  ViewController.m
//  PSAlertView
//
//  Created by 刘旭 on 15/10/21.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "ViewController.h"
#import "PSAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *showButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    showButton.center = self.view.center;
    [showButton setTitle:@"show" forState:UIControlStateNormal];
    showButton.backgroundColor = [UIColor grayColor];
    [showButton addTarget:self action:@selector(showButtonAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:showButton];
}

- (void)showButtonAction {
    PSAlertView *alert = [[PSAlertView alloc]initWithAlertTitle:@"Hello World"];
    [alert show];
    alert.confirmBlock = ^(BOOL isConfirm) {
        if (isConfirm) {
            NSLog(@"yes");
        }
        else {
            NSLog(@"no");
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

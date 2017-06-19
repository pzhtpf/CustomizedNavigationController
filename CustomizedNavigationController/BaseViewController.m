//
//  BaseViewController.m
//  CustomizedNavigationController
//
//  Created by tianpengfei on 2017/6/18.
//  Copyright © 2017年 tianpengfei. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)viewControllerShouldPop{
    return true;
}
@end

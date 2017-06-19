//
//  AOPInterceptViewController.m
//  CustomizedNavigationController
//
//  Created by Roc.Tian on 2017/6/19.
//  Copyright © 2017年 tianpengfei. All rights reserved.
//

#import "AOPInterceptViewController.h"

@interface AOPInterceptViewController ()

@end

@implementation AOPInterceptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)viewControllerShouldPop{

    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:nil message:@"确定退出吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertViewController addAction:cancelAction];
    
    UIAlertAction *surelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    [alertViewController addAction:surelAction];
    
    [self presentViewController:alertViewController animated:YES completion:^{
        
    }];
    
    return NO;
}
@end

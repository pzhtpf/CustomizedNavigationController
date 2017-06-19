//
//  CustomizedNavigationController.m
//  CustomizedNavigationController
//
//  Created by tianpengfei on 2017/6/18.
//  Copyright © 2017年 tianpengfei. All rights reserved.
//

#import "CustomizedNavigationController.h"
#import <objc/runtime.h>

@interface CustomizedNavigationController ()

@property(strong,nonatomic) NSMutableDictionary *controllerForButton;

@end

@implementation CustomizedNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.controllerForButton = [[NSMutableDictionary alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    NSLog(@"className:%s",object_getClassName(viewController));
    if([viewController isKindOfClass:[BaseViewController class]])
        [self setBackBarButtonItem:viewController];
    else
        NSLog(@"必须是 BaseViewController 的子类");
        
}
-(UIButton *)setBackBarButtonItem:(UIViewController *)viewController{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(15, 7, 30, 30);
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 0);
    UIImage *image = [[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [leftBtn setImage:image forState:UIControlStateNormal];
    leftBtn.tintColor = [UIColor blackColor];
    
    [leftBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    NSString *className = [NSString stringWithFormat:@"%s", object_getClassName(viewController)];
    objc_setAssociatedObject(leftBtn,@"className", className, OBJC_ASSOCIATION_RETAIN);
    
    [self.controllerForButton setObject:viewController forKey:className];
    
    return leftBtn;
}
-(void)backAction:(UIButton *)button{
   NSString *className = objc_getAssociatedObject(button, @"className");
    BaseViewController *baseViewController = (BaseViewController *)[self.controllerForButton valueForKey:className];
    if([baseViewController  viewControllerShouldPop]){
    
        [self popViewControllerAnimated:YES];
    }
    
}
@end

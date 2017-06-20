//
//  YDSETBackBarButtonItem.m
//  AtourLife
//
//  Created by Roc.Tian on 2017/6/16.
//  Copyright © 2017年 Anasue. All rights reserved.
//

#import "YDSETBackBarButtonItem.h"
#import <Aspects/Aspects.h>
#import <objc/runtime.h>

@interface YDSETBackBarButtonItem ()

@property(strong,nonatomic) NSMutableDictionary *controllerForButton;

@end

@implementation YDSETBackBarButtonItem
-(id)init{

    self = [super init];
    if(self){
        
        NSError *error;
        [UINavigationController aspect_hookSelector:@selector(pushViewController:animated:)
                                        withOptions:AspectPositionAfter
                                         usingBlock:^(id <AspectInfo> aspectInfo){
                                              UINavigationController *navigationController = aspectInfo.instance;
                                             if(navigationController.viewControllers.count>0){
                                                 UIViewController *viewController = navigationController.viewControllers[navigationController.viewControllers.count-1];
                                                 [self setBackBarButtonItem:viewController];
                                             }
                                             
                                         }
                                              error:&error];
    }
    return self;
}
-(UIButton *)setBackBarButtonItem:(UIViewController *)viewController{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(15, 7, 30, 30);
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 0);
    UIImage *image = [[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [leftBtn setImage:image forState:UIControlStateNormal];
    leftBtn.tintColor = [UIColor redColor];
    
    [leftBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    NSString *className = [NSString stringWithFormat:@"%s", object_getClassName(viewController)];
    objc_setAssociatedObject(leftBtn,@"className", className, OBJC_ASSOCIATION_RETAIN);
    
    [self.controllerForButton setObject:viewController forKey:className];
    
    return leftBtn;
}
-(void)backAction:(UIButton *)button{
    NSString *className = objc_getAssociatedObject(button, @"className");
    UIViewController *viewController = [self.controllerForButton valueForKey:className];
    
    NSString *selectorName = @"viewControllerShouldPop";
    SEL s = NSSelectorFromString(selectorName);
   
    if([viewController respondsToSelector:s]){
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
       BOOL flag =  [viewController performSelector:s];
#pragma clang diagnostic pop
        if(flag)
            [self popViewController:viewController];
    }
    else{
    
        [self popViewController:viewController];
    }
}
-(void)popViewController:(UIViewController *)viewController{

    if(viewController.navigationController.viewControllers.count>1){
        
        [viewController.navigationController popViewControllerAnimated:YES];
    }
    else{
        [viewController.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
#pragma mark getter
-(NSMutableDictionary *)controllerForButton{
    if(!_controllerForButton){
        _controllerForButton = [NSMutableDictionary new];
    }
    return _controllerForButton;
}
@end

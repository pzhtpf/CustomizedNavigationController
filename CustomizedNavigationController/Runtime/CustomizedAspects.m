//
//  CustomizedAspects.m
//  CustomizedNavigationController
//
//  Created by Roc.Tian on 2017/6/20.
//  Copyright © 2017年 tianpengfei. All rights reserved.
//

#import "CustomizedAspects.h"
#import <objc/runtime.h>

@implementation CustomizedAspects

+(void)aspect_hookSelector:(SEL)selector block:(void (^)(id))block{

    Method hookSelector = class_getInstanceMethod(self, selector);
    
    NSString *selectorName = @"customizedSelector:";
    SEL s = NSSelectorFromString(selectorName);
    
    Method customizedSelector = class_getInstanceMethod(self, s);
    
    method_exchangeImplementations(hookSelector, customizedSelector);
    
    objc_setAssociatedObject(self, @"aspect_block", block, OBJC_ASSOCIATION_RETAIN);
}
-(void)customizedSelector:(id)sender{
    [self customizedSelector:sender];
 
    Block block = objc_getAssociatedObject(self, @"aspect_block");
    if(block)
        block(self);
}
@end

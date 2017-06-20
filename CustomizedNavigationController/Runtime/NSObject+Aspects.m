//
//  NSObject+Aspects.m
//  CustomizedNavigationController
//
//  Created by Roc.Tian on 2017/6/20.
//  Copyright © 2017年 tianpengfei. All rights reserved.
//

#import "NSObject+Aspects.h"
#import <objc/runtime.h>

static char aspect_blockKey;

@implementation NSObject (Aspects)

+(AspectsInfo *)aspect_hookSelector:(SEL)selector block:(void (^)(id))block{
    
    Method hookSelector = class_getInstanceMethod(self, selector);
    
    NSString *selectorName = @"customizedSelector:";
    SEL s = NSSelectorFromString(selectorName);
    
    Method customizedSelector = class_getInstanceMethod(self, s);
    
    method_exchangeImplementations(hookSelector, customizedSelector);
    
    AspectsInfo *aspectsInfo = [[AspectsInfo alloc] init];
    aspectsInfo.block = block;
    
//    objc_setAssociatedObject(self, &aspect_blockKey, aspectsInfo, OBJC_ASSOCIATION_RETAIN);
    setblock(self, block, s);
    
    return aspectsInfo;
}
-(void)customizedSelector:(id)sender{
    [self customizedSelector:sender];
    
    NSString *selectorName = @"customizedSelector:";
    SEL s = NSSelectorFromString(selectorName);
    
    Block block4 = getblock(self, s);
    AspectsInfo *aspectsInfo = objc_getAssociatedObject(self,&aspect_blockKey);
    id x = objc_getAssociatedObject(self, &aspect_blockKey);
    Block block = objc_getAssociatedObject(self, &aspect_blockKey);
    if(block)
        block(self);
}

static void setblock(NSObject *self,Block block, SEL selector){
    objc_setAssociatedObject(self,selector, block, OBJC_ASSOCIATION_RETAIN);
}
static Block getblock(NSObject *self, SEL selector){
    Block block = objc_getAssociatedObject(self, selector);
    return block;
}
@end

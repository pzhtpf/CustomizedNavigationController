//
//  NSObject+Aspects.m
//  CustomizedNavigationController
//
//  Created by Roc.Tian on 2017/6/20.
//  Copyright © 2017年 tianpengfei. All rights reserved.
//

#import "NSObject+Aspects.h"
#import <objc/runtime.h>

@implementation NSObject (Aspects)

+(void)aspect_hookSelector:(SEL)selector block:(void (^)(AspectsInfo *))block{
    
    Method hookSelector = class_getInstanceMethod(self, selector);
    
    NSString *selectorName = @"customizedSelector:";
    SEL s = NSSelectorFromString(selectorName);
    
    Method customizedSelector = class_getInstanceMethod(self, s);
    
    method_exchangeImplementations(hookSelector, customizedSelector);
    
    NSString *className = NSStringFromClass(self);
    NSString *exchangeSelectorName = NSStringFromSelector(selector);
    
    NSString *blockKey = [NSString stringWithFormat:@"%@_%@",className,exchangeSelectorName];
    
    AspectsBlock *aspectsBlock = [AspectsBlock shareInstance];  // 利用单例存储block，因为切点是某个类中的某个方法，所以key的值组装成 className_selectorName 的形式
    [aspectsBlock.block setObject:block forKey:blockKey];
}
-(void)customizedSelector:(id)sender{
    [self customizedSelector:sender];   // 执行系统原有的方法，应为已经被我们替换，所以如此调用
    
    // 以下为找出存储在单例中的block，回调通知，去执行我们写在block中的代码片段
    NSString *className = [NSString stringWithFormat:@"%s", object_getClassName(self)];
    NSString *exchangeSelectorName = NSStringFromSelector(_cmd);
    NSString *blockKey = [NSString stringWithFormat:@"%@_%@",className,exchangeSelectorName];
    
    AspectsBlock *aspectsBlock = [AspectsBlock shareInstance];
    Block block = [aspectsBlock.block valueForKey:blockKey];
    
    AspectsInfo *aspectsInfo = [[AspectsInfo alloc] init];
    aspectsInfo.instance = self;
    aspectsInfo.pushController = sender;
    
    if(block)
        block(aspectsInfo);
}
@end

@implementation AspectsBlock

+(instancetype)shareInstance{
    static AspectsBlock *aspectsBlock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        aspectsBlock = [[AspectsBlock alloc]init];
    });
    return aspectsBlock;
}
-(NSMutableDictionary *)block{
    if(!_block){
        _block = [NSMutableDictionary new];
    }
    return _block;
}
@end

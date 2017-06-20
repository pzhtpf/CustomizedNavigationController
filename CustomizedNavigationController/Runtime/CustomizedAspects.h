//
//  CustomizedAspects.h
//  CustomizedNavigationController
//
//  Created by Roc.Tian on 2017/6/20.
//  Copyright © 2017年 tianpengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Block)(id object);

@interface CustomizedAspects : NSObject

+(void)aspect_hookSelector:(SEL)selector block:(Block) block;

@end

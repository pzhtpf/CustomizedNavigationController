//
//  NSObject+Aspects.h
//  CustomizedNavigationController
//
//  Created by Roc.Tian on 2017/6/20.
//  Copyright © 2017年 tianpengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AspectsInfo.h"

typedef void(^Block)(AspectsInfo *aspectsInfo);

@interface NSObject (Aspects)

+(void)aspect_hookSelector:(SEL)selector block:(Block) block;

@end

@interface AspectsBlock : NSObject

@property(nonatomic) NSMutableDictionary *block;

+(instancetype)shareInstance;

@end

//
//  YDSETBackBarButtonItem.h
//  AtourLife
//
//  Created by Roc.Tian on 2017/6/16.
//  Copyright © 2017年 Anasue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YDSETBackBarButtonItem : NSObject

/** 过滤器，添加不需要设置的类名，为字符串 */
@property(strong,nonatomic) NSMutableArray *filter;
/** 给某个类设置返回箭头的颜色，默认为黑色 */
@property(strong,nonatomic) NSMutableDictionary *backIndicatorColor;

@end

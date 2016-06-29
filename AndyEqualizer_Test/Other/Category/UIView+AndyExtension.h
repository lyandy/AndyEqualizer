//
//  UIView+AndyExtension.h
//  Mrs_Sister
//
//  Created by 李扬 on 16/5/24.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AndyExtension)
//
@property (nonatomic, assign) CGSize andy_Size;
@property (nonatomic, assign) CGFloat andy_Width;
@property (nonatomic, assign) CGFloat andy_Height;
@property (nonatomic, assign) CGFloat andy_X;
@property (nonatomic, assign) CGFloat andy_Y;
@property (nonatomic, assign) CGFloat andy_CenterX;
@property (nonatomic, assign) CGFloat andy_CenterY;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 可以在分类 Category 中声明 @property 属性。但此时的属性声明只会生成方法的声明，不会生成方法的实现和带有_下划线的成员变量 */

@end

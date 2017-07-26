//
//  UINavigationBar+Awesome.h
//
//  Created by yanghuang on 2017/6/24.
//  Copyright © 2017年 com.yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Custom)
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lt_setLineColor:(UIColor *)color;
- (void)lt_setElementsAlpha:(CGFloat)alpha;
//不能和 lt_setBackgroundColor 一起在scroll环境用
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset;
@end

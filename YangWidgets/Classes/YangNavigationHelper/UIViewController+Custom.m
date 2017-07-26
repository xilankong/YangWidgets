//
//  UIViewController+RTNavigationBar.m
//  PersonalResume
//  扩展使用
//  Created by yanghuang on 2017/6/24.
//  Copyright © 2017年 com.yang. All rights reserved.
//

#import "UIViewController+Custom.h"
#import <objc/runtime.h>
#import "YangNavigationHelper.h"

#define textColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0]
#define lineColor [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]

static NSInteger const kCATCustomExcludeAlphaTag = 999012;

@implementation UIViewController (Custom)
@dynamic rt_lightContentBar;
@dynamic rt_backButton;

- (void)setRt_lightContentBar:(BOOL)rt_lightContentBar {
    objc_setAssociatedObject(self, @selector(rt_lightContentBar), @(rt_lightContentBar), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)rt_lightContentBar {
    return  [objc_getAssociatedObject(self, @selector(rt_lightContentBar)) boolValue];
}

- (void)setRt_backButton:(UIButton *)rt_backButton {
     objc_setAssociatedObject(self, @selector(rt_backButton), rt_backButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIButton *)rt_backButton {
    return (UIButton *)objc_getAssociatedObject(self, @selector(rt_backButton));
}

//自定义返回按钮
- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    
    UIButton *hisButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hisButton.tag = kCATCustomExcludeAlphaTag;
    hisButton.frame = CGRectMake(0, 0, 25, 25);
    [hisButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    if (self.preferredStatusBarStyle == UIStatusBarStyleLightContent) {
        [hisButton setImage:[UIImage imageNamed:@"whitearrow" inBundle:NavBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [hisButton setImage:[UIImage imageNamed:@"whitearrow" inBundle:NavBundle compatibleWithTraitCollection:nil] forState:UIControlStateSelected];
    } else {
        [hisButton setImage:[UIImage imageNamed:@"blackarrow" inBundle:NavBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [hisButton setImage:[UIImage imageNamed:@"blackarrow" inBundle:NavBundle compatibleWithTraitCollection:nil] forState:UIControlStateSelected];
    }
    [hisButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.rt_backButton = hisButton;
    return  [[UIBarButtonItem alloc]initWithCustomView:hisButton];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    if (self.rt_lightContentBar) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (void)rt_navigationBackgroundColor:(UIColor *)color {
    [self.navigationController.navigationBar lt_setBackgroundColor:color];
}

- (void)rt_navigationTranslationY:(CGFloat)positionY {
    [self.navigationController.navigationBar lt_setTranslationY:positionY];
}

#pragma mark 用于一些有透明头部的页面滑动时产生的statusBar色值影响的变更。

- (void)rt_navigationStatusBarStatus:(UIStatusBarStyle)style {
    if (style == [self preferredStatusBarStyle]) {
        return;
    }
    if (style == UIStatusBarStyleDefault) {
        if (self.navigationController) {
            self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : textColor};
            self.rt_lightContentBar = NO;
            [self.navigationController.navigationBar lt_setLineColor:lineColor];
            if (self.rt_backButton) {
                [self.rt_backButton setImage:[UIImage imageNamed:@"blackarrow" inBundle:NavBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
                [self.rt_backButton setImage:[UIImage imageNamed:@"blackarrow" inBundle:NavBundle compatibleWithTraitCollection:nil] forState:UIControlStateSelected];
            }
        }
    } else {
        if (self.navigationController) {
            self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor  whiteColor]};
            self.rt_lightContentBar = YES;
            [self.navigationController.navigationBar lt_setLineColor:[UIColor clearColor]];
            if (self.rt_backButton) {
                [self.rt_backButton setImage:[UIImage imageNamed:@"whitearrow" inBundle:NavBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
                [self.rt_backButton setImage:[UIImage imageNamed:@"whitearrow" inBundle:NavBundle compatibleWithTraitCollection:nil] forState:UIControlStateSelected];
            }
        }
    }
    [self setNeedsStatusBarAppearanceUpdate];
}

@end

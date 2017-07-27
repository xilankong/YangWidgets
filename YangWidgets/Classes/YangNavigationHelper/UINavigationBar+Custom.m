//
//  UINavigationBar+Awesome.m
//
//  Created by yanghuang on 2017/6/24.
//  Copyright © 2017年 com.yang. All rights reserved.
//

#import "UINavigationBar+Custom.h"
#import <objc/runtime.h>

@implementation UINavigationBar (Custom)
static char overlayKey;
static char overlayLineKey;

//颜色覆盖层
- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//底线
- (UIView *)overlayLine
{
    return objc_getAssociatedObject(self, &overlayLineKey);
}

- (void)setOverlayLine:(UIView *)overlayLine
{
    objc_setAssociatedObject(self, &overlayLineKey, overlayLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = [UIImage new];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight` !!! ???
        
        self.overlayLine = [[UIView alloc]initWithFrame:CGRectMake(0, (CGRectGetHeight(self.bounds) + 20) - 1.0 / [UIScreen mainScreen].scale , CGRectGetWidth(self.bounds), 1.0 / [UIScreen mainScreen].scale)];
        self.overlayLine.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        self.overlayLine.userInteractionEnabled = NO;
        
        [self.overlay addSubview:self.overlayLine];
        self.backgroundColor = backgroundColor;
        [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}
- (void)lt_setLineColor:(UIColor *)color {
    if (self.overlayLine) {
        self.overlayLine.backgroundColor = color;
    }
}

- (void)lt_setTranslationY:(CGFloat)translationY
{
    //_UIBarBackground属于动态部署 的Y值等于self的Y值
    //_UIBarBackground.height +_UIBarBackground.y = 44
    //我们需要计算的时overlay的高度，当navigation刷新的时候
    //会进行frame上的变化，变成自适应size，但是当刷新的时候，继续变更self、的translationY就会发现问题，_UIBarBackground的frame不再变成原样。
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
    CGFloat selfY = -(64 + translationY);
    
    UIView *barbg = [self.subviews firstObject];
    if (selfY > 0) {
        barbg.frame = CGRectMake(0, 0, barbg.frame.size.width,44);
    } else {
        barbg.frame = CGRectMake(0, 44 + selfY, barbg.frame.size.width,-selfY);
    }
    self.overlay.frame = CGRectMake(0, 0, self.frame.size.width,barbg.frame.size.height);
}

- (void)lt_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
//    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
        }
        if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]) {
            obj.alpha = alpha;
        }
    }];
}

- (void)lt_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

@end

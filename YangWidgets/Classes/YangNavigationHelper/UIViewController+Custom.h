//
//  UIViewController+RTNavigationBar.h
//  PersonalResume
//
//  Created by yanghuang on 2017/6/24.
//  Copyright © 2017年 com.yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+Custom.h"
#import "RTRootNavigationController.h"
@interface UIViewController (Custom)

IB_DESIGNABLE
/*!
 *  @brief use to control the statusBarStatus
 */
@property (nonatomic, assign) IBInspectable BOOL rt_lightContentBar;

@property (nonatomic, strong) UIButton *rt_backButton;
/**
 @brief use to change the total nav color status
 
 @param style statusBarStatus
 */
- (void)rt_navigationStatusBarStatus:(UIStatusBarStyle)style;

/**
 @brief use to change the navigation backgroundColor
 
 @param color UIColor
 */
- (void)rt_navigationBackgroundColor:(UIColor *)color;


/**
 @brief use to change the navigation positionY
 
 @param positionY CGFloat
 */
- (void)rt_navigationTranslationY:(CGFloat)positionY;
@end

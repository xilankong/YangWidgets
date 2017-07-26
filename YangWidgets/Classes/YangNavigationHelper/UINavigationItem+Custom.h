//
//  UINavigationItem+Custom.h
//  Pods
//  导航条item变更操作集
//  Created by yanghuang on 2017/7/26.
//
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (Custom)


/**
 添加黑色返回按钮

 @param target 事件目标
 @param action 事件
 */
- (void)addBlackBackButtonItemWithTarget:(id)target action:(SEL)action;

/**
 添加白色返回按钮
 
 @param target 事件目标
 @param action 事件
 */
- (void)addWhiteBackButtonItemWithTarget:(id)target action:(SEL)action;


/**
  添加左边图标按钮

 @param target 事件目标
 @param action 事件
 @param image 正常状态图标
 @param hightLightImage 高亮状态图标
 */
- (void)addLeftImageButtonItemWithTarget:(id)target action:(SEL)action andImage:(UIImage *) image andHightLightImage:(UIImage *)hightLightImage;


/**
 添加左边自定义文字按钮

 @param target 事件目标
 @param action 事件
 @param text 按钮文案
 */
- (UIButton *)addLeftTextButtonItemWithTarget:(id)target action:(SEL)action andText:(NSString *)text;


/**
  添加左边黑色文字按钮

 @param target 事件目标
 @param action 事件
 @param text 按钮文案
 @param font 按钮文案字体
 */
- (void)addBlackLeftTextButtonItemWithTarget:(id)target action:(SEL)action andText:(NSString *)text andFont:(UIFont *)font;

/**
 添加左边白色文字按钮
 
 @param target 事件目标
 @param action 事件
 @param text 按钮文案
 @param font 按钮文案字体
 */
- (void)addWhiteLeftTextButtonItemWithTarget:(id)target action:(SEL)action andText:(NSString *)text andFont:(UIFont *)font;

/**
 添加左边自定义区域

 @param target 事件目标
 @param action 事件
 @param leftView 左边View
 */
- (void)addLeftItemWithTarget:(id)target action:(SEL)action andView:(UIView *)leftView;

/**
 添加右边图标按钮

 @param target 事件目标
 @param action 事件
 @param image 正常状态图标
 @param hightLightImage 高亮状态图标
 */
- (void)addRightImageButtonItemWithTarget:(id)target action:(SEL)action andImage:(UIImage *) image andHightLightImage:(UIImage *)hightLightImage;

/**
 添加右边自定义文字按钮
 
 @param target 事件目标
 @param action 事件
 @param text 按钮文案
 */
- (UIButton *)addRightTextButtonItemWithTarget:(id)target action:(SEL)action andText:(NSString *)text;

/**
 添加右边白色文字按钮

 @param target 事件目标
 @param action 事件
 @param text 按钮文案
 @param font 按钮文案字号
 */
- (void)addWhiteRightTextButtonItemWithTarget:(id)target action:(SEL)action andText:(NSString *)text andFont:(UIFont *)font;

/**
 添加右边黑色文字按钮
 
 @param target 事件目标
 @param action 事件
 @param text 按钮文案
 @param font 按钮文案字号
 */
- (void)addBlackRightTextButtonItemWithTarget:(id)target action:(SEL)action andText:(NSString *)text andFont:(UIFont *)font;

/**
 添加右边自定义区域
 
 @param target 事件目标
 @param action 事件
 @param leftView 左边View
 */
- (void)addRightItemWithTarget:(id)target action:(SEL)action andView:(UIView *)rightView;


@end

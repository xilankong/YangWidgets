// 原作： rickytan <ricky.tan.xin@gmail.com>
//
// 在原基础上进行添加适用

#import <UIKit/UIKit.h>

@class RTRootNavigationController;

@protocol RTNavigationItemCustomizable <NSObject>

@optional

/*!
 *  @brief Override this method to provide a custom back bar item, default is a normal @c UIBarButtonItem with title @b "Back"
 *
 *  @param target the action target
 *  @param action the pop back action
 *
 *  @return a custom UIBarButtonItem
 */
- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action;

@end

IB_DESIGNABLE
@interface UIViewController (RTRootNavigationController) <RTNavigationItemCustomizable>

/*!
 *  @brief set this property to @b YES to disable interactive pop
 */
@property (nonatomic, assign) IBInspectable BOOL rt_disableInteractivePop;

/*!
 *  @brief @c self\.navigationControlle will get a wrapping @c UINavigationController, use this property to get the real navigation controller
 */
@property (nonatomic, readonly, strong) RTRootNavigationController *rt_navigationController;

/*!
 *  @brief Override this method to provide a custom subclass of @c UINavigationBar, defaults return nil
 *
 *  @return new UINavigationBar class
 */
- (Class)rt_navigationBarClass;

/*!
 *  @brief set a modalControllerWay if the modalVC need Navigation
 *
 */
- (void)modalViewController:(UIViewController *)viewController needNavigation:(BOOL) navNeed sender:(id) sender;
@end

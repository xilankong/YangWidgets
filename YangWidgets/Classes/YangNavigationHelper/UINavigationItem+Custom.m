//
//  UINavigationItem+Custom.m
//  Pods
//
//  Created by yanghuang on 2017/7/26.
//
//

#import "UINavigationItem+Custom.h"
#import "YangNavigationHelper.h"

@implementation UINavigationItem (Custom)

- (void)addBackButtonItemWithTarget:(id)target action:(SEL)action andImageNamed:(NSString *) imageName andHightLightImageNamed:(NSString *)hightLightImageName {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 25, 25);
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [backButton setImage:[UIImage imageNamed:imageName inBundle:NavBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:hightLightImageName inBundle:NavBundle compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.leftBarButtonItems = nil;
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)addBlackBackButtonItemWithTarget:(id)target action:(SEL)action {
    [self addBackButtonItemWithTarget:target action:action andImageNamed:@"blackarrow" andHightLightImageNamed:@"blackarrow"];
}

- (void)addWhiteBackButtonItemWithTarget:(id)target action:(SEL)action {
    [self addBackButtonItemWithTarget:target action:action andImageNamed:@"whitearrow" andHightLightImageNamed:@"whitearrow"];
}

- (void)addLeftImageButtonItemWithTarget:(id)target action:(SEL)action andImage:(UIImage *) image andHightLightImage:(UIImage *)hightLightImage {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftButton setImage:image forState:UIControlStateNormal];
    [leftButton setImage:hightLightImage forState:UIControlStateHighlighted];
    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.leftBarButtonItems = nil;
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (UIButton *)addLeftTextButtonItemWithTarget:(id)target action:(SEL)action andText:(NSString *)text  {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:17];
    CGRect frame = [text boundingRectWithSize:CGSizeMake(100, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:leftButton.titleLabel.font} context:nil];
    leftButton.frame = frame;
    [leftButton setTitle:text forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[[UIColor blueColor] colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    return leftButton;
}

- (void)addBlackLeftTextButtonItemWithTarget:(id)target action:(SEL)action andText:(NSString *)text andFont:(UIFont *)font {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.titleLabel.font = font;
    CGRect frame = [text boundingRectWithSize:CGSizeMake(100, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:leftButton.titleLabel.font} context:nil];
    leftButton.frame = frame;
    [leftButton setTitle:text forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.7] forState:UIControlStateHighlighted];
    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)addWhiteLeftTextButtonItemWithTarget:(id)target action:(SEL)action andText:(NSString *)text andFont:(UIFont *)font {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.titleLabel.font = font;
    CGRect frame = [text boundingRectWithSize:CGSizeMake(100, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:leftButton.titleLabel.font} context:nil];
    leftButton.frame = frame;
    [leftButton setTitle:text forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)addLeftItemWithTarget:(id)target action:(SEL)action andView:(UIView *)leftView {
    leftView.userInteractionEnabled = NO;
    CGFloat height = 44;
    if (leftView.frame.size.height < 44) {
        height = leftView.frame.size.height;
    }
    leftView.frame = CGRectMake(0, 0, leftView.frame.size.width, height);
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton addSubview:leftView];
    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0, 0, leftView.frame.size.width, height);
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];    
}

- (void)addRightImageButtonItemWithTarget:(id)target action:(SEL)action andImage:(UIImage *) image andHightLightImage:(UIImage *)hightLightImage {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 25, 25);
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton setImage:hightLightImage forState:UIControlStateHighlighted];
    [rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (UIButton * _Nonnull)addRightTextButtonItemWithTarget:(id)target action:(SEL)action andText:(NSString *)text {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:17];
    CGRect frame = [text boundingRectWithSize:CGSizeMake(100, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:rightButton.titleLabel.font} context:nil];
    rightButton.frame = frame;
    [rightButton setTitle:text forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[[UIColor blueColor] colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
    [rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    return rightButton;
}

- (void)addWhiteRightTextButtonItemWithTarget:(id)target action:(SEL)action andText:(NSString *)text andFont:(UIFont *)font {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.font = font;
    CGRect frame = [text boundingRectWithSize:CGSizeMake(100, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:rightButton.titleLabel.font} context:nil];
    rightButton.frame = frame;
    [rightButton setTitle:text forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
    [rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)addBlackRightTextButtonItemWithTarget:(id)target action:(SEL)action andText:(NSString *)text andFont:(UIFont *)font {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.font = font;
    CGRect frame = [text boundingRectWithSize:CGSizeMake(100, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:rightButton.titleLabel.font} context:nil];
    rightButton.frame = frame;
    [rightButton setTitle:text forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.7] forState:UIControlStateHighlighted];
    [rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)addRightItemWithTarget:(id)target action:(SEL)action andView:(UIView *)rightView {
    rightView.userInteractionEnabled = NO;
    CGFloat height = 44;
    if (rightView.frame.size.height < 44) {
        height = rightView.frame.size.height;
    }
    rightView.frame = CGRectMake(0, 0, rightView.frame.size.width, height);
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton addSubview:rightView];
    [rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(0, 0, rightView.frame.size.width, height);
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}


@end

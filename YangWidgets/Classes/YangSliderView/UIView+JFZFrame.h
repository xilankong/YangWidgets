//
//  UIView+frame.h
//  GXQApp
//
//  Created by jinfuzi on 14-2-24.
//  Copyright (c) 2014年 jinfuzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JFZFrame)

+ (id)viewWithNib:(NSString*)nib owner:(id)owner;

- (float)left;

- (float)top;

- (float)right;

- (float)bottom;

- (float)width;

- (float)height;

- (CGSize)size;

- (void)setLeft:(float)left;

- (void)setRight:(float)right;

- (void)setTop:(float)top;

- (void)setBottom:(float)bottom;

- (void)setPosition:(CGPoint)position;

- (void)offset:(CGPoint)offset;

- (void)setWidth:(float)width;

- (void)setHeight:(float)height;

- (void)setSize:(CGSize)size;

- (CGPoint)boundsCenter;

- (UIView*)viewAtIndex:(int)index;

- (int)indexOfView:(UIView*)view;

- (void)clearSubviews;

- (UITapGestureRecognizer*)addTapGestureRecognizer:(id)target forAction:(SEL)action;

- (void)layoutSubviewsInCenter;

@end

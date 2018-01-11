//
//  UIView+frame.m
//  GXQApp
//
//  Created by jinfuzi on 14-2-24.
//  Copyright (c) 2014年 jinfuzi. All rights reserved.
//

#import "UIView+JFZFrame.h"

@implementation UIView (frame)

+(id) viewWithNib:(NSString*)nib owner:(id)owner {
    NSArray* array =[[NSBundle mainBundle] loadNibNamed:nib owner:owner options:nil];
    return [array objectAtIndex:0];
}

-(float) left {
    return self.frame.origin.x;
}

-(float) top {
    return self.frame.origin.y;
}

-(float) right {
    return [self left] + [self width];
}

-(float) bottom {
    return [self top] + [self height];
}

-(float) width {
    return self.frame.size.width;
}

-(float) height {
    return self.frame.size.height;
}

-(CGSize) size {
    return self.frame.size;
}

-(void) setLeft:(float)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

-(void) setRight:(float)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

-(void) setTop:(float)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

-(void) setBottom:(float)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

-(void) setPosition:(CGPoint)position {
    CGRect frame = self.frame;
    frame.origin = position;
    self.frame = frame;
}

-(void)offset:(CGPoint)offset {
    CGRect frame = self.frame;
    self.frame = CGRectOffset(frame, offset.x, offset.y);
}

-(void) setWidth:(float)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(void) setHeight:(float)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(CGPoint)boundsCenter {
    CGSize size = self.bounds.size;
    return CGPointMake(size.width/2, size.height/2);
}

-(UIView*) viewAtIndex:(int)index {
    NSArray* subviews = self.subviews;
    if (index >= 0 && index < subviews.count) {
        return [subviews objectAtIndex:index];
    }
    return nil;
}

-(int) indexOfView:(UIView*)view {
    return (int)[self.subviews indexOfObject:view];
}

-(void) clearSubviews {
    id subviews = self.subviews;
    int count = (int)[subviews count];
    for (int i = 0; i < count; i++) {
        [[subviews objectAtIndex:i] removeFromSuperview];
    }
}

-(void) layoutSubviewsInCenter {
    float width = 0;
    for (UIView* view in self.subviews) {
        width += [view width];
    }
    float offx = ([self width] - width) / 2;
    float offy = [self height] / 2;
    for (UIView* view in self.subviews) {
        float w = [view width];
        view.center = CGPointMake(offx + w / 2, offy);
        offx += w;
    }
}

-(UITapGestureRecognizer*)addTapGestureRecognizer:(id)target forAction:(SEL)action {
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:
                                          target action:action];
    [self addGestureRecognizer:recognizer];
    return recognizer;
}

@end

//
//  YangSlideMenu.h
//  yangCategory
//
//  Created by yanghuang on 2017/7/25.
//  Copyright © 2017年 young.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YangSlideMenuView;
@protocol YangSlideMenuViewDelegate <NSObject>
- (void)menuView:(YangSlideMenuView *) menuView clickActionAtIndex:(NSInteger) index;
@end

@interface YangSlideMenuView : UIScrollView

@property (nonatomic, strong) UIColor *labelSelectColor;
@property (nonatomic, strong) UIColor *labelUnSelectColor;
@property (nonatomic, weak) id<YangSlideMenuViewDelegate> slideDelegate;

- (void)updateViewWithDataArray:(NSArray *) data;

@end

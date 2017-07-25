//
//  YangSlideMenu.h
//  yangCategory
//
//  Created by yanghuang on 2017/7/25.
//  Copyright © 2017年 young.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YangSlideLabel;
@protocol YangSlideMenuViewDelegate <NSObject>

- (void)yang_menuItemClickAction:(YangSlideLabel *) label;

@end

@interface YangSlideLabel : UILabel

@end

@interface YangSlideMenuView : UIScrollView

@property (nonatomic, strong) UIColor *labelSelectColor;
@property (nonatomic, strong) UIColor *labelUnSelectColor;
@property (nonatomic, weak) id<YangSlideMenuViewDelegate> delegate;

- (void)updateViewWithDataArray:(NSArray *) data;

@end

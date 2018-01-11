//
//  JFZMutiBtnContainer.h
//  JinFuZiApp
//
//  Created by 嘉维 陈 on 15/8/31.
//  Copyright (c) 2015年 com.jinfuzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+JFZFrame.h"
//此协议与对象方法addBtnTarget根据需求选择用其中一个
//btn的tag从100开始
#define BTN_SWIPE_ANIMATION_DURATION 0.3

@class JFZMutiBtnContainer;
@protocol JFZMutiBtnContainerDelegate <NSObject>

@optional
- (void)MutiBtnContainer:(JFZMutiBtnContainer *)container didClickBtnAtIndex:(NSInteger)index;

@end


typedef NS_ENUM(NSInteger, JFZControllerContainerBtnBarType) {
    JFZControllerContainerBtnBarTypeShowAll = 0,
    JFZControllerContainerBtnBarTypeShowNum = 1,
    JFZControllerContainerBtnBarTypeWidth = 2,
};

typedef NS_ENUM(NSInteger, BtnContainerVerticalPosition) {
    BtnContainerVerticalPositionTop = 0,
    BtnContainerVerticalPositionBottom = 1,
};

@interface JFZMutiBtnContainer : UIToolbar
@property (nonatomic ,strong) UIScrollView *btnContainer;
@property (nonatomic ,strong) UIView *lineContainer;
@property (nonatomic ,assign) CGFloat underLineBtnHeight;
@property (nonatomic, assign) CGFloat lineScale;
@property (nonatomic ,assign) BOOL showLineUnderBtn;

@property (nonatomic ,assign) JFZControllerContainerBtnBarType type;
@property (nonatomic ,assign) CGFloat btnWidth;             //如果type为2则需要给出，如果所给的btnwidth*btnNum小于当前屏幕宽度，该值将不会起作用
@property (nonatomic ,assign) NSInteger btnNumInScream;     //如果type为1则需要给出

@property (nonatomic ,strong) UIFont *btnFont;
@property (nonatomic ,strong) UIColor *btnTinColor;
@property (nonatomic ,strong) UIColor *unselectedColor;

@property (nonatomic, assign, readonly) NSInteger currentIndex;

@property (nonatomic, strong) UIView *bottomLine; // 底部分隔线

@property (nonatomic, assign) BtnContainerVerticalPosition shadowLinePosition;

@property (nonatomic, assign) BOOL toolBarSeparateLineHidden; // ToolBar自带分割线

@property (nonatomic ,weak) id <JFZMutiBtnContainerDelegate> mutiBtnContainerdelegate;

- (id)initWithBarType:(JFZControllerContainerBtnBarType)type btnsName:(NSArray *)btnsName;
- (void)addbtnTarget:(id)target action:(SEL)action;

- (UIButton *)btnAtIndex:(NSInteger)index;

- (void)scrollingToIndex:(NSInteger)index percent:(CGFloat)percent;
- (void)setLineLeftOffset:(CGFloat)offsetX;
- (void)setCurrentIndex:(NSInteger)index animated:(BOOL)animated duration:(NSTimeInterval)duration;

- (void)reloadWithBtnArray:(NSArray<NSString *> *) array;
@end

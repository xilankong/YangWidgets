//
//  YangSliderView.h
//  Pods-YangWidgets_Example
//
//  Created by yanghuang on 2018/1/10.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@class SliderView;
@class YangSliderView;
@protocol YangSliderViewDataSource <NSObject>

@required
// pageNumber
- (NSInteger)numberOfPageInYangSliderView:(YangSliderView *)yangSliderView;
// index -> UIViewController
- (UIViewController *)YangSliderView:(YangSliderView *)yangSliderView controllerAtIndex:(NSInteger)index;
// index -> Title
- (NSString *)YangSliderView:(YangSliderView *)yangSliderView titleAtIndex:(NSInteger)index;

@optional
// textNomalColor
- (UIColor *)titleNomalColorInYangSliderView:(YangSliderView *)yangSliderView;
// textSelectedColor
- (UIColor *)titleSelectedColorInYangSliderView:(YangSliderView *)yangSliderView;
// lineColor
- (UIColor *)lineColorInYangSliderView:(YangSliderView *)yangSliderView;
// lineHeight
- (CGFloat)lineHeightInYangSliderView:(YangSliderView *)yangSliderView;
// lineWidth
- (CGFloat)lineWidthInYangSliderView:(YangSliderView *)yangSliderView;
// titleFont
- (CGFloat)titleFontInYangSliderView:(YangSliderView *)yangSliderView;
@end

@protocol YangSliderViewDelegate <NSObject>
@optional
// selctedIndex
- (void)YangSliderView:(YangSliderView *)yangSliderView selectedIndex:(NSInteger)index;
// selectedController
- (void)YangSliderView:(YangSliderView *)yangSliderView selectedController:(UIViewController *)controller;
// selectedTitle
- (void)YangSliderView:(YangSliderView *)yangSliderView selectedTitle:(NSString *)title;
@end

@interface YangSliderView : UIView

@property (nonatomic, assign)id<YangSliderViewDataSource> datasouce;
@property (nonatomic, assign)id<YangSliderViewDelegate> delegate;

-(void)reloadData;

@end


#pragma mark SliderBarViewDelegate
@protocol SliderBarViewDelegate <NSObject>
@optional
/**
 选择index回调
 
 @param index
 */
- (void)selectedIndex:(NSInteger)index;

@end

@interface SliderBarView : UIView

//代理
@property (nonatomic, assign)id<SliderBarViewDelegate> delegate;
//字体非选中时颜色
@property (nonatomic, strong)UIColor *textNomalColor;
//字体选中时颜色
@property (nonatomic, strong)UIColor *textSelectedColor;
//横线颜色
@property (nonatomic, strong)UIColor *lineColor;
//横线宽度
@property (nonatomic, assign)CGFloat lineWidth;
//横线高度
@property (nonatomic, assign)CGFloat lineHeight;
//字体大小
@property (nonatomic, assign)CGFloat titleFont;
/**
 手动选择
 @param index inde（从1开始）
 */

- (void)reloadViewWithData:(NSArray *)dataArray;
- (void)selectIndex:(NSInteger)index;

@end

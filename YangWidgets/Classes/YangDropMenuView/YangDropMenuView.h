//
//  DropMenuView.h
//  
//  下拉菜单
//  Created by yanghuang on 16/4/11.
//  Copyright © yanghuang All rights reserved.
//

#import <UIKit/UIKit.h>
@class YangDropMenuView;

#pragma mark - 协议
@protocol YangDropMenuDelegate <NSObject>

@optional
//点击事件
- (void)menu:(YangDropMenuView *)menu didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)menu:(YangDropMenuView *)menu didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

#pragma mark - 数据源
@protocol YangDropMenuDataSource <NSObject>

@required

//设置行数
- (NSInteger)menu:(YangDropMenuView *)menu numberOfRowsInSection:(NSInteger)section;
//设置title
- (NSString *)menu:(YangDropMenuView *)menu titleForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfSectionsInMenu:(YangDropMenuView *)menu;

@end

#pragma mark - 下拉菜单

@interface YangDropMenuView : UIView

@property (nonatomic, assign) CGFloat menuCellHeight;
@property (nonatomic, assign) CGFloat menuMaxHeight;
@property (nonatomic, strong) UIColor *titleHightLightColor;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *transformImageView;
@property (nonatomic, weak) id<YangDropMenuDataSource> dataSource;
@property (nonatomic, weak) id<YangDropMenuDelegate> delegate;


- (void)showInView:(UIView *)view andOrigin:(CGPoint) origin;
- (void)hidden;
- (void)reloadData;

@end



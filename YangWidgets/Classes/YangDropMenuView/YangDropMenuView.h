//
//  YangDropMenuView.h
//  YangDropMenuView
//  参考自 JSDropDownMenu
//  Created by yanghuang on 2017/7/25.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YangDropMenuHelper.h"

@class YangDropMenuView;
@class YangIndexPath;

#pragma mark dataSource
@protocol YangDropMenuViewDataSource <NSObject>

@required
- (NSInteger)menu:(YangDropMenuView *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow;

- (NSString *)menu:(YangDropMenuView *)menu titleForRowAtIndexPath:(YangIndexPath *)indexPath;

- (NSString *)menu:(YangDropMenuView *)menu titleForColumn:(NSInteger)column;

/**
 * 表视图显示时，左边表显示比例
 */
- (CGFloat)widthRatioOfLeftColumn:(NSInteger)column;
/**
 * 表视图显示时，是否需要两个表显示
 */
- (BOOL)haveRightTableViewInColumn:(NSInteger)column;

/**
 * 返回当前菜单左边表选中行
 */
- (NSInteger)currentLeftSelectedRow:(NSInteger)column;

@optional
//default value is 1
- (NSInteger)numberOfColumnsInMenu:(YangDropMenuView *)menu;

/**
 * 是否需要显示为UICollectionView 默认为否
 */
- (BOOL)displayByCollectionViewInColumn:(NSInteger)column;

@end

#pragma mark - delegate
@protocol YangDropMenuViewDelegate <NSObject>
@optional
- (void)menu:(YangDropMenuView *)menu didSelectRowAtIndexPath:(YangIndexPath *)indexPath;
@end

#pragma mark - interface
@interface YangDropMenuView : UIView <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id <YangDropMenuViewDataSource> dataSource;
@property (nonatomic, weak) id <YangDropMenuViewDelegate> delegate;

@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *separatorColor;
/**
 *  the width of menu will be set to screen width defaultly
 *
 *  @param origin the origin of this view's frame
 *  @param height menu's height
 *
 *  @return menu
 */
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height;
- (NSString *)titleForRowAtIndexPath:(YangIndexPath *)indexPath;

@end

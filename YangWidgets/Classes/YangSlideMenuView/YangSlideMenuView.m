//
//  YangSlideMenu.m
//  yangCategory
//
//  Created by yanghuang on 2017/7/25.
//  Copyright © 2017年 young.huang. All rights reserved.
//

#import "YangSlideMenuView.h"

#define hightLightColor [UIColor colorWithRed:0.259f green:0.812f blue:0.784f alpha:1.00f]
#define normalColor [UIColor colorWithRed:0.17f green:0.17f blue:0.17f alpha:1.00f]

@interface YangSlideLabel()

@property(nonatomic, assign) BOOL hightLight;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, strong) UIColor *selectedColor;
@property(nonatomic, strong) UIColor *unSelectedColor;

@end

@implementation YangSlideLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.hightLight = NO;
    }
    return self;
}

-(UIColor *)selectedColor {
    if (!_selectedColor) {
        _selectedColor = hightLightColor;
    }
    return _selectedColor;
}

-(UIColor *)unSelectedColor {
    if (!_unSelectedColor) {
        return normalColor;
    }
    return _unSelectedColor;
}

-(void)setHightLight:(BOOL)hightLight {
    _hightLight = hightLight;
    if (hightLight) {
        [self setTextColor:self.selectedColor];
    } else {
        [self setTextColor:self.unSelectedColor];
    }
}

-(CGFloat)width {
    NSDictionary *attributes = @{NSFontAttributeName : self.font};
    CGSize size = [self.text sizeWithAttributes:attributes];
    return size.width + 20;
}

@end

@interface YangSlideMenuView()

@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) NSMutableArray<YangSlideLabel *> *labelList;

@end

@implementation YangSlideMenuView

-(NSArray *)dataList {
    if (!_dataList) {
        _dataList = [NSArray array];
    }
    return _dataList;
}

-(NSMutableArray *)labelList {
    if (!_labelList) {
        _labelList = [NSMutableArray array];
    }
    return _labelList;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)updateViewWithDataArray:(NSArray *) data {
    self.dataList = data;
    
    if (data.count > self.labelList.count) {
        //create new increase labels
        for (NSUInteger i = self.labelList.count; i < [data count]; i++) {
            YangSlideLabel *label = [[YangSlideLabel alloc] init];
            label.tag = i;
            label.selectedColor = self.labelSelectColor;
            label.unSelectedColor = self.labelUnSelectColor;
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblClick:)]];
            [self addSubview:label];
            [self.labelList addObject:label];
        }
    } else if (data.count < self.labelList.count) {
        //hide useless labels
        for (NSUInteger i = data.count; i < self.labelList.count; i++) {
            YangSlideLabel *label = [self.labelList objectAtIndex:i];
            label.frame = CGRectMake(0, 0, 0, 0);
            label.text = @"";
        }
    }
    
    float contentSizeWidth = 0;
    for (NSUInteger i = 0; i < [data count]; i++) {
        YangSlideLabel *label = [self.labelList objectAtIndex:i];
        label.text = [data objectAtIndex:i];
        label.font = [UIFont systemFontOfSize:14];
        float width = label.width;
        label.frame = CGRectMake(contentSizeWidth, 0, width, self.frame.size.height);
        label.hightLight = (i == 0);
        contentSizeWidth = contentSizeWidth + width;
        self.contentSize = CGSizeMake(contentSizeWidth, self.frame.size.height);
    }
}

- (void)lblClick:(UITapGestureRecognizer *)recognizer {
    //第一部分 滑动
    YangSlideLabel *clickLabel = (YangSlideLabel *)recognizer.view;
    if (clickLabel.hightLight) {
        return;
    }
    [self.labelList enumerateObjectsUsingBlock:^(YangSlideLabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hightLight = NO;
    }];
    clickLabel.hightLight = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(yang_menuItemClickAction:)]) {
        [self.delegate yang_menuItemClickAction:clickLabel];
    }
    if (self.contentSize.width >= self.frame.size.width - 30) {
        float offsetx = clickLabel.center.x - self.frame.size.width * 0.5;
        
        CGPoint offset;
        //左侧不超出
        if (offsetx > 0)
            offset = CGPointMake(offsetx, self.contentOffset.y);
        else
            offset = CGPointMake(0, self.contentOffset.y);
        
        //右侧不超出
        float offsetxMax = self.contentSize.width - self.frame.size.width;
        if (offsetx > offsetxMax) {
            offset = CGPointMake(offsetxMax, self.contentOffset.y);
        }
        [self setContentOffset:offset animated:YES];
    }
}


@end

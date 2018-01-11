//
//  JFZMutiBtnContainer.m
//  JinFuZiApp
//
//  Created by 嘉维 陈 on 15/8/31.
//  Copyright (c) 2015年 com.jinfuzi. All rights reserved.
//

#import "JFZMutiBtnContainer.h"

#define BTN_SWIPE_ANIMATION_DURATION 0.3
#define SLIDER_BAR_LEFT_PADDING (20.0f)
#define weakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface JFZMutiBtnContainer () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *btnsNameArr;
@property (nonatomic, weak) UIButton *currentSelectedBtn;
@property (nonatomic, strong) UIView *realLine;
@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, strong) CAGradientLayer *tintLayer;
@property (nonatomic, strong) UIView *maskContainer;

@property (nonatomic, assign) CGRect oldRect;
@property (nonatomic, strong) NSMutableArray *btnArr;
@property (nonatomic, strong) NSMutableArray *labelArr;

@property (nonatomic, strong) UIImageView *leftPaddingView;
@property (nonatomic, strong) UIImageView *rightPaddingView;

@property (nonatomic, weak) id target;
@property (nonatomic) SEL action;

@end

@implementation JFZMutiBtnContainer

@synthesize currentIndex = _currentIndex;

- (id)initWithBarType:(JFZControllerContainerBtnBarType)type btnsName:(NSArray *)btnsName
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.type = type;
        self.btnsNameArr = btnsName;
        //预设值
        _currentIndex = 0;
        _underLineBtnHeight = 1.0;
        _unselectedColor = [UIColor blackColor];
        _btnTinColor = [UIColor redColor];
        _btnFont = [UIFont systemFontOfSize:12];
        _btnArr = [[NSMutableArray alloc] init];
        _labelArr = [[NSMutableArray alloc] init];
        _oldRect = CGRectZero;
        _lineScale = 3.0 / 5.0;
        _shadowLinePosition = BtnContainerVerticalPositionTop;
        _btnNumInScream = 4;
        
        self.clipsToBounds = NO;
    }
    return self;
}

- (void)reloadWithBtnArray:(NSArray<NSString *> *) array {
    _btnArr = [[NSMutableArray alloc] init];
    _labelArr = [[NSMutableArray alloc] init];
    [_maskContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (UIView *view in _btnContainer.subviews) {
        if ([view isMemberOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    
    self.btnsNameArr = array;
    self.btnContainer.frame = self.bounds;
    [self relayoutLineContainer];
    [self relayoutBtnAndLabel];
    self.maskLayer.frame = self.maskContainer.frame;
    CGRect frame = self.currentSelectedBtn.frame;
    frame.size.width /= 0.8;
    self.tintLayer.frame = frame;
    self.tintLayer.position = self.currentSelectedBtn.center;
    
    [self relayoutPaddingView:CGPointZero];
    
    [self relayoutShadowLine];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(!CGRectEqualToRect(self.frame, self.oldRect)){
        self.btnContainer.frame = self.bounds;
        [self relayoutLineContainer];
        [self relayoutBtnAndLabel];
        self.maskLayer.frame = self.maskContainer.frame;
        CGRect frame = self.currentSelectedBtn.frame;
        frame.size.width /= 0.8;
        self.tintLayer.frame = frame;
        self.tintLayer.position = self.currentSelectedBtn.center;
        
        [self relayoutPaddingView:CGPointZero];
        
        [self relayoutShadowLine];
    }
    self.oldRect = self.frame;
    
    UIImageView *toolBarLine = [self findToolBarSeparateLine];
    if (self.toolBarSeparateLineHidden) {
        toolBarLine.hidden = YES;
    }
}

#pragma mark - public
- (void)setCurrentIndex:(NSInteger)index animated:(BOOL)animated duration:(NSTimeInterval)duration
{
    UIButton *newSelectedBtn = [self btnAtIndex:index];
    if(!_maskLayer){
        self.currentIndex = index;
        self.currentSelectedBtn = newSelectedBtn;
        //maskLayer不存在，则说明视图没有layout则下面 动画以及frame不需要调整
        return;
    }

    if(newSelectedBtn.left == self.tintLayer.frame.origin.x){
        return;
    }
    self.currentIndex = index;
    self.currentSelectedBtn = newSelectedBtn;

    if(animated){
        weakSelf(weakSelf);
 
        if(self.showLineUnderBtn){
            [UIView animateWithDuration:duration animations:^{
                weakSelf.lineContainer.left = newSelectedBtn.left;
            }];
        }
        CGRect maskLayerFrame = self.currentSelectedBtn.frame;
        CGPoint startPoint = self.tintLayer.position;

        CGPoint endPoint = CGPointMake(maskLayerFrame.origin.x + maskLayerFrame.size.width / 2, maskLayerFrame.size.height / 2);
        self.tintLayer.position = endPoint;
        [self.tintLayer removeAllAnimations];
        CABasicAnimation *baseAnimation = [CABasicAnimation animation];
        baseAnimation.duration = duration;
        baseAnimation.keyPath = @"position";
        baseAnimation.fromValue = [NSValue valueWithCGPoint:startPoint];
        baseAnimation.toValue = [NSValue valueWithCGPoint:endPoint];
        baseAnimation.removedOnCompletion = YES;
        baseAnimation.repeatCount = 0;
        baseAnimation.fillMode = kCAFillModeForwards;
        [self.tintLayer addAnimation:baseAnimation forKey:@"swipe"];
    }else{
        self.lineContainer.left = newSelectedBtn.left;
        CGRect maskLayerFrame = self.currentSelectedBtn.frame;
        self.tintLayer.frame = maskLayerFrame;
    }
    
    [self relayoutBarDidEndScrollView:0 animated:YES];
}

- (void)scrollingToIndex:(NSInteger)index percent:(CGFloat)percent
{
    UIButton *nextBtn = [self btnAtIndex:index];
    CGFloat offset = ( nextBtn.left - self.currentSelectedBtn.left ) * percent;
    offset = self.currentSelectedBtn.left + offset;
    self.tintLayer.position = CGPointMake(offset + self.currentSelectedBtn.bounds.size.width / 2, self.tintLayer.position.y);
    self.lineContainer.left = offset;
    NSLog(@"scrollingToIndex :%ld percent:%f",index, percent);
}

- (void)setLineLeftOffset:(CGFloat)offsetX
{
    self.tintLayer.position = CGPointMake(offsetX + self.currentSelectedBtn.bounds.size.width / 2, self.tintLayer.position.y);
    self.lineContainer.left = offsetX;
    
    //[self relayoutBarEndScrollView:0];
}

#pragma mark - private
- (void)relayoutLineContainer
{
    if(self.showLineUnderBtn){
        NSInteger numOfBtn = self.btnsNameArr.count;
        CGFloat btnWidth = 0;
        if(self.type == JFZControllerContainerBtnBarTypeShowAll){
            btnWidth = self.frame.size.width/ numOfBtn;
        }else if(self.type == JFZControllerContainerBtnBarTypeShowNum){
            btnWidth = self.frame.size.width / self.btnNumInScream;
        }else{
            btnWidth = self.btnWidth * numOfBtn > self.frame.size.width ?  self.btnWidth  : self.frame.size.width / numOfBtn;
        }
        CGFloat lineWidth = btnWidth * self.lineScale;
        self.lineContainer.frame = CGRectMake(btnWidth * self.currentIndex, self.height - _underLineBtnHeight, btnWidth, 3);
        self.realLine.frame = CGRectMake((btnWidth - lineWidth)/2, 0, lineWidth, _underLineBtnHeight);
    }
}

- (void)relayoutBtnAndLabel
{
    NSInteger numOfBtn = self.btnsNameArr.count;
    CGFloat btnWidth = 0;
    if(self.type == JFZControllerContainerBtnBarTypeShowAll){
        btnWidth = self.frame.size.width/ numOfBtn;
    }else if(self.type == JFZControllerContainerBtnBarTypeShowNum){
        btnWidth = self.frame.size.width / self.btnNumInScream;
    }else{
        btnWidth = self.btnWidth * numOfBtn > self.frame.size.width ?  self.btnWidth  : self.frame.size.width / numOfBtn;
    }
    
    if(_maskContainer) {
        _maskContainer.frame = CGRectMake(0.0, 0.0, btnWidth * numOfBtn, _btnContainer.height);
    } else {
        _maskContainer = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, btnWidth * numOfBtn, _btnContainer.height)];
        //_maskContainer.backgroundColor = [UIColor redColor];
        [_btnContainer addSubview:_maskContainer];
    }
    
    for (int i = 0; i< numOfBtn; i++) {
        UIButton *btn = [self btnAtIndex:i];
        btn.frame = CGRectMake(btnWidth*i, 0.0, btnWidth, _btnContainer.height);
        
        UILabel *titleLabel = [self labelAtIndex:i];
        titleLabel.frame = CGRectMake(btnWidth*i, 0.0, btnWidth, _btnContainer.height);
        if(!titleLabel.superview){
            [_maskContainer addSubview:titleLabel];
        }
        if(!btn.superview){
            [_btnContainer addSubview:btn];
        }
    }
    
    _btnContainer.contentSize = CGSizeMake(btnWidth * numOfBtn, 0);
    self.currentSelectedBtn = (UIButton *)[_btnContainer viewWithTag:100 + self.currentIndex];
    [self btnDidClick:self.currentSelectedBtn animated:NO];
    [self relayoutBarDidEndScrollView:0 animated:NO]; // add by qinggang
}

- (void)relayoutPaddingView:(CGPoint)contentOffset {
    if (self.type != JFZControllerContainerBtnBarTypeShowAll) {
        const CGFloat interal = 0.35;
        CGFloat diff = (_btnContainer.contentSize.width - self.width - contentOffset.x);
        if (diff > 0.001) {
            if (self.rightPaddingView.hidden) {
                self.rightPaddingView.hidden = NO;
                self.rightPaddingView.alpha = 0.0;
                [UIView animateWithDuration:interal animations:^{
                    self.rightPaddingView.alpha = 1.0;
                }];
            }
        }
        else {
            [UIView animateWithDuration:interal animations:^{
                self.rightPaddingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.rightPaddingView.hidden = YES;
            }];
        }
        
        if (contentOffset.x > 0) {
            if (self.leftPaddingView.hidden) {
                self.leftPaddingView.hidden = NO;
                self.leftPaddingView.alpha = 0.0;
                [UIView animateWithDuration:interal animations:^{
                    self.leftPaddingView.alpha = 1.0;
                }];
            }
        }
        else {
            [UIView animateWithDuration:interal animations:^{
                self.leftPaddingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.leftPaddingView.hidden = YES;
            }];
        }
    }
}

- (void)relayoutShadowLine
{
    CGFloat originY = self.bounds.size.height - 0.5;
    if (_shadowLinePosition == BtnContainerVerticalPositionTop)
    {
        originY = 0;
    }
    self.bottomLine.frame = CGRectMake(0, originY, self.bounds.size.width, 0.5);
    [self addSubview:self.bottomLine];
}

- (void)relayoutBarDidEndScrollView:(NSUInteger)type animated:(BOOL)animated {
    //NSLog(@"relayoutBarEndScrollView, current button:%@ index:%ld scroll:%@ .", self.currentSelectedBtn, self.currentIndex, self.btnContainer);
    
    if (self.type == JFZControllerContainerBtnBarTypeShowAll) {
        return ;
    }
    
    CGPoint currentSelectedButtonCenter = self.currentSelectedBtn.center;
    CGRect buttonContainerRect = self.btnContainer.frame;
    
    CGPoint point = CGPointZero;
    CGFloat offsetDiff = (currentSelectedButtonCenter.x - (buttonContainerRect.size.width / 2.0));
    //当选中按钮的中点大于滚动条的视图中点，需要设置滚动条偏移量
    if (offsetDiff > 0.0) {
        //判断最右边的按钮是否可以显示全
        CGFloat buttonContainerContentWidth = self.btnContainer.contentSize.width;
        CGFloat buttonContainerContentWidthDiff = (buttonContainerContentWidth - offsetDiff - buttonContainerRect.size.width);
        
        //可见区域不能显示最右边按钮
        if (buttonContainerContentWidthDiff > 0.0) {
            point.x = offsetDiff;
        }
        else {
            point.x = (buttonContainerContentWidth - buttonContainerRect.size.width);
        }
    }
    
    //只有当滚动条offset和将设置偏移量不同，才设置
    CGPoint buttonContainerOffset = self.btnContainer.contentOffset;
    if (!CGPointEqualToPoint(buttonContainerOffset, point)) {
        [self.btnContainer setContentOffset:point animated:animated];
    }
    
    [self relayoutPaddingView:point];
}

#pragma mark - getter & setter
- (void)setShadowLinePosition:(BtnContainerVerticalPosition)shadowLinePosition
{
    _shadowLinePosition = shadowLinePosition;
    [self relayoutShadowLine];
}

- (UIImageView *)findToolBarSeparateLine
{
    // 使用这种方法是存在缺陷的，因为这种视图层次在不同版本的系统中是不一样的，所以以后应该尽量避免使用这种策略
    if ([UIDevice currentDevice].systemVersion.floatValue>=10.0?YES:NO) {
        for (UIView *subview in self.subviews)
        {
            if ([subview isKindOfClass:NSClassFromString(@"_UIBarBackground")])
            {
                for (UIView *ssubview in subview.subviews)
                {
                    if ([ssubview isKindOfClass:[UIImageView class]] && ssubview.frame.size.height <= 1.0)
                    {
                        return (UIImageView *)ssubview;
                    }
                }
            }
        }
    }else {
        for (UIView *ssubview in self.subviews)
        {
            if ([ssubview isKindOfClass:[UIImageView class]] && ssubview.frame.size.height <= 1.0)
            {
                return (UIImageView *)ssubview;
            }
        }
    }

    return nil;
}

- (UIImageView *)findHairlineFromView:(UIView *)view
{
    if ([view isKindOfClass:[UIImageView class]] && view.frame.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    
    for (UIView *subView in view.subviews) {
        UIImageView *imageView = [self findHairlineFromView:subView];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (UIButton *)btnAtIndex:(NSInteger)index
{
    if(self.btnArr[index]){
        
        return self.btnArr[index];
    }else{
        if(index >= self.btnArr.count){
            NSInteger count = self.btnArr.count;
            for (NSUInteger i = count ; i <  index  + 1  ; i ++) {
                UIButton *newBtn = [[UIButton alloc] init];
                newBtn.tag = 100 + i;
                newBtn.backgroundColor = [UIColor clearColor];
                [newBtn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.btnArr addObject:newBtn];
            }
        }
        return [self btnAtIndex:index];
    }
}

- (UILabel *)labelAtIndex:(NSInteger)index
{
    if(self.labelArr[index]){
        return self.labelArr[index];
    }else{
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = self.btnsNameArr[index];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = self.btnFont;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        for (NSUInteger i = 0; index + 1 - self.labelArr.count ; i ++) {
            [self.labelArr addObject:[NSObject new]];
        }
        self.labelArr[index] = titleLabel;
        return titleLabel;
    }
}

- (UIView *)lineContainer
{
    if(!_lineContainer ){
        UIView *lineContainer = [[UIView alloc]init];
        UIView *trueLine =  [[UIView alloc] init];
        _lineContainer = lineContainer;
        _realLine = trueLine;
        _realLine.backgroundColor = _btnTinColor;
        [_lineContainer addSubview:_realLine];
        [self.btnContainer addSubview:_lineContainer];
    }
    return _lineContainer;

}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
}


- (UIScrollView *)btnContainer{
    if(!_btnContainer){
        _btnContainer = [[UIScrollView alloc] initWithFrame:self.bounds];
        _btnContainer.showsHorizontalScrollIndicator = NO;
        _btnContainer.pagingEnabled = NO;
        _btnContainer.delegate = self;
        _btnContainer.scrollsToTop = NO;
        _btnContainer.backgroundColor = [UIColor whiteColor];
        [self addSubview:_btnContainer];
        [self relayoutBtnAndLabel];
    }
    return _btnContainer;
}

- (void)addbtnTarget:(id)target action:(SEL)action
{
    self.target = target;
    self.action  = action;
}

- (UIView *)bottomLine
{
    if (!_bottomLine)
    {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = UIColor.redColor;
    }
    
    return _bottomLine;
}

- (UIImageView *)leftPaddingView {
    if (!_leftPaddingView) {
        _leftPaddingView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SLIDER_BAR_LEFT_PADDING, self.frame.size.height)];
        //_leftPaddingView.backgroundColor = [UIColor whiteColor];
        _leftPaddingView.hidden = YES;
        //CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        //gradientLayer.frame = _leftPaddingView.bounds;
        //gradientLayer.colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor colorWithWhite:1 alpha:0.25].CGColor];
//        gradientLayer.colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor whiteColor].CGColor];
//        gradientLayer.startPoint = CGPointMake(0.6, 0.0);
//        gradientLayer.endPoint = CGPointMake(1.0, 0.0);
        //gradientLayer.locations  = @[@(0.55), @(1.0)];
        //[_leftPaddingView.layer addSublayer:gradientLayer];
        //_leftPaddingView.layer.mask = gradientLayer;
        _leftPaddingView.image = [UIImage imageNamed:@"slider_bar_left_mask"];
        [self addSubview:_leftPaddingView];
    }
    
    return _leftPaddingView;
}

- (UIImageView *)rightPaddingView {
    if (!_rightPaddingView) {
        _rightPaddingView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - SLIDER_BAR_LEFT_PADDING, 0, SLIDER_BAR_LEFT_PADDING, self.frame.size.height)];
        _rightPaddingView.hidden = YES;
        _rightPaddingView.image = [UIImage imageNamed:@"slider_bar_right_mask"];
        [self addSubview:_rightPaddingView];
    }
    
    return _rightPaddingView;
}

- (CALayer *)maskLayer
{
    if(!_maskLayer){
        _maskLayer = [CALayer layer];
        _maskLayer.backgroundColor = self.unselectedColor.CGColor;
        _maskLayer.mask = self.maskContainer.layer;
        [_maskLayer addSublayer:self.tintLayer];
        [self.btnContainer.layer addSublayer:_maskLayer];
    }
    
    return _maskLayer;
}

- (CAGradientLayer *)tintLayer {
    if (!_tintLayer) {
        _tintLayer = [CAGradientLayer layer];
        _tintLayer.startPoint = CGPointMake(0.0, 0.5);
        _tintLayer.endPoint = CGPointMake(1.0, 0.5);
        _tintLayer.colors = @[(__bridge id)self.unselectedColor.CGColor, (__bridge id)self.btnTinColor.CGColor, (__bridge id)self.btnTinColor.CGColor, (__bridge id)self.unselectedColor.CGColor];
        _tintLayer.locations = @[@(0.0),@(0.3), @(0.7),@(1.0)];
    }
    
    return  _tintLayer;
}

#pragma mark - click Action
- (void)btnDidClick:(id)sender
{
    [self btnDidClick:sender animated:YES];
}

- (void)btnDidClick:(id)sender animated:(BOOL)animated
{
    UIButton *btn = sender;
    NSInteger index = btn.tag - 100;
    [self setCurrentIndex:index animated:animated duration:BTN_SWIPE_ANIMATION_DURATION];
    if(self.mutiBtnContainerdelegate && [self.mutiBtnContainerdelegate respondsToSelector:@selector(MutiBtnContainer:didClickBtnAtIndex:)]){
        [self.mutiBtnContainerdelegate MutiBtnContainer:self didClickBtnAtIndex:index];
    }
    if(self.target && [self.target respondsToSelector:self.action]){
        [self.target performSelector:self.action withObject:btn];
    }
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //JCLogInfo(@"scrollViewDidScroll start, offset:%@", NSStringFromCGPoint(scrollView.contentOffset));
    [self relayoutPaddingView:scrollView.contentOffset];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //JCLogInfo(@"scrollViewDidEndDragging start, offset:%@", NSStringFromCGPoint(scrollView.contentOffset));
    if (!decelerate) {
        [self relayoutPaddingView:scrollView.contentOffset];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //JCLogInfo(@"scrollViewDidEndDecelerating start, offset:%@", NSStringFromCGPoint(scrollView.contentOffset));
    [self relayoutPaddingView:scrollView.contentOffset];
}

@end

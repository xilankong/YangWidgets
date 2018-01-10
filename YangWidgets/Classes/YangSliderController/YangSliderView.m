//
//  YangSliderView.m
//  Pods-YangWidgets_Example
//
//  Created by yanghuang on 2018/1/10.
//

#import "YangSliderView.h"

@interface YangSliderView()<SliderBarViewDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) SliderBarView *sliderBarView;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) NSMutableArray *segmentTitles;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger willIndex;

@end

@implementation YangSliderView

-(NSMutableArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray array];
    }
    return _viewControllers;
}
-(NSMutableArray *)segmentTitles{
    if (!_segmentTitles) {
        _segmentTitles = [NSMutableArray array];
    }
    return _segmentTitles;
}

#pragma mark 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self instance];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self instance];
    }
    return self;
}

-(void)instance{
    self.currentIndex = 0;
    
    //SliderView
    self.sliderBarView = [[SliderBarView alloc] init];
    self.sliderBarView.delegate = self;
    [self addSubview:self.sliderBarView];
    [self.sliderBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    //pageController
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
//    self.pageController.view.frame = CGRectMake(0, 40, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 40);
    self.pageController.dataSource = self;
    self.pageController.delegate   = self;
    [self addSubview:self.pageController.view];
    [self.pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sliderBarView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
}

-(void)reloadData{
    [self.viewControllers removeAllObjects];
    [self.segmentTitles removeAllObjects];
    NSInteger num = 0;
    if ([self.datasouce respondsToSelector:@selector(numberOfPageInYangSliderView:)]) {
        num = [self.datasouce numberOfPageInYangSliderView:self];
    }
    if (num <= 0) {
        return;
    }
    for (NSInteger i = 0 ; i < num; i++) {
        if ([self.datasouce respondsToSelector:@selector(YangSliderView:controllerAtIndex:)]) {
            UIViewController *vc = [self.datasouce YangSliderView:self controllerAtIndex:i];
            [self.viewControllers addObject:vc];
            
        }
    }
    for (NSInteger i = 0 ; i < num; i++) {
        if ([self.datasouce respondsToSelector:@selector(YangSliderView:titleAtIndex:)]) {
            NSString *title = [self.datasouce YangSliderView:self titleAtIndex:i];
            [self.segmentTitles addObject:title];
        }
    }
    
    //setAttribute SliderView
    self.sliderBarView.dataArray = self.segmentTitles;
    if ([self.datasouce respondsToSelector:@selector(titleFontInYangSliderView:)]) {
        self.sliderBarView.titleFont = [self.datasouce titleFontInYangSliderView:self];
    }
    if ([self.datasouce respondsToSelector:@selector(titleNomalColorInYangSliderView:)]) {
        self.sliderBarView.textNomalColor = [self.datasouce titleNomalColorInYangSliderView:self];
    }
    if ([self.datasouce respondsToSelector:@selector(titleSelectedColorInYangSliderView:)]) {
        self.sliderBarView.textSelectedColor = [self.datasouce titleSelectedColorInYangSliderView:self];
    }
    if ([self.datasouce respondsToSelector:@selector(lineColorInYangSliderView:)]) {
        self.sliderBarView.lineColor = [self.datasouce lineColorInYangSliderView:self];
    }
    
    //setAttribute pageController
    [self.pageController setViewControllers:@[self.viewControllers[0]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

-(NSInteger)indexOfViewController:(UIViewController *)viewController{
    return [self.viewControllers indexOfObject:viewController];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound || index == 0) {
        return nil;
    }
    index --;
    
    return self.viewControllers[index];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound || index == self.viewControllers.count - 1) {
        return nil;
    }
    index++;
    
    return self.viewControllers[index];
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    NSInteger index = [self indexOfViewController:pendingViewControllers[0]];
    self.willIndex = index;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if(completed){
        NSInteger index = [self indexOfViewController:previousViewControllers[0]];
        NSInteger nextIndex = 0;
        if (index > self.willIndex) {
            nextIndex = index - 1;
        }else if (index < self.willIndex){
            nextIndex = index + 1;
        }
        [self.sliderBarView selectIndex:nextIndex + 1];
        [self callBackWithIndex:nextIndex];
    }
}

-(void)selectedIndex:(NSInteger)index{
    __weak YangSliderView *weakSelf = self;
    if (self.currentIndex == 0) {
        [self.pageController setViewControllers:@[self.viewControllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            [weakSelf callBackWithIndex:index];
        }];
    }else if (self.currentIndex < index){
        [self.pageController setViewControllers:@[self.viewControllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            [weakSelf callBackWithIndex:index];
        }];
    }else{
        [self.pageController setViewControllers:@[self.viewControllers[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
            [weakSelf callBackWithIndex:index];
        }];
    }
    
}
-(void)callBackWithIndex:(NSInteger)index{
    self.currentIndex = index;
    if ([self.delegate respondsToSelector:@selector(YangSliderView:selectedController:)]) {
        [self.delegate YangSliderView:self selectedController:self.viewControllers[index]];
    }
    if ([self.delegate respondsToSelector:@selector(YangSliderView:selectedTitle:)]) {
        [self.delegate YangSliderView:self selectedTitle:self.segmentTitles[index]];
    }
    if ([self.delegate respondsToSelector:@selector(YangSliderView:selectedIndex:)]) {
        [self.delegate YangSliderView:self selectedIndex:index];
    }
}

@end

#define DefaultTextNomalColor [UIColor blackColor]
#define DefaultTextSelectedColor [UIColor redColor]
#define DefaultLineColor [UIColor blackColor]
#define DefaultTitleFont 15
#define LineHeigh 1

@interface SliderBarView ()

@property (nonatomic, strong) NSMutableArray *buttonsArray;
@property (nonatomic, strong) UIImageView *lineImageView;

@end

@implementation SliderBarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSth];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSth];
    }
    return self;
}

- (void)initSth {
    self.backgroundColor = [UIColor whiteColor];
    _buttonsArray = [[NSMutableArray alloc] init];
    
    //默认
    _textNomalColor    = DefaultTextNomalColor;
    _textSelectedColor = DefaultTextSelectedColor;
    _lineColor = DefaultLineColor;
    _titleFont = DefaultTitleFont;
}

-(void)addSubSegmentView
{
    [self.buttonsArray removeAllObjects];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    float width = self.frame.size.width / _dataArray.count;
    UIButton *lastButton = nil;
    for (int i = 0 ; i < _dataArray.count ; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 0, width, self.frame.size.height)];
        button.tag = i+1;
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:[_dataArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:self.textNomalColor    forState:UIControlStateNormal];
        [button setTitleColor:self.textSelectedColor forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:_titleFont];
        
        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        //默认第一个选中
        if (i == 0) {
            button.selected = YES;
        }
        else{
            button.selected = NO;
        }
        
        [self.buttonsArray addObject:button];
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(self);
            } else {
                make.left.equalTo(lastButton.mas_right);
            }
            make.top.bottom.equalTo(self);
            make.width.equalTo(self.mas_width).dividedBy(_dataArray.count);
            if (i == _dataArray.count - 1) {
                make.right.equalTo(self);
            }
        }];
        
        lastButton = button;
    }
    self.lineImageView = [[UIImageView alloc] init];
    self.lineImageView.backgroundColor = _lineColor;
    [self addSubview:self.lineImageView];
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(LineHeigh);
        make.width.equalTo(self.mas_width).dividedBy(_dataArray.count);
        CGFloat scale = 2 * ((UIButton *)self.buttonsArray[0]).tag - 1;
        make.centerX.equalTo(self.mas_centerX).multipliedBy(scale / _dataArray.count);
    }];
    
}

-(void)tapAction:(id)sender{
    UIButton *button = (UIButton *)sender;
    __weak typeof(self) weakSelf = self;
    CGFloat scale = 2 * button.tag - 1;
    [self.lineImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(button.frame.origin.x + button.frame.size.width / 2.0);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf layoutIfNeeded];
    }];
    for (UIButton *subButton in self.buttonsArray) {
        if (button == subButton) {
            subButton.selected = YES;
        }
        else{
            subButton.selected = NO;
        }
    }
    if ([self.delegate respondsToSelector:@selector(selectedIndex:)]) {
        [self.delegate selectedIndex:button.tag -1];
    }
}
-(void)selectIndex:(NSInteger)index
{
    for (UIButton *subButton in self.buttonsArray) {
        if (index != subButton.tag) {
            subButton.selected = NO;
        }
        else{
            __weak typeof(self) weakSelf = self;
            CGFloat scale = 2 * subButton.tag - 1;
            [self.lineImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(subButton.frame.origin.x + subButton.frame.size.width / 2.0);
            }];
            [UIView animateWithDuration:0.2 animations:^{
                [weakSelf layoutIfNeeded];
            } completion:^(BOOL finished) {
                subButton.selected = YES;
            }];
        }
    }
}
#pragma mark -- set
-(void)setDataArray:(NSArray *)dataArray{
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
        [self addSubSegmentView];
    }
}
-(void)setLineColor:(UIColor *)lineColor{
    if (_lineColor != lineColor) {
        self.lineImageView.backgroundColor = lineColor;
        _lineColor = lineColor;
    }
}
-(void)setTextNomalColor:(UIColor *)textNomalColor{
    if (_textNomalColor != textNomalColor) {
        for (UIButton *subButton in self.buttonsArray){
            [subButton setTitleColor:textNomalColor forState:UIControlStateNormal];
        }
        _textNomalColor = textNomalColor;
    }
}
-(void)setTextSelectedColor:(UIColor *)textSelectedColor{
    if (_textSelectedColor != textSelectedColor) {
        for (UIButton *subButton in self.buttonsArray){
            [subButton setTitleColor:textSelectedColor forState:UIControlStateSelected];
        }
        _textSelectedColor = textSelectedColor;
    }
}
-(void)setTitleFont:(CGFloat)titleFont{
    if (_titleFont != titleFont) {
        for (UIButton *subButton in self.buttonsArray){
            subButton.titleLabel.font = [UIFont systemFontOfSize:titleFont] ;
        }
        _titleFont = titleFont;
    }
}
@end


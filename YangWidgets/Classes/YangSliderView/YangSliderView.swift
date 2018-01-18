//
//  YangSliderView.swift
//  Masonry
//
//  Created by yanghuang on 2018/1/11.
//

import Foundation
import UIKit

public enum YangSliderViewIndicatorType {
    case normal
    case stretch
    case stretchAndMove
}

public class YangSliderView: UIView {
    
    //MARK: - properties
    
    private var titles: [String] = []
    
    private var controllers: [UIViewController] = []
    
    private var tabScrollView: UIScrollView = UIScrollView()
    
    private var mainScrollView: UIScrollView = UIScrollView()
    
    private var leftIndex = 0
    
    private var rightIndex = 0
    //tab的边距
    private var itemMargin: CGFloat = 0.0
    
    private var itemWidth: CGFloat = 93.0
    
    private var items: [UILabel] = []
    
    private let indicatorView: UIView = UIView()
    
    //伸缩动画的偏移量
    private let indicatorAnimatePadding: CGFloat = 8.0
    
    public var tabBarHeight: CGFloat = 45.0
    
    public var indicatorWidth: CGFloat = 60.0
    
    public var indicatorType: YangSliderViewIndicatorType = .stretchAndMove
    //标题字体
    public var itemFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    //选中颜色
    public var itemSelectedColor: UIColor = UIColor.red
    
    //未选中颜色
    public var itemUnselectedColor: UIColor = UIColor.gray
    
    //下标距离底部距离
    public var bottomPadding: CGFloat = 0.0
    
    //下标高度
    public var indicatorHeight: CGFloat = 2.0
    
    private var _currentIndex: Int = 0
    
    public var currentIndex: Int {
        get {
            return _currentIndex
        }
        set {
            goToTab(fromIndex: _currentIndex, toIndex: newValue)
            _currentIndex = newValue
        }
    }
    
    //MARK: - 初始化
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    //MARK: - 代参数初始化
    public init(frame: CGRect,titles: [String],childControllers: [UIViewController]) {
        
        super.init(frame: frame)
        initUI()
        reloadView(titles: titles, controllers: childControllers)
    }
    
    private func initUI() {
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        line.frame = CGRect(x: 0, y: self.tabBarHeight - 0.5, width: self.bounds.size.width, height: 0.5)
        addSubview(line)
        self.backgroundColor = UIColor.white
        
        tabScrollView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: tabBarHeight)
        tabScrollView.showsVerticalScrollIndicator = false
        tabScrollView.showsHorizontalScrollIndicator = false
        tabScrollView.backgroundColor = .clear
        addSubview(tabScrollView)
        
        mainScrollView.frame = CGRect(x: 0, y: tabBarHeight, width: self.bounds.size.width, height: self.bounds.size.height - tabBarHeight)
        mainScrollView.bounces = false
        mainScrollView.isPagingEnabled = true
        mainScrollView.delegate = self
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.showsVerticalScrollIndicator = false
        addSubview(mainScrollView)
    }
    
    public func reloadView(titles: [String],controllers: [UIViewController] ) {
        self.titles = titles
        self.controllers = controllers
        tabScrollView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: tabBarHeight)
        mainScrollView.frame = CGRect(x: 0, y: tabBarHeight, width: self.bounds.size.width, height: self.bounds.size.height - tabBarHeight)
        setupTabScrollView()
        setupChildControllers()
    }
    
    private func goToTab(fromIndex: Int, toIndex: Int) {
        if toIndex >= items.count {
            return
        }
        let item = items[toIndex]
        
        changeItemTitle(fromIndex, to: toIndex)
        //        changeIndicatorViewPosition(fromIndex, to: toIndex)
        resetTabScrollViewContentOffset(item)
        resetMainScrollViewContentOffset(toIndex)
    }
    
    //MARK: --- 配置导航栏
    private func setupTabScrollView() {
        
        //clean
        _ = self.tabScrollView.subviews.map {
            $0.removeFromSuperview()
        }
        self.items.removeAll()
        
        var originX = itemMargin
        for (index,title) in titles.enumerated() {
            
            let item = UILabel()
            item.isUserInteractionEnabled = true
            //计算title长度
            item.frame = CGRect(x: originX, y: 0, width: itemWidth, height: tabScrollView.bounds.height)
            //设置属性
            item.text = title
            item.textAlignment = .center
            item.font = itemFont
            item.textColor = index == currentIndex ? itemSelectedColor : itemUnselectedColor
            //添加tap手势
            let tap = UITapGestureRecognizer(target: self, action: #selector(itemDidClicked(_:)))
            item.addGestureRecognizer(tap)
            
            items.append(item)
            tabScrollView.addSubview(item)
            
            originX = item.frame.maxX + itemMargin * 2
        }
        
        tabScrollView.contentSize = CGSize(width: originX - itemMargin, height: tabScrollView.bounds.height)
        
        if tabScrollView.contentSize.width < self.bounds.width {
            //如果item的长度小于self的width，就重新计算margin排版
            updateLabelsFrame()
        }
        setupIndicatorView()
    }
    
    //MARK: --- item点击事件
    @objc private func itemDidClicked(_ gesture: UITapGestureRecognizer) {
        
        let item = gesture.view as! UILabel
        if item == items[currentIndex] { return }
        let fromIndex = currentIndex
        currentIndex = items.index(of: item)!
        
        goToTab(fromIndex: fromIndex, toIndex: currentIndex)
    }
    
    //MARK: --- 配置子控制器
    private func setupChildControllers() {
        _ = mainScrollView.subviews.map {
            $0.removeFromSuperview()
        }
        for (index,vc) in controllers.enumerated() {
            mainScrollView.addSubview(vc.view)
            vc.view.frame = CGRect(x: CGFloat(index) * mainScrollView.bounds.width, y: 0, width: mainScrollView.bounds.width, height: mainScrollView.bounds.height)
        }
        mainScrollView.contentSize = CGSize(width: CGFloat(controllers.count) * mainScrollView.bounds.width, height: 0)
        mainScrollView.setContentOffset(CGPoint(x: CGFloat(currentIndex) * mainScrollView.bounds.width, y: 0), animated: true)
    }
    
    
    //MARK: --- 改变itemTitle
    private func changeItemTitle(_ from: Int, to: Int) {
        items[from].textColor = itemUnselectedColor
        items[to].textColor = itemSelectedColor
    }
    
    //MARK: --- 改变indicatorView位置
    private func changeIndicatorViewPosition(_ from: Int,to: Int) {
        let frame = items[to].frame
        let indicatorFrame = CGRect(x: frame.origin.x, y: indicatorView.frame.origin.y, width: frame.size.width, height: indicatorHeight)
        
        UIView.animate(withDuration: 0.25) {
            self.indicatorView.frame = indicatorFrame
        }
    }
    //MARK: --- 当item过少时，更新item位置
    private func updateLabelsFrame() {
        let newMargin = itemMargin + (self.bounds.width - tabScrollView.contentSize.width) / CGFloat(items.count * 2)
        var originX = newMargin
        for item in items {
            var frame = item.frame
            frame.origin.x = originX
            item.frame = frame
            originX = frame.maxX + 2 * newMargin
        }
        tabScrollView.contentSize = CGSize(width: originX - newMargin, height: tabBarHeight)
    }
    
    //配置下标
    private func setupIndicatorView() {
        indicatorView.removeFromSuperview()
        
        tabScrollView.addSubview(indicatorView)
        var frame = items[currentIndex].frame
        frame.origin.y = tabScrollView.bounds.height - bottomPadding - indicatorHeight
        frame.size.height = indicatorHeight
        //        frame.size.width = indicatorWidth
        indicatorView.frame = frame
        indicatorView.backgroundColor = itemSelectedColor
        
        indicatorView.layer.cornerRadius = frame.height * 0.5
        indicatorView.layer.masksToBounds = true
    }
    
    //点击item 修改tabScrollView的偏移量
    private func resetTabScrollViewContentOffset(_ item: UILabel) {
        var destinationX: CGFloat = 0
        let itemCenterX = item.center.x
        let scrollHalfWidth = tabScrollView.bounds.width / 2
        //item中心点超过最高滚动范围时
        if tabScrollView.contentSize.width - itemCenterX < scrollHalfWidth {
            destinationX = tabScrollView.contentSize.width - scrollHalfWidth * 2
            tabScrollView.setContentOffset(CGPoint(x: destinationX, y: 0), animated: true)
            return
        }
        //item中心点低于最低滚动范围时
        if itemCenterX > scrollHalfWidth{
            destinationX = itemCenterX - scrollHalfWidth
            tabScrollView.setContentOffset(CGPoint(x: destinationX, y: 0), animated: true)
            return
        }
        
        tabScrollView.setContentOffset(CGPoint(x: 0, y:0), animated: true)
    }
    
    //点击item 修改mainScrollView的偏移量
    private func resetMainScrollViewContentOffset(_ index: Int) {
        mainScrollView.setContentOffset(CGPoint(x: CGFloat(index) * mainScrollView.bounds.width, y: 0), animated: true)
    }
    
    fileprivate func changeItemStatusBecauseDealNormalIndicatorType() {
        let to = Int(mainScrollView.contentOffset.x / mainScrollView.bounds.width)
        let toItem = items[to]
        
        let fromIndex = currentIndex
        currentIndex = items.index(of: toItem)!
        goToTab(fromIndex: fromIndex, toIndex: currentIndex)
    }
    
    //MARK: --- 处理normal状态的 indicatorView
    fileprivate func dealNormalIndicatorType(_ offsetX: CGFloat) {
        if offsetX <= 0 {
            //左边界
            leftIndex = 0
            rightIndex = 0
            
        } else if offsetX >= mainScrollView.contentSize.width {
            //右边界
            leftIndex = items.count - 1
            rightIndex = leftIndex
        } else {
            //中间
            leftIndex = Int(offsetX / mainScrollView.bounds.width)
            rightIndex = leftIndex + 1
        }
        
        let ratio = offsetX / mainScrollView.bounds.width - CGFloat(leftIndex)
        if ratio == 0 { return }
        
        let leftItem = items[leftIndex]
        let rightItem = items[rightIndex]
        
        let totalSpace = rightItem.center.x - leftItem.center.x
        indicatorView.center = CGPoint(x:leftItem.center.x + totalSpace * ratio, y: indicatorView.center.y)
    }
    
    //MARK: --- 处理followText状态的 indicatorView
    fileprivate func dealFollowTextIndicatorType(_ offsetX: CGFloat) {
        if offsetX <= 0 {
            //左边界
            leftIndex = 0
            rightIndex = 0
            
        } else if offsetX >= mainScrollView.contentSize.width {
            //右边界
            leftIndex = items.count - 1
            rightIndex = leftIndex
        } else {
            //中间
            leftIndex = Int(offsetX / mainScrollView.bounds.width)
            rightIndex = leftIndex + 1
        }
        
        let ratio = offsetX / mainScrollView.bounds.width - CGFloat(leftIndex)
        if ratio == 0 { return }
        
        let leftItem = items[leftIndex]
        let rightItem = items[rightIndex]
        
        //-
        let distance: CGFloat = indicatorType == .stretch ? 0 : indicatorAnimatePadding
        var frame = self.indicatorView.frame
        let maxWidth = rightItem.frame.maxX - leftItem.frame.minX - distance * 2
        
        if ratio <= 0.5 {
            frame.size.width = leftItem.frame.width + (maxWidth - leftItem.frame.width) * (ratio / 0.5)
            frame.origin.x = leftItem.frame.minX + distance * (ratio / 0.5)
        } else {
            frame.size.width = rightItem.frame.width + (maxWidth - rightItem.frame.width) * ((1 - ratio) / 0.5)
            frame.origin.x = rightItem.frame.maxX - frame.size.width - distance * ((1 - ratio) / 0.5)
        }
        
        self.indicatorView.frame = frame
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UIScrollViewDelegate
extension YangSliderView: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        switch indicatorType {
        case .normal:
            dealNormalIndicatorType(offsetX)
        case .stretch:
            dealFollowTextIndicatorType(offsetX)
        case .stretchAndMove:
            dealFollowTextIndicatorType(offsetX)
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        changeItemStatusBecauseDealNormalIndicatorType()
    }
    
}


//
//  YangPageControl.swift
//  PersonalResume
//  Page指示器：支持三种类型显示
//  1、颜色值
//  2、单类型图片（只有一种普通、选中图片）
//  3、多类型图片 (每个指示点都有对应的普通、选中图片)
//  Created by yanghuang on 2017/7/19.
//  Copyright © 2017年 com.yang. All rights reserved.
//

import UIKit

// MARK: - 指示器切换事件响应代理
public protocol YangPageControlDelegate: class {
    
    func pageControlChangeTo(page: NSInteger)
    
}

// MARK: - 指示器点对象，只针对图片处理
public class YangPageDot: NSObject {
   public  var dotIndicatorImage: UIImage?
    public var hightLightDotIndicatorImage: UIImage?
}

// MARK: - Page指示器
public class YangPageControl: UIView {
    
    static let defaultPageIndicatorTintColor: UIColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 0.8)
    static let defaultCurrentPageIndicatorTintColor: UIColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
    
    // MARK: - 圆角
    fileprivate var _dotRadius: CGFloat = 0
    
    public var dotRadius: CGFloat {
        get { return _dotRadius }
        set {
            _dotRadius = newValue
            updateDotButtonRadius()
        }
    }
    
    // MARK: - 未选中时色值
    fileprivate var _pageIndicatorTintColor: UIColor = defaultPageIndicatorTintColor
    
    public var pageIndicatorTintColor: UIColor {
        get { return _pageIndicatorTintColor }
        set {
            _pageIndicatorTintColor = newValue
            updateDotButton()
        }
    }
    
    // MARK: - 选中时色值
    fileprivate var _currentPageIndicatorTintColor: UIColor = defaultCurrentPageIndicatorTintColor
    
    public var currentPageIndicatorTintColor: UIColor {
        get { return _currentPageIndicatorTintColor }
        set {
            _currentPageIndicatorTintColor = newValue
            updateDotButton()
        }
    }
    
    // MARK: - 未选中时图片 优先级 > 颜色
    fileprivate var _pageIndicatorImage: UIImage?
    
    public var pageIndicatorImage: UIImage? {
        get { return _pageIndicatorImage }
        set {
            _pageIndicatorImage = newValue
            updateDotButton()
        }
    }
    
    // MARK: - 选中时图片
    fileprivate var _currentPageIndicatorImage: UIImage?
    
    public var currentPageIndicatorImage: UIImage? {
        get { return _currentPageIndicatorImage }
        set {
            _currentPageIndicatorImage = newValue
            updateDotButton()
        }
    }
    
    // MARK: - 位置
    fileprivate var _position: CGPoint = CGPoint(x: 0, y: 0)
    public var position: CGPoint {
        get { return _position }
        set {
            _position = newValue
            self.frame = CGRect(origin: _position, size: self.frame.size)
        }
    }
    
    // MARK: - 当前选中页
    fileprivate var _currentPage: Int = 0
    public var currentPage: Int {
        get { return _currentPage }
        set {
            if _currentPage >= 0 && _currentPage < self.numberOfPages && _currentPage != newValue {
                _currentPage = newValue
                updateDotButton()
                delegate?.pageControlChangeTo(page: currentPage)
            }
        }
    }
    
    fileprivate var numberOfPages: Int = 0
    
    // MARK: - 全自定义 优先级大于 图片
    fileprivate var _dotArray: [YangPageDot] = []
    public var dotArray: [YangPageDot] {
        get { return _dotArray }
        set {
            _dotArray = newValue
            updateDotButton()
        }
    }
    // MARK: - 代理对象
    weak var delegate: YangPageControlDelegate?
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 初始化
   public init(withDotSize size: CGSize, andNumberOfPages number: Int, andDotMargin margin: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: size.width * CGFloat(number) + margin * CGFloat(number - 1), height: size.height))
        
        numberOfPages = number
        
        for i in 0..<numberOfPages {
            let btn = UIButton(type: UIButtonType.custom)
            btn.frame = CGRect(x: size.width * CGFloat(i) + margin * CGFloat(i), y: 0, width: size.width, height: size.height)
            btn.tag = i
            btn.addTarget(self, action: #selector(dotClickAction(btn:)), for: .touchUpInside)
            self.addSubview(btn)
        }
        
        updateDotButton()
    }
}

// MARK: - 事件
extension YangPageControl {
    
    //MARK: - 指示点点击事件
    @objc fileprivate func dotClickAction(btn: UIButton) {
        let index = btn.tag
        currentPage = index < 0 ? 0 : index
    }
    
    //MARK: - 更新指示点
    fileprivate func updateDotButton() {
        for (index, view) in self.subviews.enumerated() {
            if view.tag == currentPage {
                if let currentButton = view as? UIButton {
                    if !dotArray.isEmpty && index < dotArray.count {
                        let dot = dotArray[index]
                        currentButton.setBackgroundImage(dot.hightLightDotIndicatorImage, for: UIControlState.normal)
                        currentButton.setBackgroundImage(dot.hightLightDotIndicatorImage, for: UIControlState.highlighted)
                    } else if let currentImage = currentPageIndicatorImage {
                        currentButton.setBackgroundImage(currentImage, for: UIControlState.normal)
                        currentButton.setBackgroundImage(currentImage, for: UIControlState.highlighted)
                        currentButton.backgroundColor = nil
                    } else {
                        currentButton.setBackgroundImage(nil, for: UIControlState.normal)
                        currentButton.setBackgroundImage(nil, for: UIControlState.highlighted)
                        currentButton.backgroundColor = currentPageIndicatorTintColor
                    }
                }
            } else {
                if let dotButton = view as? UIButton {
                    if !dotArray.isEmpty && index < dotArray.count  {
                        let dot = dotArray[index]
                        dotButton.setBackgroundImage(dot.dotIndicatorImage, for: UIControlState.normal)
                        dotButton.setBackgroundImage(dot.dotIndicatorImage, for: UIControlState.highlighted)
                    } else if let dotImage = pageIndicatorImage {
                        dotButton.setBackgroundImage(dotImage, for: UIControlState.normal)
                        dotButton.setBackgroundImage(dotImage, for: UIControlState.highlighted)
                        dotButton.backgroundColor = nil
                    } else {
                        dotButton.setBackgroundImage(nil, for: UIControlState.normal)
                        dotButton.setBackgroundImage(nil, for: UIControlState.highlighted)
                        dotButton.backgroundColor = pageIndicatorTintColor
                    }
                }
            }
        }
    }
    
    //MARK: - 更新圆角
    fileprivate func updateDotButtonRadius() {
        for view in self.subviews {
            view.layer.cornerRadius = dotRadius
            view.layer.masksToBounds = true
        }
    }
}

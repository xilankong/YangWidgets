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
    public var dotImage: UIImage!
    public var dotSelectedImage: UIImage!
}

// MARK: - Page指示器
public class YangPageControl: UIView {
    
    // MARK: - 圆角
    fileprivate var _dotRadius: CGFloat = 0
    
    public var dotRadius: CGFloat {
        get { return _dotRadius }
        set {
            _dotRadius = newValue
            updateDotButtonRadius()
        }
    }
    
    // MARK: - 圆角
    fileprivate var _dotMargin: CGFloat = 15
    
    public var dotMargin: CGFloat {
        get { return _dotMargin }
        set {
            _dotMargin = newValue
            updateDotButtonSize()
        }
    }
    
    // MARK: - dotSize
    fileprivate var _dotSize: CGSize = CGSize(width: 10, height: 10)
    
    public var dotSize: CGSize {
        get { return _dotSize }
        set {
            _dotSize = newValue
            updateDotButtonSize()
        }
    }
    
    // MARK: - 未选中时色值
    fileprivate var _dotTintColor: UIColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 0.8)
    
    public var dotTintColor: UIColor {
        get { return _dotTintColor }
        set {
            _dotTintColor = newValue
            updateDotButton()
        }
    }
    
    // MARK: - 选中时色值
    fileprivate var _dotSelectedTintColor: UIColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
    
    public var dotSelectedTintColor: UIColor {
        get { return _dotSelectedTintColor }
        set {
            _dotSelectedTintColor = newValue
            updateDotButton()
        }
    }
    
    // MARK: - 未选中时图片 优先级 > 颜色
    fileprivate var _dotImage: UIImage?
    
    public var dotImage: UIImage? {
        get { return _dotImage }
        set {
            _dotImage = newValue
            updateDotButton()
        }
    }
    
    // MARK: - 选中时图片
    fileprivate var _dotSelectedImage: UIImage?
    
    public var dotSelectedImage: UIImage? {
        get { return _dotSelectedImage }
        set {
            _dotSelectedImage = newValue
            updateDotButton()
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
    
    // MARK: - 初始化
   public init(withNumberOfPages number: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: _dotSize.width * CGFloat(number) + _dotMargin * CGFloat(number - 1), height: _dotSize.height))
        
        numberOfPages = number
        
        for i in 0..<numberOfPages {
            let btn = UIButton(type: UIButtonType.custom)
            btn.frame = CGRect(x: dotSize.width * CGFloat(i) + dotMargin * CGFloat(i), y: 0, width: dotSize.width, height: dotSize.height)
            btn.tag = i
            btn.addTarget(self, action: #selector(dotClickAction(btn:)), for: .touchUpInside)
            self.addSubview(btn)
        }
        
        updateDotButton()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                        currentButton.setBackgroundImage(dot.dotSelectedImage, for: UIControlState.normal)
                        currentButton.setBackgroundImage(dot.dotSelectedImage, for: UIControlState.highlighted)
                    } else if let currentImage = dotSelectedImage {
                        currentButton.setBackgroundImage(currentImage, for: UIControlState.normal)
                        currentButton.setBackgroundImage(currentImage, for: UIControlState.highlighted)
                        currentButton.backgroundColor = nil
                    } else {
                        currentButton.setBackgroundImage(nil, for: UIControlState.normal)
                        currentButton.setBackgroundImage(nil, for: UIControlState.highlighted)
                        currentButton.backgroundColor = dotSelectedTintColor
                    }
                }
            } else {
                if let dotButton = view as? UIButton {
                    if !dotArray.isEmpty && index < dotArray.count  {
                        let dot = dotArray[index]
                        dotButton.setBackgroundImage(dot.dotImage, for: UIControlState.normal)
                        dotButton.setBackgroundImage(dot.dotImage, for: UIControlState.highlighted)
                    } else if let dotImage = dotImage {
                        dotButton.setBackgroundImage(dotImage, for: UIControlState.normal)
                        dotButton.setBackgroundImage(dotImage, for: UIControlState.highlighted)
                        dotButton.backgroundColor = nil
                    } else {
                        dotButton.setBackgroundImage(nil, for: UIControlState.normal)
                        dotButton.setBackgroundImage(nil, for: UIControlState.highlighted)
                        dotButton.backgroundColor = dotTintColor
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
    
    //MARK: - 更新dotSize
    fileprivate func updateDotButtonSize() {
        let centerPoint = self.center
        for (index,btn) in self.subviews.enumerated() {
            btn.frame = CGRect(x: dotSize.width * CGFloat(index) + dotMargin * CGFloat(index), y: 0, width: dotSize.width, height: dotSize.height)
        }
        
        self.frame = CGRect(x: 0, y: 0, width: dotSize.width * CGFloat(numberOfPages) + dotMargin * CGFloat(numberOfPages - 1), height: dotSize.height)
        self.center = centerPoint
    }
}

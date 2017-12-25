//
//  YangGuidPageViewController.swift
//  PersonalResume
//  GuidPage引导页：支持图片引导页、带动画引导页
//
//  Created by yanghuang on 2017/7/20.
//  Copyright © 2017年 com.yang. All rights reserved.
//

import UIKit

//MARK: - GuidPage页

open class YangGuidPageView: UIView {
    
    var imageView: UIImageView?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    public init(withImage image: UIImage) {
        super.init(frame: CGRect.zero)
        imageView = UIImageView(image: image)
        self.addSubview(imageView!)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
    
}

//MARK: - GuidPage控制器

open class YangGuidPageViewController: UIViewController {
    
    fileprivate let scrollView: UIScrollView = {
       let _scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        _scrollView.isPagingEnabled = true
        _scrollView.bounces = false
        _scrollView.showsHorizontalScrollIndicator = false
        return _scrollView
    }()
    
    fileprivate var contentOffsetX: CGFloat = 0
    fileprivate var oldContentOffsetX: CGFloat = 0
    
    public var currentPage: Int = 0
    
    public var pageControl: YangPageControl?
    
    public var guidPages: [YangGuidPageView] = []

    //MARK: - 生命周期
    open override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    
    //MARK: - 数据源初始化
    open func initData() {
        fatalError("override and setUp data please")
        //overide
    }
    
    //MARK: - 跳出
    open func turnToRootViewController() {
        fatalError("override please")
        //overide
    }
    
    //MARK: - UI初始化
    func initUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        scrollView.delegate = self
        
        for subView in scrollView.subviews {
            subView.removeFromSuperview()
        }
        for (index,pageView) in self.guidPages.enumerated() {
            pageView.frame = CGRect(x: self.view.frame.size.width * CGFloat(index), y: 0, width: self.view.frame.size.width , height: self.view.frame.size.height)
            scrollView.addSubview(pageView)
            scrollView.contentSize = CGSize(width: self.view.frame.size.width * CGFloat(index + 1), height: self.view.frame.size.height)
        }
        
        pageControl = YangPageControl(withNumberOfPages: self.guidPages.count)
        pageControl?.center = CGPoint(x: view.center.x, y: view.frame.size.height - 40)
        pageControl?.delegate = self
        view.addSubview(pageControl!)
    }

}

//MARK: - 事件
extension YangGuidPageViewController: UIScrollViewDelegate, YangPageControlDelegate {
    
    //MARK: - scroll代理
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let currentPage = Int(floor(Double((scrollView.contentOffset.x - pageWidth / 2.0) / pageWidth))) + 1
        if self.currentPage != currentPage {
            self.currentPage = currentPage
            pageControl?.currentPage = currentPage
        }
    }
    
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        contentOffsetX = scrollView.contentOffset.x
    }
    
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        oldContentOffsetX = scrollView.contentOffset.x
        if oldContentOffsetX == contentOffsetX && (contentOffsetX == CGFloat(guidPages.count - 1) * self.view.frame.size.width) {
            turnToRootViewController()
        }
    }
    
    //MARK: - 跳转到
    open func pageControlChangeTo(page: NSInteger) {
        currentPage = page
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset = CGPoint(x: self.view.frame.size.width * CGFloat(self.currentPage), y: 0)
        }
    }

}

//
//  YangGuidPageViewController.swift
//  PersonalResume
//  GuidPage引导页：支持图片引导页、带动画引导页
//
//  Created by yanghuang on 2017/7/20.
//  Copyright © 2017年 com.yang. All rights reserved.
//

import UIKit

class YangGuidPageView: UIView {
    var backgroundImage: UIImage?
    
    func startAnimation() {}
}

//MARK: - GuidPage引导页
class YangGuidPageViewController: UIViewController {
    
    fileprivate var scrollView: UIScrollView!
    
    open var pageControl: YangPageControl?
    
    open var currentPage: Int = 0
    
    
    
    
    //MARK: - view实现方案
    open var guidPages: [YangGuidPageView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    


}

//MARK: - 事件
extension YangGuidPageViewController: UIScrollViewDelegate, YangPageControlDelegate {


//    
//    func createView(inIndex index: Int, ) -> UIView {
//        
//    }
    //MARK: - scrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let currentPage = Int(floor(Double((scrollView.contentOffset.x - pageWidth / 2.0) / pageWidth))) + 1
        if self.currentPage != currentPage {
            self.currentPage = currentPage
            pageControl?.currentPage = currentPage
        }
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    //MARK: - 跳转到
    func pageControlChangeTo(page: NSInteger) {
        
    }
    
    //MARK: - 跳出
    func turnToRootViewController() {
        
    }
}

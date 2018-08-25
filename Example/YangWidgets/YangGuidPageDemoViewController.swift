//
//  YangGuidPageDemoViewController.swift
//  YangWidgets_Example
//
//  Created by yanghuang on 2017/12/25.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets
import YangNavigationHelper

class YangGuidPageDemoViewController: YangGuidePageViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageControl?.dotSize = CGSize(width: 30, height: 30)
        self.pageControl?.dotMargin = 30
        self.pageControl?.dotImage = #imageLiteral(resourceName: "guidance_v34_dot_1_normal")
        self.pageControl?.dotSelectedImage = #imageLiteral(resourceName: "guidance_v34_dot_1_selected")
    }

    override func initData() {
        let pageOne =  YangGuidePageView()
        pageOne.backgroundColor = UIColor.red
        guidPages.append(pageOne)
        let pageTwo =  YangGuidePageView()
        pageTwo.backgroundColor = UIColor.blue
        guidPages.append(pageTwo)
        let pageThree =  YangGuidePageView(withImage: #imageLiteral(resourceName: "bgImageView"))
        guidPages.append(pageThree)
    }

    override func turnToRootViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}

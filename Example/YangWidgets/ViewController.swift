//
//  ViewController.swift
//  YangWidgets
//
//  Created by xilankong on 07/22/2017.
//  Copyright (c) 2017 xilankong. All rights reserved.
//

import UIKit
import YangWidgets
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var dragBtn = DragButton(frame: CGRect(x: 0, y: 400, width: 50, height: 50))
//        let pageControl = YangPageControl(withDotSize: CGSize(width: 20, height: 20), andNumberOfPages: 4, andDotMargin: 5)
//        view.addSubview(pageControl)
//        pageControl.position = CGPoint(x: 50, y: 250)
//        pageControl.currentPageIndicatorImage = #imageLiteral(resourceName: "guidance_v34_dot_1_normal")
//        pageControl.pageIndicatorImage = #imageLiteral(resourceName: "guidance_v34_dot_1_normal")
//        var array: [YangPageDot] = []
//        for index in 1..<5 {
//            let dot = YangPageDot()
//            dot.dotIndicatorImage = UIImage(named: "guidance_v34_dot_" + "\(index)" + "_normal")
//            dot.hightLightDotIndicatorImage = UIImage(named: "guidance_v34_dot_" + "\(index)" + "_selected")
//            array.append(dot)
//        }
//        pageControl.dotArray = array
//        //        pageControl.dotRadius = 5
        //        pageControl.currentPage = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


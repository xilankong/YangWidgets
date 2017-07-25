//
//  YangSliderMenuViewController.swift
//  YangWidgets
//
//  Created by yanghuang on 2017/7/25.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets

class YangSliderMenuViewController: UIViewController, YangSlideMenuViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.edgesForExtendedLayout = []
        view.backgroundColor = UIColor.white
        
        view.addSubview(UIView())
        
        let menuView = YangSlideMenuView(frame: CGRect(x: 0, y: 150, width: 320, height: 45))
        view.addSubview(menuView)
        
        menuView.update(withDataArray: ["全部", "星期一", "星期二", "星期三", "星期四", "星期五"])
        menuView.layer.borderColor = UIColor.lightGray.cgColor
        menuView.layer.borderWidth = 1
        menuView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    
    func yang_menuItemClickAction(_ label: YangSlideLabel!) {
        
    }

}

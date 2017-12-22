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

    var array = ["全部", "星期一", "星期二", "星期三", "星期四", "星期五"]
    var array2 = ["全部", "星期六", "星期日", "星期一", "星期二", "星期三", "星期四", "星期五"]
    var menuView: YangSlideMenuView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.edgesForExtendedLayout = []
        view.backgroundColor = UIColor.white
        let btn = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 100, width: 100, height: 45)
        btn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        btn.setTitle("change", for: UIControlState.normal)
        btn.addTarget(self, action: #selector(YangSliderMenuViewController.buttonClickAction), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
        
        menuView = YangSlideMenuView(frame: CGRect(x: 0, y: 150, width: 320, height: 45))
        view.addSubview(menuView)
        
        menuView.update(withDataArray: array)
        menuView.layer.borderColor = UIColor.lightGray.cgColor
        menuView.layer.borderWidth = 1
        menuView.slideDelegate = self
    }
    
    func menuView(_ menuView: YangSlideMenuView!, clickActionAt index: Int) {
        print(array[index])
    }
    
    @objc func buttonClickAction() {
        array = array2
        menuView.update(withDataArray: array)
    }
    
}

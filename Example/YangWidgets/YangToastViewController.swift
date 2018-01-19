//
//  YangSliderMenuViewController.swift
//  YangWidgets
//
//  Created by yanghuang on 2017/7/25.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets

class YangToastViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let btn = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 100, width: 100, height: 45)
        btn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        btn.setTitle("change", for: UIControlState.normal)
        btn.addTarget(self, action: #selector(buttonClickAction), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
        
    }
    
    
    @objc func buttonClickAction() {
        view.showToast(withMessage: "测试测试测试测试测试测试测试测试试测试测试测试测试测试试测试测试测试测试测试")
    }
    
}

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
        let textbtn = UIButton(type: UIButtonType.custom)
        textbtn.frame = CGRect(x: 0, y: 100, width: 100, height: 45)
        textbtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        textbtn.setTitle("showText", for: UIControlState.normal)
        textbtn.addTarget(self, action: #selector(textButtonClickAction), for: UIControlEvents.touchUpInside)
        view.addSubview(textbtn)
        
        let btn = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 45)
        btn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        btn.setTitle("change", for: UIControlState.normal)
        btn.addTarget(self, action: #selector(loadingButtonClickAction), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
    }
    
    
    @objc func textButtonClickAction() {
        view.showToast(withMessage: "测试toast")
    }
    
    @objc func loadingButtonClickAction() {
        view.showLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.view.hideLoading()
        }
    }
}

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
        textbtn.setTitle("toast", for: UIControlState.normal)
        textbtn.addTarget(self, action: #selector(textButtonClickAction), for: UIControlEvents.touchUpInside)
        view.addSubview(textbtn)
        
        let btn = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 45)
        btn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        btn.setTitle("loading", for: UIControlState.normal)
        btn.addTarget(self, action: #selector(loadingButtonClickAction), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
        
        
        let progressbtn = UIButton(type: UIButtonType.custom)
        progressbtn.frame = CGRect(x: 100, y: 200, width: 100, height: 45)
        progressbtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        progressbtn.setTitle("progress", for: UIControlState.normal)
        progressbtn.addTarget(self, action: #selector(progressButtonClickAction), for: UIControlEvents.touchUpInside)
        view.addSubview(progressbtn)
    }
    
    @objc func textButtonClickAction() {
        view.showToast(withMessage: "测试toast测")
    }
    
    @objc func loadingButtonClickAction() {
        view.showLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.view.hideLoading()
        }
    }

    
    @objc func progressButtonClickAction() {
        view.showProgressLoading()
        
    }
}

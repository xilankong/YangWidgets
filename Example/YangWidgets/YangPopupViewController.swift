//
//  YangPopupViewController.swift
//  YangWidgets_Example
//
//  Created by yanghuang on 2018/1/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets

class YangPopupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let textbtn = UIButton(type: UIButtonType.custom)
        textbtn.frame = CGRect(x: 0, y: 100, width: 100, height: 45)
        textbtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        textbtn.setTitle("图片popup", for: UIControlState.normal)
        textbtn.addTarget(self, action: #selector(imageButtonClickAction), for: UIControlEvents.touchUpInside)
        view.addSubview(textbtn)
        
        let btn = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 45)
        btn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        btn.setTitle("change", for: UIControlState.normal)
        btn.addTarget(self, action: #selector(normalButtonClickAction), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
    }

    @objc func imageButtonClickAction() {
//        self.showDialog
//        self.show
    }
    
    @objc func normalButtonClickAction() {
        self.showDialog()
    }
}

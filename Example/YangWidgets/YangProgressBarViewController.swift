//
//  YangProgressBarViewController.swift
//  YangWidgets_Example
//
//  Created by yanghuang on 2018/1/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets

class YangProgressBarViewController: UIViewController {

    let progressBar: YangProgressBar = YangProgressBar(frame: CGRect(x: 10, y: 150, width: 300, height: 30))
    let sliderView: UISlider = UISlider(frame: CGRect(x: 10, y: 200, width: 300, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(progressBar)
        progressBar.backgroundColor = UIColor.white
        progressBar.progressValue = 70
        progressBar.textColor = UIColor.black
        
        view.addSubview(sliderView)
        sliderView.addTarget(self, action: #selector(changeSliderValue(_:)), for: .valueChanged)
    }

    @objc func changeSliderValue(_ sender: UISlider) {
        progressBar.progressValue = ceil(CGFloat(sender.value * 10000.0)) / 100.0
    }
    
}

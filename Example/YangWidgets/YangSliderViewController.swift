//
//  YangSliderViewController.swift
//  YangWidgets_Example
//
//  Created by yanghuang on 2018/1/10.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets

class YangSliderViewController: UIViewController, YangSliderViewDelegate, YangSliderViewDataSource {


    let sliderView = YangSliderView(frame: CGRect(x: 0, y: 90, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    var vcs = [UIViewController]()
    var titles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(sliderView)
//        sliderView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor.red
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.yellow
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor.black
        vcs = [vc1, vc2, vc3]
        
        titles = ["one", "two", "three"]
        sliderView.delegate = self
        sliderView.datasouce = self
        sliderView .reloadData()
    }

    func numberOfPage(in yangSliderView: YangSliderView!) -> Int {
        return 3
    }
    
    func yangSliderView(_ yangSliderView: YangSliderView!, controllerAt index: Int) -> UIViewController! {
        return vcs[index]
    }
    
    func yangSliderView(_ yangSliderView: YangSliderView!, titleAt index: Int) -> String! {
        return titles[index]
    }
    

}

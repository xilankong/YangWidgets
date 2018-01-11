//
//  YangSliderViewController.swift
//  YangWidgets_Example
//
//  Created by yanghuang on 2018/1/10.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets

class YangSliderViewController: UIViewController {



    var vcs = [UIViewController]()
    var titles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor.red
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.yellow
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor.black
        vcs = [vc1, vc2, vc3]
        
        titles = ["最新", "精选", "关注"]
        
        let slideMenu = YangSliderView(frame: CGRect(x: 0, y: 100, width:view.frame.width-100, height: view.frame.height), titles: titles, childControllers: vcs)
        
        view.addSubview(slideMenu)
        automaticallyAdjustsScrollViewInsets = false
    }

    
}

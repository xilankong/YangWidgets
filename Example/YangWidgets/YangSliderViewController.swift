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
    let slideMenu = YangSliderView(frame: CGRect(x: 0, y: 100, width:320, height: 586))
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

        slideMenu.reloadView(titles: titles, controllers: vcs)
        view.addSubview(slideMenu)
        automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.addLeftTextButtonItem(withTarget: self, action: #selector(change), andText: "切换")
    }

    @objc func change() {
        slideMenu.currentIndex = Int(arc4random_uniform(3))
    }
}

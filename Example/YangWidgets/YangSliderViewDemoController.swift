//
//  YangSliderViewController.swift
//  YangWidgets_Example
//
//  Created by yanghuang on 2018/1/10.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets
import SnapKit

class YangSliderViewDemoController: UIViewController {

    var vcs = [UIViewController & YangSliderViewContainerDelegate]()
    var titles = [String]()
    let slideMenu = YangSliderView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        let vc1 = YangSliderViewContainerViewController()
        vc1.view.backgroundColor = UIColor.green
        let vc2 = YangSliderViewContainerViewController()
        vc2.view.backgroundColor = UIColor.yellow
        let vc3 = YangSliderViewContainerViewController()
        vc3.view.backgroundColor = UIColor.black
        let vc4 = YangSliderViewContainerViewController()
        vc4.view.backgroundColor = UIColor.purple
        let vc5 = YangSliderViewContainerViewController()
        vc5.view.backgroundColor = UIColor.gray
        vcs = [vc1, vc2, vc3, vc4, vc5]
        
        titles = ["tab-1", "tab-2", "tab-3", "tab-4", "tab-5"]

        slideMenu.reloadView(titles: titles, controllers: vcs)
        view.addSubview(slideMenu)
        automaticallyAdjustsScrollViewInsets = false
        slideMenu.snp.makeConstraints {
            $0.left.right.bottom.equalTo(self.view)
            $0.top.equalTo(self.view).offset(64)
        }
        self.navigationItem.addRightTextButtonItem(withTarget: self, action: #selector(change), andText: "切换")
    }

    @objc func change() {
        let index = (slideMenu.currentIndex + 1) > titles.count - 1 ? 0 : (slideMenu.currentIndex + 1)
        slideMenu.currentIndex = index
    }
}

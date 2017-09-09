//
//  PRTabBarController.swift
//  PersonalResume
//
//  Created by yanghuang on 2017/6/9.
//  Copyright © 2017年 com.yang. All rights reserved.
//

import UIKit
import YangWidgets
import YangNavigationHelper

class YangTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    func initUI() {
        
        let listVC = DemoListViewController()
        let listNV = YangContainerNavigationController(rootViewController: listVC)
        let array = [listNV]
        let names = ["demolist"]
        for (index, vc) in array.enumerated() {
            vc.tabBarItem = UITabBarItem(title: names[index], image: nil, selectedImage: nil)
        }
        
        self.viewControllers = array
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        guard let nav = self.childViewControllers[self.selectedIndex] as? YangContainerNavigationController, let topVc = nav.topViewController else {
            return self.childViewControllers[self.selectedIndex].preferredStatusBarStyle
        }
        return topVc.preferredStatusBarStyle
    }
}

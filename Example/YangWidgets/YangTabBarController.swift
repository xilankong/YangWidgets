//
//  PRTabBarController.swift
//  PersonalResume
//
//  Created by yanghuang on 2017/6/9.
//  Copyright © 2017年 com.yang. All rights reserved.
//

import UIKit
import YangWidgets

class YangTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    func initUI() {
        
        let listVC = DemoListViewController()
        let listNV = RTContainerNavigationController(rootViewController: listVC)
        let skillVC = SkillViewController()
        let skillNV = RTContainerNavigationController(rootViewController: skillVC)
        let homeVC = HomeViewController()
        let homeNV = RTContainerNavigationController(rootViewController: homeVC)
        
        let array = [listNV, skillNV, homeNV]
        let names = ["demolist","skill", "home"]
        for (index, vc) in array.enumerated() {
            vc.tabBarItem = UITabBarItem(title: names[index], image: nil, selectedImage: nil)
        }
        
        self.viewControllers = array
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        guard let nav = self.childViewControllers[self.selectedIndex] as? RTContainerNavigationController, let topVc = nav.topViewController else {
            return self.childViewControllers[self.selectedIndex].preferredStatusBarStyle
        }
        return topVc.preferredStatusBarStyle
    }
}

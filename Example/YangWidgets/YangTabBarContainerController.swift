//
//  YangTabBarContainerController.swift
//  YangWidgets_Example
//
//  Created by yanghuang on 2018/1/24.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets

class YangNormalTabBarController: ESTabBarController {}
class YangBounceTabBarController: ESTabBarController {}
class YangIrregularityTabBarController: ESTabBarController {}

class YangTabBarContainerController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(10)) / 10.0, green: CGFloat(arc4random_uniform(10)) / 10.0, blue: CGFloat(arc4random_uniform(10)) / 10.0, alpha: 1.0)
    }
    
}

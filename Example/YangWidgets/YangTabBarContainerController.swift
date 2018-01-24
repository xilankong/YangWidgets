//
//  YangTabBarContainerController.swift
//  YangWidgets_Example
//
//  Created by yanghuang on 2018/1/24.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets

open class YangTabBarTestController: YangTabBarController {
    
    
}


class YangTabBarContainerController: UIViewController {
    
    let button: UIButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(10)) / 10.0, green: CGFloat(arc4random_uniform(10)) / 10.0, blue: CGFloat(arc4random_uniform(10)) / 10.0, alpha: 1.0)
        button.setTitle("  Click to pop or dismiss  ", for: .normal)
        button.backgroundColor = self.view.backgroundColor
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(white: 100.0 / 255.0, alpha: 1.0).cgColor
        button.layer.cornerRadius = 16.0
        button.setTitleColor(UIColor(white: 100.0 / 255.0, alpha: 1.0), for: .normal)
        button.addTarget(self, action: #selector( YangTabBarContainerController.backAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let size = button.sizeThatFits(self.view.bounds.size)
        button.frame = CGRect.init(x: (self.view.bounds.size.width - size.width) / 2.0, y: self.view.bounds.size.height - 120, width: size.width, height: 42.0)
    }
    
    @objc public func backAction() {
        if let navigationController = navigationController {
            if navigationController.viewControllers.count > 1 {
                navigationController.popViewController(animated: true)
                return
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

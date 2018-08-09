//
//  YangDropMenuViewController.swift
//  YangWidgets_Example
//
//  Created by yanghuang on 2017/12/22.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets

class YangDropMenuViewController: UIViewController, YangDropMenuDelegate, YangDropMenuDataSource {

    let menuBar: UIControl = UIControl(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 45))
    let menu = YangDropMenuView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 0))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        
        view.addSubview(menuBar)
        menuBar.backgroundColor = UIColor.red
        menuBar.addTarget(self, action: #selector(showIn), for: .touchUpInside)
        menu.delegate = self
        menu.dataSource = self
    }
    
    @objc func showIn() {
        menu.show(in: view, andOrigin: CGPoint(x: 0, y: 145))
    }
    
    func numberOfSections(inMenu menu: YangDropMenuView!) -> Int {
        return 2
    }
    
    func menu(_ menu: YangDropMenuView!, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func menu(_ menu: YangDropMenuView!, titleForRowAt indexPath: IndexPath!) -> String! {
        return "测试"
    }
}

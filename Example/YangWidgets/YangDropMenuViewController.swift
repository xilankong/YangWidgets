//
//  YangDropMenuViewController.swift
//  YangWidgets_Example
//
//  Created by yanghuang on 2017/12/22.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets

class YangDropMenuViewController: UIViewController, YangDropMenuViewDataSource, YangDropMenuViewDelegate  {

    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let menu = YangDropMenuView(origin: CGPoint(x: 0, y: 100), andHeight: 45)
        menu?.delegate = self
        menu?.dataSource = self
        
        view.addSubview(menu!)

    }
    
    func numberOfColumns(inMenu menu: YangDropMenuView!) -> Int {
        return 2
    }
    
    func menu(_ menu: YangDropMenuView!, numberOfRowsInColumn column: Int, leftOrRight: Int, leftRow: Int) -> Int {
        return 3
    }
    
    func menu(_ menu: YangDropMenuView!, titleForRowAt indexPath: YangIndexPath!) -> String! {
        return "测试"
    }
    
    func menu(_ menu: YangDropMenuView!, titleForColumn column: Int) -> String! {
        return "测试"
    }
    
    func widthRatio(ofLeftColumn column: Int) -> CGFloat {
        return 0.2
    }
    
    func haveRightTableView(inColumn column: Int) -> Bool {
        return false
    }
    
    func currentLeftSelectedRow(_ column: Int) -> Int {
        return 1
    }

}

//
//  YangDragButtonViewController.swift
//  YangWidgets_Example
//
//  Created by yanghuang on 2017/12/22.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets

class YangDragButtonViewController: UIViewController {
    
    let btn = DragButton(frame: CGRect(x: 0, y: 100, width: 50, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        btn.backgroundColor = UIColor.red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btn.addButtonToKeyWindow()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        btn.removeFromKeyWindow()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

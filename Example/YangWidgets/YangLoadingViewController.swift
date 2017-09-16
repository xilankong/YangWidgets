//
//  YangLoadingViewController.swift
//  YangWidgets_Example
//
//  Created by yanghuang on 2017/9/9.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets

class YangLoadingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }


    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = "123"
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 320, height: 568), style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    

}

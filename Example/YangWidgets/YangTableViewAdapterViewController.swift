//
//  YangTableViewAdapterViewController.swift
//  YangWidgets_Example
//
//  Created by yanghuang on 2018/1/26.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets

class YangTableViewAdapterViewController: UIViewController {

    let tableView = UITableView(frame: .zero, style: .grouped)
    var tableViewAdapter: YangTableViewAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initTableView()
    }
    
    func initUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }
    }
    
    func initTableView() {
        tableViewAdapter = YangTableViewAdapter(tableView) { (indexPath, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = "测试" + "\(indexPath.row)"
            return cell
        }
        
        tableViewAdapter.numberOfRowsInSection = { section in
            return 5
        }
        
        tableViewAdapter.cellDidSelectedAtIndexPath = { (indexPath, tableView) in
            self.view.showToast(withMessage: "测试点击效果")
        }
        
        tableViewAdapter.cellHeightForRowAtIndexPath = { (indexPath, tableView) in
            return 100
            
        }
    }

}

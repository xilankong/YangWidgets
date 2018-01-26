//
//  YangPopupViewController.swift
//  YangWidgets_Example
//
//  Created by yanghuang on 2018/1/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets

class YangPopupViewController: UIViewController {

    let array = ["simple","ok/cancle"]
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
            cell.textLabel?.text = self.array[indexPath.row]
            return cell
        }
        
        tableViewAdapter.numberOfRowsInSection = { section in
            return self.array.count
        }
        
        tableViewAdapter.cellDidSelectedAtIndexPath = { (indexPath, tableView) in
            switch indexPath.row {
            case 0:
                self.showDialog(title: "测试", message: "测试内容", buttonText: "知道了") {
                    self.view.showToast(withMessage: "关闭")
                }
            case 1:
                self.showDialog(title: "测试两个按钮", message: "测试内容", okButtonText: "确定", cancleButtonText: "取消", okCompletion: {
                    self.view.showToast(withMessage: "ok")
                }, cancleCompletion: {
                    self.view.showToast(withMessage: "cancle")
                })
            case 2:
                self.showImageDialog()
            default:
                self.showImageDialog()
            }
        }
        
    }
}

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

    let array = [["simple","ok/cancle","text","security","custom"], ["ok/cancle","自定义无取消","自定义带取消"]]
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
            cell.textLabel?.text = self.array[indexPath.section][indexPath.row]
            return cell
        }
        
        tableViewAdapter.numberOfSection = {
            return self.array.count
        }
        
        tableViewAdapter.numberOfRowsInSection = { section in
            return self.array[section].count
        }
        
        tableViewAdapter.tableViewSessionHeaderHeight = { (indexPath, tableView) in
            return 30
        }
        
        tableViewAdapter.cellDidSelectedAtIndexPath = { (indexPath, tableView) in
            tableView.deselectRow(at: indexPath, animated: true)
            if indexPath.section == 0 {
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
                    self.showTextEntryDialog(title: "测试textField", message: "测试内容", pattern: "[a-zA-Z0-9]*", minLength: 8, okButtonText: "确定", cancleButtonText: "取消", animated: true, okCompletion: { text in
                        self.view.showToast(withMessage: "ok" + "\(text)")
                    }, cancleCompletion: {
                        
                    })
                case 3:
                    self.showPasswordDialog(title: "测试密码框", message: "测试内容", pattern: "[a-zA-Z0-9]*", minLength: 8, okButtonText: "确定", cancleButtonText: "取消", animated: true, okCompletion: { text in
                        self.view.showToast(withMessage: "ok" + "\(text)")
                    }, cancleCompletion: {
                        
                    })
                case 4:
                    let alertVC = self.showCustomAlertDialog(title: "全空白定制", message: "666666")
                    let cancleAction = YangAlertAction(title: "取消", style: .cancel, handler: { action in
                        
                    })
                    let okAction = YangAlertAction(title: "确定", style: .default, handler: { action in
                        
                    })
                    
                    alertVC.addTextFieldWithConfigurationHandler({ (textField) in
                        
                        textField?.textFieldPattern = ""
                        textField?.textFieldMinLength = 5
                    })
                    
                    alertVC.addAction(cancleAction)
                    alertVC.addAction(okAction)
                    
                    self.present(alertVC, animated: true, completion: nil)
                default:
                    self.showImageDialog()
                }
            } else if indexPath.section == 1 {
                switch indexPath.row {
                case 0:
                    self.showActionSheet(okButtonText: "我选A", cancleButtonText: "放弃", okCompletion: {
                        self.view.showToast(withMessage: "ok")
                    }, cancleCompletion: {
                        self.view.showToast(withMessage: "cancle")
                    })
                case 1:
                    self.showActionSheet(customTextArray: ["one","two","three"], completion: { (index) in
                        self.view.showToast(withMessage: "ok" + "\(index)")
                    })
                case 2:
                    self.showActionSheet(title: "自定义有取消", message: "这是一个测试消息", customTextArray: ["one","two","three"], cancleButtonText: "cancle", completion: { (index) in
                        self.view.showToast(withMessage: "ok" + "\(index)")
                    }, cancleCompletion: {
                        self.view.showToast(withMessage: "cancle")
                    })
                default:
                    self.showImageDialog()
                }
            }
        }
        
    }
}

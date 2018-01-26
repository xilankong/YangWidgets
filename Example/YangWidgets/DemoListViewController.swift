//
//  ViewController.swift
//  YangWidgets
//
//  Created by xilankong on 07/22/2017.
//  Copyright (c) 2017 xilankong. All rights reserved.
//

import UIKit
import YangWidgets
import SnapKit

class DemoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var dataList: [String] = ["YangDropMenuViewController",
         "YangGuidPageDemoViewController",
         "YangSliderViewDemoController",
         "YangDragButtonViewController",
         "YangToastViewController",
         "YangTabBarListViewController",
         "YangProgressBarViewController",
         "YangPopupViewController",
         "YangTableViewAdapterViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: UITableViewStyle.plain)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
}

extension DemoListViewController {
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = dataList[indexPath.row]
        return cell
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
        let classStringName = "\(appName).\(dataList[indexPath.row])"

        guard let vc = NSClassFromString(classStringName) as? UIViewController.Type else {
            return
        }
        if dataList[indexPath.row] == "YangGuidPageDemoViewController" {
            self.navigationController?.modalViewController(vc.init(), needNavigation: false, sender: nil)
        }else {
            self.navigationController?.pushViewController(vc.init(), animated: true)
        }
    }
    
}

//
//  ViewController.swift
//  YangWidgets
//
//  Created by xilankong on 07/22/2017.
//  Copyright (c) 2017 xilankong. All rights reserved.
//

import UIKit
import YangWidgets
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataList: [String] = ["YangSliderMenuViewController",
         "YangSliderMenuViewController",
         "YangSliderMenuViewController"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
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
        self.navigationController?.pushViewController(vc.init(), animated: true)
    }
    
}

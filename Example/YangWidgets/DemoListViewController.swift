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
         "YangTabBarTestController"]
    
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
        } else if dataList[indexPath.row] == "YangTabBarTestController" {
            let tabBarVC = YangTabBarTestController()
            tabBarVC.shouldHijackHandler = {
                tabbar, vc, index in
                if index == 2 {
                    return true
                }
                return false
            }
            
            
            let vc1 = YangTabBarContainerController()
            let vc2 = YangTabBarContainerController()
            let vc3 = YangTabBarContainerController()
            let vc4 = YangTabBarContainerController()
            let vc5 = YangTabBarContainerController()
            
            vc1.tabBarItem = YangBackgroundTabBarItem.init(title: "one", image: #imageLiteral(resourceName: "guidance_v34_dot_1_normal"), selectedImage: #imageLiteral(resourceName: "guidance_v34_dot_1_selected"))
            vc2.tabBarItem = YangTabBarItem.init(title: "two", image: #imageLiteral(resourceName: "guidance_v34_dot_2_normal"), selectedImage: #imageLiteral(resourceName: "guidance_v34_dot_2_selected"))
            vc3.tabBarItem = YangIrregularityBasicTabBarItem.init(title: nil, image: #imageLiteral(resourceName: "photo_verybig"), selectedImage: #imageLiteral(resourceName: "photo_verybig"))
            vc4.tabBarItem = YangBouncesTabBarItem.init(title: "three", image: #imageLiteral(resourceName: "guidance_v34_dot_3_normal"), selectedImage: #imageLiteral(resourceName: "guidance_v34_dot_3_selected"))
            vc5.tabBarItem = YangTabBarItem.init(title: "four", image: #imageLiteral(resourceName: "guidance_v34_dot_4_normal"), selectedImage: #imageLiteral(resourceName: "guidance_v34_dot_4_selected"))
            vc1.tabBarItem.badgeValue = "1"
            vc2.tabBarItem.badgeValue = "99+"
            vc4.tabBarItem.badgeValue = "new"
            vc5.tabBarItem.badgeValue = ""
            
            tabBarVC.viewControllers = [vc1, vc2, vc3, vc4, vc5]
            tabBarVC.selectedIndex = 1
            self.navigationController?.pushViewController(tabBarVC, animated: true)
            
        } else {
            self.navigationController?.pushViewController(vc.init(), animated: true)
        }
    }
    
}

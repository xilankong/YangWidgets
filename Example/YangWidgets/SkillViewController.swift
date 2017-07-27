//
//  ViewController.swift
//  PersonalResume
//
//  Created by yanghuang on 2017/6/7.
//  Copyright © 2017年 com.yang. All rights reserved.
//

import UIKit

class SkillViewController: UIViewController {
    
    static let tableViewHeadHight: CGFloat = 200 / 320  * App.screenWidth
    static let triggerMargin: CGFloat = 30
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: App.screenWidth, height: App.screenHeight - 44), style: UITableViewStyle.plain)
         tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        self.rt_navigationBackgroundColor(App.navColor)
        self.rt_navigationStatusBarStatus(.lightContent)
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.isTranslucent = true
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - tableView代理、数据源
extension SkillViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate  {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "123456"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.navigationController?.navigationBar)
        self.navigationController?.pushViewController(DemoListViewController(), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            var height = (0 - (scrollView.contentOffset.y))
            if height < -44 {
                height = -44
            } else if height > 0 {
                height = 0
            }
            self.navigationController?.navigationBar.lt_setTranslationY(height)
    }
}

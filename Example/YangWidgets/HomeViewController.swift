//
//  HomeViewController.swift
//  PersonalResume
//
//  Created by yanghuang on 2017/6/9.
//  Copyright © 2017年 com.yang. All rights reserved.
//

import UIKit
import YangWidgets

class HomeViewController: UIViewController {
    
    static let tableViewHeadHight: CGFloat = 200 / 320  * App.screenWidth
    static let triggerMargin: CGFloat = 30
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: UITableViewStyle.plain)
        return tableView
    }()

    lazy var bgImageView: UIImageView = {
        let image = #imageLiteral(resourceName: "bgImageView")
        let bgView = UIImageView(image: image)
        bgView.frame = CGRect(x: 0, y: 0, width: App.screenWidth, height: HomeViewController.tableViewHeadHight)
        bgView.contentMode = UIViewContentMode.center
        bgView.clipsToBounds = true
        return bgView
    }()
    
    var iconView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        self.automaticallyAdjustsScrollViewInsets = false
    }

    func initUI() {
        self.rt_navigationBackgroundColor(UIColor(white: 1, alpha: 0))
        self.rt_navigationStatusBarStatus(.lightContent)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = tableHeadViewInit()
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 15))
        leftView.backgroundColor = UIColor.red
        let button = self.navigationItem.addRightTextButtonItem(withTarget: self, action: Selector("backAction"), andText: "退出")
        button?.titleLabel?.font = UIFont.systemFont(ofSize: 11.0)
    }

    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - tableHeadView init
extension HomeViewController {
    
    func tableHeadViewInit() -> UIView {
        let tableHeadView = UIView(frame: CGRect(x: 0, y: 0, width: App.screenWidth, height: HomeViewController.tableViewHeadHight))
        tableHeadView.backgroundColor = UIColor.clear
        tableHeadView.addSubview(bgImageView)
        let iconView = UIImageView(image: #imageLiteral(resourceName: "portrait"))
        iconView.layer.cornerRadius = 35
        iconView.layer.masksToBounds = true
        tableHeadView.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        return tableHeadView
    }
}

// MARK: - tableView代理、数据源
extension HomeViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate  {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "123456"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.navigationController?.pushViewController(DetialViewController(), animated: true)
    }
    
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            if (bgImageView.image?.size.height)! > (HomeViewController.tableViewHeadHight - scrollView.contentOffset.y){
                bgImageView.frame = CGRect(x: 0, y: scrollView.contentOffset.y, width: App.screenWidth, height: HomeViewController.tableViewHeadHight - scrollView.contentOffset.y)
            }
        }
        
        if (scrollView.contentOffset.y < (HomeViewController.tableViewHeadHight - App.navHeight - HomeViewController.triggerMargin)){
            self.rt_navigationBackgroundColor(UIColor(white: 1, alpha: 0))
            self.rt_navigationStatusBarStatus(.lightContent)
            self.title = ""
        }else if (scrollView.contentOffset.y >= (HomeViewController.tableViewHeadHight - App.navHeight - HomeViewController.triggerMargin) && scrollView.contentOffset.y <= (HomeViewController.tableViewHeadHight - App.navHeight) ){
            let alpha = ((scrollView.contentOffset.y - (HomeViewController.tableViewHeadHight - App.navHeight - HomeViewController.triggerMargin)) / HomeViewController.triggerMargin)

            self.rt_navigationBackgroundColor(UIColor(white: 1, alpha: alpha))
            self.rt_navigationStatusBarStatus(.default)
            self.title = ""
        }else if (scrollView.contentOffset.y > (HomeViewController.tableViewHeadHight - App.navHeight)){
            self.rt_navigationBackgroundColor(UIColor(white: 1, alpha: 1))
            self.rt_navigationStatusBarStatus(.default)
            self.title = "HOME"
        }
    }
}

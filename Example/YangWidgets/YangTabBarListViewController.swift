//
//  YangTabBarListViewController.swift
//  YangWidgets_Example
//
//  Created by yanghuang on 2018/1/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import YangWidgets

class YangTabBarListViewController: UITableViewController {

    let array = ["YangNormalTabBarController",
    "YangBounceTabBarController",
    "YangIrregularityTabBarController",
    "YangBackgroundTabBarController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if array[indexPath.row] == "YangNormalTabBarController" {
            let tabBarVC = YangNormalTabBarController()
            
            let vc1 = YangTabBarContainerController()
            let vc2 = YangTabBarContainerController()
            let vc3 = YangTabBarContainerController()
            let vc4 = YangTabBarContainerController()
            
            vc1.tabBarItem = ESTabBarItem.init(title: "home", image:  #imageLiteral(resourceName: "home"), selectedImage:  #imageLiteral(resourceName: "home_1"), tag: 0)
            vc2.tabBarItem = ESTabBarItem.init(title: "shop", image:  #imageLiteral(resourceName: "shop"), selectedImage:  #imageLiteral(resourceName: "shop_1"), tag: 1)
            vc3.tabBarItem = ESTabBarItem.init(title: "favor", image: #imageLiteral(resourceName: "favor"), selectedImage:  #imageLiteral(resourceName: "favor_1"), tag: 3)
            vc4.tabBarItem = ESTabBarItem.init(title: "me", image:  #imageLiteral(resourceName: "cardboard"), selectedImage:  #imageLiteral(resourceName: "cardboard_1"), tag: 4)
            
            vc1.tabBarItem.badgeValue = "1"
            vc2.tabBarItem.badgeValue = "99+"
            vc3.tabBarItem.badgeValue = "new"
            vc4.tabBarItem.badgeValue = ""
            
            tabBarVC.viewControllers = [vc1, vc2, vc3, vc4]
            tabBarVC.selectedIndex = 1
            self.navigationController?.pushViewController(tabBarVC, animated: true)
            
        }  else if array[indexPath.row] == "YangBounceTabBarController" {
            let tabBarVC = YangBounceTabBarController()
            let vc1 = YangTabBarContainerController()
            let vc2 = YangTabBarContainerController()
            let vc3 = YangTabBarContainerController()
            let vc4 = YangTabBarContainerController()
            let vc5 = YangTabBarContainerController()
            
            vc1.tabBarItem = ESTabBarItem.init(YangBouncesContentView(), title: "home", image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home_1"), tag: 0)
            vc2.tabBarItem = ESTabBarItem.init(YangBouncesContentView(), title: "shop", image: #imageLiteral(resourceName: "shop"), selectedImage: #imageLiteral(resourceName: "shop_1"), tag: 1)
            vc3.tabBarItem = ESTabBarItem.init(YangBouncesContentView(), title: nil, image: #imageLiteral(resourceName: "photo_big"), selectedImage: #imageLiteral(resourceName: "photo_big"), tag: 2)
            vc4.tabBarItem = ESTabBarItem.init(YangBouncesContentView(), title: "favor", image:#imageLiteral(resourceName: "favor"), selectedImage: #imageLiteral(resourceName: "favor_1"), tag: 3)
            vc5.tabBarItem = ESTabBarItem.init(YangBouncesContentView(), title: "me", image: #imageLiteral(resourceName: "cardboard"), selectedImage: #imageLiteral(resourceName: "cardboard_1"), tag: 4)
            
            tabBarVC.viewControllers = [vc1, vc2, vc3, vc4, vc5]
            tabBarVC.selectedIndex = 2
            self.navigationController?.pushViewController(tabBarVC, animated: true)
            
        }   else if array[indexPath.row] == "YangIrregularityTabBarController" {
            let tabBarVC = YangIrregularityTabBarController()
            tabBarVC.shouldHijackHandler = {
                tabbar, vc, index in
                if index == 2 {
                    return true
                }
                return false
            }
            tabBarVC.didHijackHandler = { tabBarVC, viewController, index in
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
                    let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
                    alertController.addAction(takePhotoAction)
                    let selectFromAlbumAction = UIAlertAction(title: "do sth else", style: .default, handler: nil)
                    alertController.addAction(selectFromAlbumAction)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    tabBarVC.present(alertController, animated: true, completion: nil)
                }
            }
            
            let vc1 = YangTabBarContainerController()
            let vc2 = YangTabBarContainerController()
            let vc3 = YangTabBarContainerController()
            let vc4 = YangTabBarContainerController()
            let vc5 = YangTabBarContainerController()
            
            vc1.tabBarItem = ESTabBarItem.init(YangBouncesContentView(), title: "home", image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home_1"), tag: 0)
            vc2.tabBarItem = ESTabBarItem.init(YangBouncesContentView(), title: "shop", image: #imageLiteral(resourceName: "shop"), selectedImage: #imageLiteral(resourceName: "shop_1"), tag: 1)
            vc3.tabBarItem = ESTabBarItem.init(YangIrregularityBasicContentView(), title: nil, image: #imageLiteral(resourceName: "photo_verybig"), selectedImage: #imageLiteral(resourceName: "photo_verybig"), tag: 2)
            vc4.tabBarItem = ESTabBarItem.init(YangBouncesContentView(), title: "favor", image:#imageLiteral(resourceName: "favor"), selectedImage: #imageLiteral(resourceName: "favor_1"), tag: 3)
            vc5.tabBarItem = ESTabBarItem.init(YangBouncesContentView(), title: "me", image: #imageLiteral(resourceName: "cardboard"), selectedImage: #imageLiteral(resourceName: "cardboard_1"), tag: 4)
            
            tabBarVC.viewControllers = [vc1, vc2, vc3, vc4, vc5]
            tabBarVC.selectedIndex = 1
            self.navigationController?.pushViewController(tabBarVC, animated: true)
            
        } else if array[indexPath.row] == "YangBackgroundTabBarController" {
            let tabBarVC = YangIrregularityTabBarController()
            if let tabBar = tabBarVC.tabBar as? ESTabBar {
                tabBar.itemCustomPositioning = .fillIncludeSeparator
            }

            let vc1 = YangTabBarContainerController()
            let vc2 = YangTabBarContainerController()
            let vc4 = YangTabBarContainerController()
            let vc5 = YangTabBarContainerController()
            
            vc1.tabBarItem = ESTabBarItem.init(YangBackgroundContentView(), title: "home", image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home_1"), tag: 0)
            vc2.tabBarItem = ESTabBarItem.init(YangBackgroundContentView(), title: "shop", image: #imageLiteral(resourceName: "shop"), selectedImage: #imageLiteral(resourceName: "shop_1"), tag: 1)
            vc4.tabBarItem = ESTabBarItem.init(YangBackgroundContentView(), title: "favor", image:#imageLiteral(resourceName: "favor"), selectedImage: #imageLiteral(resourceName: "favor_1"), tag: 3)
            vc5.tabBarItem = ESTabBarItem.init(YangBackgroundContentView(), title: "me", image: #imageLiteral(resourceName: "cardboard"), selectedImage: #imageLiteral(resourceName: "cardboard_1"), tag: 4)
            if let tabBarItem = vc5.tabBarItem as? ESTabBarItem {
                tabBarItem.badgeColor = UIColor.orange
            }
            vc5.tabBarItem.badgeValue = "5"
            tabBarVC.viewControllers = [vc1, vc2, vc4, vc5]
            tabBarVC.selectedIndex = 1
            self.navigationController?.pushViewController(tabBarVC, animated: true)
            
        }
    }

}

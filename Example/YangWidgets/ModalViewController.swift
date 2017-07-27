//
//  ModalViewController.swift
//  YangWidgets
//
//  Created by huang on 2017/7/27.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 150, width: 320, height: 100 )
        view.addSubview(btn)
        btn.addTarget(self, action: Selector("action"), for: UIControlEvents.touchUpInside)
        btn.setTitle("adfaf", for: UIControlState.normal)
        btn.setTitleColor(UIColor.gray, for: UIControlState.normal)
    }

    func action() {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

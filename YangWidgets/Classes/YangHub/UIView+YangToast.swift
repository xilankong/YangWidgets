//
//  UIView+YangHub.swift
//  Pods-YangWidgets_Example
//
//  Created by yanghuang on 2018/1/19.
//

import UIKit

public extension UIView {
    
    public func showToast(withMessage message: String) {
        HUD.dimsBackground = false
//        HUD.show(.labeledSuccess(title: nil, subtitle: nil))
//        HUD.show(.label("测试"))
//        HUD.show(.systemActivity)
        HUD.show(.image(#imageLiteral(resourceName: "portrait")))
//        HUD.hide(afterDelay: 1.5)
    }
    
    public func showToast(withMessage: String, dismissAfter: TimeInterval) {
        
    }
    
    public func showToast(withMessage: String, dismissAfter: TimeInterval, dismissComplete: (() -> Void)) {
        
    }
}

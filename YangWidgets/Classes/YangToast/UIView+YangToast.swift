//
//  UIView+YangHub.swift
//  Pods-YangWidgets_Example
//
//  Created by yanghuang on 2018/1/19.
//

import UIKit

public extension UIView {
    
    public func showToast(withMessage message: String) {
        HUD.show(.label("测试弹窗"))
        HUD.hide(afterDelay: 1.5)
    }
    
    public func showToast(withMessage message: String, dismissAfter time: TimeInterval) {

    }
    
    public func showToast(withMessage message: String, dismissAfter time: TimeInterval, dismissComplete complete: @escaping (() -> Void)) {

    }
    
    public func showLoading() {
        
    }
    
    public func hideLoading() {
        
    }
}

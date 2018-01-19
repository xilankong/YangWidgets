//
//  UIView+YangHub.swift
//  Pods-YangWidgets_Example
//
//  Created by yanghuang on 2018/1/19.
//

import UIKit

public extension UIView {
    
    public func showToast(withMessage message: String) {
        HUD.show(.label(message), onView: self)
        HUD.hide(afterDelay: 1.5)
    }
    
    public func showToast(withMessage message: String, dismissAfter time: TimeInterval) {
        HUD.show(.label(message), onView: self)
        HUD.hide(afterDelay: time)
    }
    
    public func showToast(withMessage message: String, dismissAfter time: TimeInterval, dismissComplete complete: @escaping (() -> Void)) {
        HUD.show(.label(message), onView: self)
        HUD.hide(afterDelay: time) { (result) in
            complete()
        }
    }
    
    public func showLoading() {
        HUD.show(.loading)
    }
    
    public func hideLoading() {
        HUD.hide()
    }
}

//
//  UIView+YangHub.swift
//  Pods-YangWidgets_Example
//
//  Created by yanghuang on 2018/1/19.
//

import UIKit

@objc public extension UIView {
    
    @objc public func showToast(withMessage message: String) {
        
        ToastOverlays.removeAllToast(inView: self)
        let toast = ToastOverlays.showToast(inView: self, withText: message)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            toast.removeFromSuperview()
        }
    }
    
    @objc public func showToast(withMessage message: String, dismissAfter time: TimeInterval) {
        
        ToastOverlays.removeAllToast(inView: self)
        let toast = ToastOverlays.showToast(inView: self, withText: message)
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            toast.removeFromSuperview()
        }
    }
    
    @objc public func showToast(withMessage message: String, dismissAfter time: TimeInterval, dismissComplete complete: @escaping (() -> Void)) {
        
        ToastOverlays.removeAllToast(inView: self)
        let toast = ToastOverlays.showToast(inView: self, withText: message)
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            toast.removeFromSuperview()
            complete()
        }
    }
    
    @objc public func showLoading() {
        ToastOverlays.removeAllToast(inView: self)
        ToastOverlays.showLoading(inView: self)
    }
    
    @objc public func showLoading(withText text: String) {
        ToastOverlays.removeAllToast(inView: self)
        ToastOverlays.showLoading(inView: self, withText: text)
    }

    
    @objc public func hideLoading() {
        ToastOverlays.removeAllToast(inView: self)
    }
    
    @objc public func showProgressLoading() {
        
        ToastOverlays.removeAllToast(inView: self)
        ToastOverlays.showProgressLoading(inView: self, withText: "progress")
        ToastOverlays.updateLoadingProgress(self, progress: 0.6)
    }
    
}

//
//  UIView+YangHub.swift
//  Pods-YangWidgets_Example
//
//  Created by yanghuang on 2018/1/19.
//

import UIKit

@objc public extension UIView {
    
    @objc public func showToast(withMessage message: String) {
        ToastOverlays.showToast(inView: self, withText: message)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            ToastOverlays.removeAllToast(inView: self)
        }
    }
    
    @objc public func showToast(withMessage message: String, dismissAfter time: TimeInterval) {
        ToastOverlays.showToast(inView: self, withText: message)
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            ToastOverlays.removeAllToast(inView: self)
        }
    }
    
    @objc public func showToast(withMessage message: String, dismissAfter time: TimeInterval, dismissComplete complete: @escaping (() -> Void)) {
        ToastOverlays.showToast(inView: self, withText: message)
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            ToastOverlays.removeAllToast(inView: self)
            complete()
        }
    }
    
    @objc public func showLoading() {
        ToastOverlays.showLoading(inView: self, withText: "wait a moment")
    }
    
    @objc public func hideLoading() {
        ToastOverlays.removeAllToast(inView: self)
    }
    
    @objc public func showProgressLoading() {
        ToastOverlays.showProgressLoading(inView: self, withText: "progress")
        ToastOverlays.updateLoadingProgress(self, progress: 0.6)
    }
    
}

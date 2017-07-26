//
//  PRHelper.swift
//  PersonalResume
//
//  Created by yanghuang on 2017/6/7.
//  Copyright © 2017年 com.yang. All rights reserved.
//
import UIKit
import Foundation
import SnapKit

class App: NSObject {
    
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    static let navHeight: CGFloat = 64
    static let navColor = UIColor(red: 1.0, green: 0.41, blue: 0.27, alpha: 1.0)
    static let textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.0)
    static let lineColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0)
    
    static func navColor(alpha: CGFloat) -> UIColor {
        return UIColor(red: 1.0, green: 0.41, blue: 0.27, alpha: alpha)
    }
    
    static open func methodSwizze(cls:AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(cls, originalSelector)
        let swizzleMethod = class_getInstanceMethod(cls, swizzledSelector)
        
        let didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))
        if didAddMethod {
            class_replaceMethod(cls, swizzledSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzleMethod)
        }
    }
}

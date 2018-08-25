//
//  ToastOverlays.swift
//  Pods-YangWidgets_Example
//
//  Created by yanghuang on 2018/1/19.
//

import Foundation
import UIKit

open class ToastOverlays: NSObject {
    static let progressViewTag = 100000111
    static let containerViewTag = 100000999
    static let cornerRadius = CGFloat(10)
    static let padding = CGFloat(10)
    
    static let backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    static let textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    static let font = UIFont.systemFont(ofSize: 14)
    
    // Annoying notifications on top of status bar
    static let bannerDissapearAnimationDuration = 0.5
    static var bannerWindow : UIWindow?
    
    // MARK: show in window
    
    @discardableResult
    open class func showLoadingInWindow() -> UIView {
        let blocker = addMainWindowBlocker()
        showCenteredWaitOverlay(blocker)
        
        return blocker
    }

    @discardableResult
    open class func showLoadingInWindow(withText text: String) -> UIView {
        let blocker = addMainWindowBlocker()
        showLoading(inView: blocker, withText: text)
        return blocker
    }
    
    @discardableResult
    open class func showLoadingInWindow(withImage image: UIImage, andText text: String) -> UIView  {
        let blocker = addMainWindowBlocker()
        showLoading(inView: blocker, withImage: image, andText: text)
        
        return blocker
    }
    
    @discardableResult
    open class func showToastInWindow(_ text: String) -> UIView  {
        let blocker = addMainWindowBlocker()
        showTextOverlay(blocker, text: text)
        
        return blocker
    }
    
    open class func removeAllToastInWindow() {
        let window = UIApplication.shared.delegate!.window!!
        removeAllOverlaysFromView(window)
    }
    
    // MARK: show in view
    @discardableResult
    open class func showLoading(inView view: UIView) -> UIView {
        return showCenteredWaitOverlay(view)
    }
    
    @discardableResult
    open class func showLoading(inView view: UIView, withText text: String) -> UIView  {
        let ai = UIActivityIndicatorView(activityIndicatorStyle: .white)
        ai.startAnimating()
        
        return showGenericOverlay(view, text: text, accessoryView: ai)
    }
    
    @discardableResult
    open class func showLoading(inView view: UIView, withImage image: UIImage, andText text: String) -> UIView  {
        let imageView = UIImageView(image: image)
        
        return showGenericOverlay(view, text: text, accessoryView: imageView)
    }
    
    @discardableResult
    open class func showProgressLoading(inView view: UIView, withText text: String) -> UIView  {
        let pv = UIProgressView(progressViewStyle: .default)
        pv.tag = progressViewTag
        return showGenericOverlay(view, text: text, accessoryView: pv, horizontalLayout: false)
    }
    
    open class func showToast(inView view: UIView, withText text: String) -> UIView  {
        return showTextOverlay(view, text: text)
    }
    
    open class func removeAllToast(inView view: UIView) {
        removeAllOverlaysFromView(view)
    }
    
    //MARK: showCenteredWaitOverlay
    @discardableResult
    open class func showCenteredWaitOverlay(_ parentView: UIView) -> UIView {
        let ai = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        
        let containerViewRect = CGRect(
            x: 0,
            y: 0,
            width: ai.frame.size.width * 2,
            height: ai.frame.size.height * 2
        )
        
        let containerView = UIView(frame: containerViewRect)
        
        containerView.tag = containerViewTag
        containerView.layer.cornerRadius = cornerRadius
        containerView.backgroundColor = backgroundColor
        containerView.center = CGPoint(
            x: parentView.bounds.size.width/2,
            y: parentView.bounds.size.height/2
        )
        
        ai.center = CGPoint(
            x: containerView.bounds.size.width/2,
            y: containerView.bounds.size.height/2
        )
        
        containerView.addSubview(ai)
        
        parentView.addSubview(containerView)
        
        Utils.centerViewInSuperview(containerView)
        
        return containerView
    }
    
    //MARK: showGenericOverlay
    @discardableResult
    open class func showGenericOverlay(_ parentView: UIView, text: String, accessoryView: UIView, horizontalLayout: Bool = true) -> UIView {
        let label = labelForText(text)
        var actualSize = CGSize.zero
        
        if horizontalLayout {
            actualSize = CGSize(width: accessoryView.frame.size.width + label.frame.size.width + padding * 3,
                height: max(label.frame.size.height, accessoryView.frame.size.height) + padding * 2)
            
            label.frame = label.frame.offsetBy(dx: accessoryView.frame.size.width + padding * 2, dy: padding)
            
            accessoryView.frame = accessoryView.frame.offsetBy(dx: padding, dy: (actualSize.height - accessoryView.frame.size.height)/2)
        } else {
            actualSize = CGSize(width: max(accessoryView.frame.size.width, label.frame.size.width) + padding * 2,
                height: label.frame.size.height + accessoryView.frame.size.height + padding * 3)
            
            label.frame = label.frame.offsetBy(dx: padding, dy: accessoryView.frame.size.height + padding * 2)
            
            accessoryView.frame = accessoryView.frame.offsetBy(dx: (actualSize.width - accessoryView.frame.size.width)/2, dy: padding)
        }
        
        // Container view
        let containerViewRect = CGRect(origin: .zero, size: actualSize)
        let containerView = UIView(frame: containerViewRect)
     
        containerView.tag = containerViewTag
        containerView.layer.cornerRadius = cornerRadius
        containerView.backgroundColor = backgroundColor
        containerView.center = CGPoint(
            x: parentView.bounds.size.width/2,
            y: parentView.bounds.size.height/2
        )
        
        containerView.addSubview(accessoryView)
        containerView.addSubview(label)
        
        parentView.addSubview(containerView)
        
        Utils.centerViewInSuperview(containerView)

        return containerView
    }
    
    @discardableResult
    open class func showTextOverlay(_ parentView: UIView, text: String) -> UIView  {
        let label = labelForText(text)
        label.frame = label.frame.offsetBy(dx: padding, dy: padding)
        
        let actualSize = CGSize(width: label.frame.size.width + padding * 2,
            height: label.frame.size.height + padding * 2)
        
        // Container view
        let containerViewRect = CGRect(origin: .zero, size: actualSize)
        let containerView = UIView(frame: containerViewRect)
        
        containerView.tag = containerViewTag
        containerView.layer.cornerRadius = cornerRadius
        containerView.backgroundColor = backgroundColor
        containerView.center = CGPoint(
            x: parentView.bounds.size.width/2,
            y: parentView.bounds.size.height/2
        )

        containerView.addSubview(label)
        
        parentView.addSubview(containerView)
        
        Utils.centerViewInSuperview(containerView)

        return containerView
    }
    
    open class func removeAllOverlaysFromView(_ parentView: UIView) {
        parentView.subviews
            .filter { $0.tag == containerViewTag }
            .forEach { $0.removeFromSuperview() }
    }
    
    open class func updateOverlayText(_ parentView: UIView, text: String) {
        if let overlay = parentView.viewWithTag(containerViewTag) {
            overlay.subviews.compactMap { $0 as? UILabel }.first?.text = text
        }
    }
    
    open class func updateLoadingProgress(_ parentView: UIView, progress: Float) {
        if let overlay = parentView.viewWithTag(containerViewTag) {
            overlay.subviews.compactMap { $0 as? UIProgressView }.first?.progress = progress
        }
    }
    
    // MARK: - create label for text
    fileprivate class func labelForText(_ text: String) -> UILabel {
        let textSize = text.size(withAttributes: [NSAttributedStringKey.font: font])
        
        let labelRect = CGRect(origin: .zero, size: textSize)

        let label = UILabel(frame: labelRect)
        label.font = font
        label.textColor = textColor
        label.text = text
        label.numberOfLines = 0
        
        return label
    }
    
    //MARK: - create constraints in window
    fileprivate class func addMainWindowBlocker() -> UIView {
        let window = UIApplication.shared.delegate!.window!!
        
        let blocker = UIView(frame: window.bounds)
        blocker.backgroundColor = backgroundColor
        blocker.tag = containerViewTag
        
        blocker.translatesAutoresizingMaskIntoConstraints = false

        window.addSubview(blocker)
        
        let viewsDictionary = ["blocker": blocker]
        
        // Add constraints to handle orientation change
        let constraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[blocker]-0-|",
            options: [],
            metrics: nil,
            views: viewsDictionary)
        
        let constraintsH = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[blocker]-0-|",
            options: [],
            metrics: nil,
            views: viewsDictionary)
        
        window.addConstraints(constraintsV + constraintsH)
        
        return blocker
    }
    
    //MARK: - create constraints
    open class Utils {

        open static func centerViewInSuperview(_ view: UIView) {
            assert(view.superview != nil, "`view` should have a superview")
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            let constraintH = NSLayoutConstraint(item: view,
                                                 attribute: NSLayoutAttribute.centerX,
                                                 relatedBy: NSLayoutRelation.equal,
                                                 toItem: view.superview,
                                                 attribute: NSLayoutAttribute.centerX,
                                                 multiplier: 1,
                                                 constant: 0)
            let constraintV = NSLayoutConstraint(item: view,
                                                 attribute: NSLayoutAttribute.centerY,
                                                 relatedBy: NSLayoutRelation.equal,
                                                 toItem: view.superview,
                                                 attribute: NSLayoutAttribute.centerY,
                                                 multiplier: 1,
                                                 constant: 0)
            let constraintWidth = NSLayoutConstraint(item: view,
                                                     attribute: NSLayoutAttribute.width,
                                                     relatedBy: NSLayoutRelation.equal,
                                                     toItem: nil,
                                                     attribute: NSLayoutAttribute.notAnAttribute,
                                                     multiplier: 1,
                                                     constant: view.frame.size.width)
            let constraintHeight = NSLayoutConstraint(item: view,
                                                      attribute: NSLayoutAttribute.height,
                                                      relatedBy: NSLayoutRelation.equal,
                                                      toItem: nil,
                                                      attribute: NSLayoutAttribute.notAnAttribute,
                                                      multiplier: 1,
                                                      constant: view.frame.size.height)
            view.superview!.addConstraints([constraintV, constraintH, constraintWidth, constraintHeight])
        }
    }
    
}

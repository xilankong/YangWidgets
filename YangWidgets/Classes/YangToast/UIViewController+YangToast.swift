//
//  UIViewController+YangToast.swift
//  Pods-YangWidgets_Example
//
//  Created by yanghuang on 2018/1/25.
//

import Foundation

// For convenience methods
@objc public extension UIViewController {
    
    /**
     Shows wait overlay with activity indicator, centered in the view controller's main view
     
     Do not use this method for **UITableViewController** or **UICollectionViewController**
     
     - returns: Created overlay
     */
    @discardableResult
    func showWaitOverlay() -> UIView {
        return SwiftOverlays.showCenteredWaitOverlay(self.view)
    }
    
    /**
     Shows wait overlay with activity indicator *and text*, centered in the view controller's main view
     
     Do not use this method for **UITableViewController** or **UICollectionViewController**
     
     - parameter text: Text to be shown on overlay
     
     - returns: Created overlay
     */
    @discardableResult
    func showWaitOverlayWithText(_ text: String) -> UIView  {
        return SwiftOverlays.showCenteredWaitOverlayWithText(self.view, text: text)
    }
    
    /**
     Shows *text-only* overlay, centered in the view controller's main view
     
     Do not use this method for **UITableViewController** or **UICollectionViewController**
     
     - parameter text: Text to be shown on overlay
     
     - returns: Created overlay
     */
    @discardableResult
    func showTextOverlay(_ text: String) -> UIView  {
        return SwiftOverlays.showTextOverlay(self.view, text: text)
    }
    
    /**
     Shows overlay with text and progress bar, centered in the view controller's main view
     
     Do not use this method for **UITableViewController** or **UICollectionViewController**
     
     - parameter text: Text to be shown on overlay
     
     - returns: Created overlay
     */
    @discardableResult
    func showProgressOverlay(_ text: String) -> UIView  {
        return SwiftOverlays.showProgressOverlay(self.view, text: text)
    }
    
    /**
     Shows overlay *with image and text*, centered in the view controller's main view
     
     Do not use this method for **UITableViewController** or **UICollectionViewController**
     
     - parameter image: Image to be added to overlay
     - parameter text: Text to be shown on overlay
     
     - returns: Created overlay
     */
    @discardableResult
    func showImageAndTextOverlay(_ image: UIImage, text: String) -> UIView  {
        return SwiftOverlays.showImageAndTextOverlay(self.view, image: image, text: text)
    }
    
    /**
     Shows notification on top of the status bar, similar to native local or remote notifications
     
     - parameter notificationView: View that will be shown as notification
     - parameter duration: Amount of time until notification disappears
     - parameter animated: Should appearing be animated
     */
    class func showOnTopOfStatusBar(_ notificationView: UIView, duration: TimeInterval, animated: Bool = true) {
        SwiftOverlays.showOnTopOfStatusBar(notificationView, duration: duration, animated: animated)
    }
    
    /**
     Removes all overlays from view controller's main view
     */
    func removeAllOverlays() {
        SwiftOverlays.removeAllOverlaysFromView(self.view)
    }
    
    /**
     Updates text on the current overlay.
     Does nothing if no overlay is present.
     
     - parameter text: Text to set
     */
    func updateOverlayText(_ text: String) {
        SwiftOverlays.updateOverlayText(self.view, text: text)
    }
    
    /**
     Updates progress on the current overlay.
     Does nothing if no overlay is present.
     
     - parameter progress: Progress to set 0.0 .. 1.0
     */
    func updateOverlayProgress(_ progress: Float) {
        SwiftOverlays.updateOverlayProgress(self.view, progress: progress)
    }
}

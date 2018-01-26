//
//  YangProgressBar.swift
//  Pods-YangWidgets_Example
//
//  Created by yanghuang on 2018/1/25.
//

import UIKit

public extension UIViewController {
    
    public func showImageDialog() {
       
    }
    
    public func showDialog(title: String, message: String, buttonText: String, animated: Bool = true, completion: @escaping (() -> Void)) {
        let title = title
        let message = message
        let cancelButtonTitle = buttonText
        
        let alertController = DOAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = DOAlertAction(title: cancelButtonTitle, style: .cancel) { action in
            completion()
        }
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    public func showDialog(title: String, message: String, okButtonText: String, cancleButtonText: String, animated: Bool = true, okCompletion: @escaping (() -> Void), cancleCompletion: @escaping (() -> Void)) {

        let alertController = DOAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButtonAction = DOAlertAction(title: okButtonText, style: .default) { action in
            okCompletion()
        }
        let cancelAction = DOAlertAction(title: cancleButtonText, style: .cancel) { action in
            cancleCompletion()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okButtonAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

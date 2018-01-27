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
    
    //MARK: - sure dialog
    public func showDialog(title: String, message: String, buttonText: String, animated: Bool = true, completion: @escaping (() -> Void)) {
        let title = title
        let message = message
        let cancelButtonTitle = buttonText
        
        let alertController = DOAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = DOAlertAction(title: cancelButtonTitle, style: .cancel) { action in
            completion()
        }
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: animated, completion: nil)
    }
    
    //MARK: - ok/cancle dialog
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
        
        present(alertController, animated: animated, completion: nil)
    }
    
    //MARK: - textEntryDialog
    public func showTextEntryDialog(title: String, message: String, okButtonText: String, cancleButtonText: String, animated: Bool = true, okCompletion: @escaping ((String?) -> Void), cancleCompletion: @escaping (() -> Void)) {
        var textFieldInDialog: UITextField?
        let alertController = DOAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textFieldInDialog = textField
        }
        
        let okButtonAction = DOAlertAction(title: okButtonText, style: .default) { action in
            okCompletion(textFieldInDialog?.text)
        }
        let cancelAction = DOAlertAction(title: cancleButtonText, style: .cancel) { action in
            cancleCompletion()
        }
        okButtonAction.enabled = false
        alertController.addAction(cancelAction)
        alertController.addAction(okButtonAction)
        
        present(alertController, animated: animated, completion: nil)
    }
    
    
    //MARK: - ok/cancle ActionSheet
    public func showActionSheet(title: String? = nil, message: String? = nil, okButtonText: String, cancleButtonText: String, animated: Bool = true, okCompletion: @escaping (() -> Void), cancleCompletion: @escaping (() -> Void)) {
        
        let alertController = DOAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let okButtonAction = DOAlertAction(title: okButtonText, style: .default) { action in
            okCompletion()
        }
        let cancelAction = DOAlertAction(title: cancleButtonText, style: .cancel) { action in
            cancleCompletion()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okButtonAction)
        
        present(alertController, animated: animated, completion: nil)
    }
    
    //MARK: - 自定义无取消按钮
    public func showActionSheet(title: String? = nil, message: String? = nil, customTextArray: [String], animated: Bool = true, completion: @escaping ((Int) -> Void)) {
        let alertController = DOAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for (index, buttonText) in customTextArray.enumerated() {
            let okButtonAction = DOAlertAction(title: buttonText, style: .default) { action in
                completion(index)
            }
            alertController.addAction(okButtonAction)
        }

        present(alertController, animated: animated, completion: nil)
    }
    
    //MARK: - 自定义带取消按钮
    public func showActionSheet(title: String? = nil, message: String? = nil, customTextArray: [String], cancleButtonText: String, animated: Bool = true, completion: @escaping ((Int) -> Void), cancleCompletion: @escaping (() -> Void)) {
        let alertController = DOAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for (index, buttonText) in customTextArray.enumerated() {
            let okButtonAction = DOAlertAction(title: buttonText, style: .default) { action in
                completion(index)
            }
            alertController.addAction(okButtonAction)
        }
        
        let cancelAction = DOAlertAction(title: cancleButtonText, style: .cancel) { action in
            cancleCompletion()
        }
        alertController.addAction(cancelAction)
        
        present(alertController, animated: animated, completion: nil)
    }
}

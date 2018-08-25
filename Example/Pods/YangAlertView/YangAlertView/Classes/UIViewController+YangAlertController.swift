//
//  UIViewController.swift
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
        
        let alertController = YangAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = YangAlertAction(title: cancelButtonTitle, style: .cancel) { action in
            completion()
        }
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: animated, completion: nil)
    }
    
    //MARK: - ok/cancle dialog
    public func showDialog(title: String, message: String, okButtonText: String, cancleButtonText: String, animated: Bool = true, okCompletion: @escaping (() -> Void), cancleCompletion: @escaping (() -> Void)) {

        let alertController = YangAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButtonAction = YangAlertAction(title: okButtonText, style: .default) { action in
            okCompletion()
        }
        let cancelAction = YangAlertAction(title: cancleButtonText, style: .cancel) { action in
            cancleCompletion()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okButtonAction)
        
        present(alertController, animated: animated, completion: nil)
    }
    
    //MARK: - textEntryDialog
    public func showTextEntryDialog(title: String, message: String, pattern: String = "", minLength: Int = 1, okButtonText: String, cancleButtonText: String, animated: Bool = true, okCompletion: @escaping ((String?) -> Void), cancleCompletion: @escaping (() -> Void)) {
        var textFieldInDialog: YangTextField?
        let alertController = YangAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField?.textFieldPattern = pattern
            textField?.textFieldMinLength = minLength
            textFieldInDialog = textField
        }
        
        let okButtonAction = YangAlertAction(title: okButtonText, style: .default) { action in
            okCompletion(textFieldInDialog?.text)
        }
        let cancelAction = YangAlertAction(title: cancleButtonText, style: .cancel) { action in
            cancleCompletion()
        }
        okButtonAction.enabled = false
        alertController.addAction(cancelAction)
        alertController.addAction(okButtonAction)
        
        present(alertController, animated: animated, completion: nil)
    }
    
    //MARK: - PasswordDialog
    public func showPasswordDialog(title: String, message: String, pattern: String = "", minLength: Int = 1, okButtonText: String, cancleButtonText: String, animated: Bool = true, okCompletion: @escaping ((String?) -> Void), cancleCompletion: @escaping (() -> Void)) {
        var textFieldInDialog: YangTextField?
        let alertController = YangAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField?.isSecureTextEntry = true
            textField?.textFieldPattern = pattern
            textField?.textFieldMinLength = minLength
            textFieldInDialog = textField
        }
        
        let okButtonAction = YangAlertAction(title: okButtonText, style: .default) { action in
            okCompletion(textFieldInDialog?.text)
        }
        let cancelAction = YangAlertAction(title: cancleButtonText, style: .cancel) { action in
            cancleCompletion()
        }
        okButtonAction.enabled = false
        alertController.addAction(cancelAction)
        alertController.addAction(okButtonAction)
        
        present(alertController, animated: animated, completion: nil)
    }
    
    //MARK: - 自定义双按钮空白dialog
    public func showCustomAlertDialog(title: String, message: String, okButtonText: String, cancleButtonText: String, animated: Bool = true, okCompletion: @escaping (() -> Void), cancleCompletion: @escaping (() -> Void)) {

        let alertController = YangAlertController(title: title, message: message, preferredStyle: .alert)
        let okButtonAction = YangAlertAction(title: okButtonText, style: .default) { action in
            okCompletion()
        }
        let cancelAction = YangAlertAction(title: cancleButtonText, style: .cancel) { action in
            cancleCompletion()
        }
        okButtonAction.enabled = false
        alertController.addAction(cancelAction)
        alertController.addAction(okButtonAction)
        
        present(alertController, animated: animated, completion: nil)
    }
    
    //MARK: - 自定义空白dialog
    public func showCustomAlertDialog(title: String, message: String, animated: Bool = true) -> YangAlertController {
        return YangAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    //MARK: - ok/cancle ActionSheet
    public func showActionSheet(title: String? = nil, message: String? = nil, okButtonText: String, cancleButtonText: String, animated: Bool = true, okCompletion: @escaping (() -> Void), cancleCompletion: @escaping (() -> Void)) {
        
        let alertController = YangAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let okButtonAction = YangAlertAction(title: okButtonText, style: .default) { action in
            okCompletion()
        }
        let cancelAction = YangAlertAction(title: cancleButtonText, style: .cancel) { action in
            cancleCompletion()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okButtonAction)
        
        present(alertController, animated: animated, completion: nil)
    }
    
    //MARK: - 自定义无取消按钮
    public func showActionSheet(title: String? = nil, message: String? = nil, customTextArray: [String], animated: Bool = true, completion: @escaping ((Int) -> Void)) {
        let alertController = YangAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for (index, buttonText) in customTextArray.enumerated() {
            let okButtonAction = YangAlertAction(title: buttonText, style: .default) { action in
                completion(index)
            }
            alertController.addAction(okButtonAction)
        }

        present(alertController, animated: animated, completion: nil)
    }
    
    //MARK: - 自定义带取消按钮
    public func showActionSheet(title: String? = nil, message: String? = nil, customTextArray: [String], cancleButtonText: String, animated: Bool = true, completion: @escaping ((Int) -> Void), cancleCompletion: @escaping (() -> Void)) {
        let alertController = YangAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for (index, buttonText) in customTextArray.enumerated() {
            let okButtonAction = YangAlertAction(title: buttonText, style: .default) { action in
                completion(index)
            }
            alertController.addAction(okButtonAction)
        }
        
        let cancelAction = YangAlertAction(title: cancleButtonText, style: .cancel) { action in
            cancleCompletion()
        }
        alertController.addAction(cancelAction)
        
        present(alertController, animated: animated, completion: nil)
    }
}

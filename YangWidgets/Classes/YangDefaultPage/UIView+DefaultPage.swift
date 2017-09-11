//
//  UIView+DefaultPage.swift
//  FLAnimatedImage
//
//  Created by yanghuang on 2017/9/11.
//

import UIKit
import SnapKit

let scale: CGFloat = 2.0 / 3.0

extension UIView {
    open func showDefaultPage(withImage image: UIImage, text: String, buttonText: String?, complete: ((_ view: UIView)->Void)?) {
        
        self.showDefaultPage(withImage: image, text: text, buttonText: buttonText, offset: 0, complete: complete)
    }
    
    open func showDefaultPage(withImage image: UIImage, text: String, buttonText: String?, offset: CGFloat, complete: ((_ view: UIView)->Void)?) {
        
        let defaultView = YangDefaultPageView(withFrame:CGRect(x: 0, y: offset, width: ViewW(self), height: ViewH(self)), image: image, text: text, buttonText: buttonText, complete: complete)
        defaultView.backgroundColor = bgColor
        self.addSubview(defaultView)
    }
    
    //MARK: - 无网络缺省页
    open func showNoNetworkPage(withOffset offset: CGFloat, complete: ((_ view: UIView)->Void)?) {
        self.showDefaultPage(withImage: UIImage(named: "nonetwork", in: defaultPageBundle, compatibleWith: nil)!, text: nonetwork, buttonText: "刷新", offset: offset, complete: complete)
    }
    
    //MARK: - 无数据缺省页
    open func showNoDataPage() {
        self.showNoDataPage(withOffset: 0)
    }
    
    //MARK: - 无数据缺省页
    open func showNoDataPage(withOffset offset: CGFloat) {
        self.showDefaultPage(withImage: UIImage(named: "nodata", in: defaultPageBundle, compatibleWith: nil)!, text: nodata, buttonText: nil, offset: offset, complete: nil)
    }
    
    //MARK: - 操作失败缺省页
    open func showFailedPage() {
        self.showFailedPage(withOffset: 0, complete: nil)
    }
    
    //MARK: - 操作失败缺省页
    open func showFailedPage(withOffset offset: CGFloat, complete: ((_ view: UIView)->Void)?) {
        self.showDefaultPage(withImage: UIImage(named: "failed", in: defaultPageBundle, compatibleWith: nil)!, text: failed, buttonText: "重试", offset: offset, complete: complete)
    }
    
    //MARK: - 丢失缺省页
    open func showlostedPage() {
        self.showlostedPage(withOffset: 0, complete: nil)
    }
    
    //MARK: - 丢失缺省页
    open func showlostedPage(withOffset offset: CGFloat, complete: ((_ view: UIView)->Void)?) {
        self.showDefaultPage(withImage: UIImage(named: "lost", in: defaultPageBundle, compatibleWith: nil)!, text: losted, buttonText: "刷新", offset: offset, complete: complete)
    }
}

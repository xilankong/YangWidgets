//
//  DragButton.swift
//  自动拖拽吸附悬浮块
//
//  Created by yanghuang on 16/12/5.
//  Copyright © 2016年 yanghuang. All rights reserved.
//

import UIKit

public class DragButton: UIView {
    
    let DOUBLE_CLICK_TIME = 0.3
    let ANIMATION_DURATION_TIME = 0.2
    
    public typealias BtnClosure = (_ btn : DragButton) ->()
    
    //是否拖拽中
    public var isDragging: Bool = false
    //是否可拖拽
    public var draggable: Bool = true
    //是否自动吸附
    public var autoDocking: Bool = false
    //单击回调
    public var clickClosure: BtnClosure?
    //双击回调
    public var doubleClickClosure: BtnClosure?
    //拖拽回调
    public var draggingClosure: BtnClosure?
    //拖拽结束回调
    public var dragDoneClosure: BtnClosure?
    //自动吸附结束回调
    public var autoDockEndClosure: BtnClosure?
    //图片
    public var image: UIImage? {
        didSet {
            self.imageView.image = image
        }
    }
    
    //拖拽开始center
    fileprivate var beginLocation: CGPoint?
    fileprivate let imageView: UIImageView = UIImageView()
    
    //MARK: - 初始化
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    //MARK: - 初始化
    private func initUI() {
        
        self.addSubview(imageView)
        imageView.isUserInteractionEnabled = false
        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        draggable = true
        autoDocking = true
    }

    //MARK: 双击响应
    @objc private func doubleClickAction() {
        doubleClickClosure?(self)
    }
    
    //MARK: 单击响应
    
    @objc private func singleClickAction() {
        clickClosure?(self)
    }

    //MARK: touch开始
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDragging = false
        super.touchesBegan(touches, with: event)
        let touch = touches.first
        beginLocation = touch?.location(in: self)
    }
    
    //MARK: - 拖拽过程
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if draggable {
            isDragging = true
            let touch = touches.first
            let currentLocation : CGPoint = (touch?.location(in: self))!
            let offsetX : CGFloat = currentLocation.x - (beginLocation?.x)!
            let offsetY : CGFloat = currentLocation.y - (beginLocation?.y)!
            self.center = CGPoint(x: self.center.x+offsetX, y: self.center.y+offsetY)
            
            let superviewFrame : CGRect = (self.superview?.frame)!
            let frame = self.frame
            let leftLimitX = frame.size.width / 2.0
            let rightLimitX = superviewFrame.size.width - leftLimitX
            let topLimitY = frame.size.height / 2.0
            let bottomLimitY = superviewFrame.size.height - topLimitY
            
            if self.center.x > rightLimitX {
                self.center = CGPoint(x: rightLimitX, y: self.center.y)
            } else if self.center.x <= leftLimitX {
                self.center = CGPoint(x: leftLimitX, y: self.center.y)
            }
            
            if self.center.y > bottomLimitY {
                self.center = CGPoint(x: self.center.x, y: bottomLimitY)
            } else if self.center.y <= topLimitY{
                 self.center = CGPoint(x: self.center.x, y: topLimitY)
            }
            //拖拽回调
            draggingClosure?(self)
        }
    }
    
    //MARK: - 拖拽结束
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event);
        //是否之前处于拖拽状态,单击之前不处于拖拽
        if isDragging {
            //拖拽结束回调
            dragDoneClosure?(self)
            
            if autoDocking {
                let superviewFrame : CGRect = (self.superview?.frame)!
                let frame = self.frame
                let middleX = superviewFrame.size.width / 2.0
                let changeX = self.center.x >= middleX ? (superviewFrame.size.width - frame.size.width / 2) : (frame.size.width / 2)
                UIView.animate(withDuration: ANIMATION_DURATION_TIME, animations: {
                    self.center = CGPoint(x: changeX, y: self.center.y)
                }, completion: { _ in
                    self.autoDockEndClosure?(self)
                })
            }
        } else {
            let touch = touches.first
            if touch?.tapCount == 1 {
                //单击回调
                self.perform(#selector(singleClickAction), with: nil, afterDelay: DOUBLE_CLICK_TIME )
            } else if touch?.tapCount == 2 {
                //双击回调，如果在时间范围内会撤销单击事件
                NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(singleClickAction), object: nil)
                self.doubleClickAction()
            }
        }
       
        isDragging = false
    }
    
    //MARK: - 拖拽取消
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDragging = false
        super.touchesCancelled(touches, with: event)
    }
    
    //MARK: - 添加到keyWindow
    public func addButtonToKeyWindow() {
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    //MARK: - 移除
    public func removeFromKeyWindow() {
        for view : UIView in (UIApplication.shared.keyWindow?.subviews)! {
            if view.isKind(of: DragButton.classForCoder()) {
                view.removeFromSuperview()
            }
        }
    }
    
}

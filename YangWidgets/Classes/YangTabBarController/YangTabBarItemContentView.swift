//
//  YangAnimateTipsContentView.swift
//  Pods-YangWidgets_Example
//
//  Created by yanghuang on 2018/1/24.
//

import UIKit

public class YangBouncesContentView: ESTabBarItemContentView {
    
    public var duration = 0.3
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func selectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    override public func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = kCAAnimationCubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
}


public class YangBackgroundContentView: ESTabBarItemContentView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        textColor = UIColor.init(white: 165.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        iconColor = UIColor.init(white: 165.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        backdropColor = UIColor.init(red: 37/255.0, green: 39/255.0, blue: 42/255.0, alpha: 1.0)
        highlightBackdropColor = UIColor.init(red: 22/255.0, green: 24/255.0, blue: 25/255.0, alpha: 1.0)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


public class YangIrregularityBasicContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView.backgroundColor = self.highlightIconColor
        self.imageView.layer.cornerRadius = 35
        self.imageView.layer.masksToBounds = true
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        self.superview?.bringSubview(toFront: self)
        self.insets = UIEdgeInsetsMake(-32, 0, 0, 0)
        self.iconColor = UIColor.white
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func updateLayout() {
        super.updateLayout()
        self.imageView.sizeToFit()
        self.imageView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
    }
    
    
    public override func highlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("small", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = self.imageView.transform.scaledBy(x: 0.8, y: 0.8)
        self.imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }
    
    public override func dehighlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("big", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }
    
}

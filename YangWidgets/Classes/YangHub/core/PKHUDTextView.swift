//
//  PKHUDTextView.swift
//  PKHUD
//
//  Created by Philip Kluz on 6/12/15.
//  Copyright (c) 2016 NSExceptional. All rights reserved.
//  Licensed under the MIT license.
//

import UIKit

/// PKHUDTextView provides a wide, three line text view, which you can use to display information.
open class PKHUDTextView: PKHUDWideBaseView {

    let padding: CGFloat = 10
    let height: CGFloat = 40.0
    let maxWidth: CGFloat = UIScreen.main.bounds.width - 60.0
    
    public init(text: String?) {
        super.init()
        commonInit(text)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit("")
    }

    func commonInit(_ text: String?) {
        titleLabel.text = text
        titleLabel.sizeToFit()
        var width = titleLabel.frame.size.width + padding * 2
        width = width > maxWidth ? maxWidth : width
        self.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height))
        addSubview(titleLabel)
        titleLabel.frame = CGRect(origin: CGPoint(x: padding, y: 0), size: CGSize(width: width - padding * 2, height: height))
    }

    open let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = UIColor.white
        return label
    }()
}

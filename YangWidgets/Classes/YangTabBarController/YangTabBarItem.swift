//
//  YangBouncesTabBarItem.swift
//  Pods-YangWidgets_Example
//
//  Created by yanghuang on 2018/1/24.
//

import UIKit

public class YangTabBarItem: ESTabBarItem {
    
    public convenience init(title: String?, image: UIImage?, selectedImage: UIImage?) {
        self.init(ESTabBarItemContentView(), title: title, image: image, selectedImage: selectedImage, tag: 0)
    }
    
}


public class YangBouncesTabBarItem: ESTabBarItem {

    public convenience init(title: String?, image: UIImage?, selectedImage: UIImage?) {
        self.init(YangBouncesContentView(), title: title, image: image, selectedImage: selectedImage)
    }
    
}

public class YangBackgroundTabBarItem: ESTabBarItem {
    
    public convenience init(title: String?, image: UIImage?, selectedImage: UIImage?) {
        self.init(YangBackgroundContentView(), title: title, image: image, selectedImage: selectedImage)
    }
    
}
public class YangIrregularityBasicTabBarItem: ESTabBarItem {
    
    public convenience init(title: String?, image: UIImage?, selectedImage: UIImage?) {
        self.init(YangIrregularityBasicContentView(), title: title, image: image, selectedImage: selectedImage)
    }
    
}

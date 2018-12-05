//
//  CSSegmentItem.swift
//  CSSegmentedControl
//
//  Created by huangchusheng on 2018/12/4.
//  Copyright © 2018 Aaron. All rights reserved.
//

import UIKit

public class CSSegmentItem: NSObject {
    
    public enum Style {
        case imageOnLeft
        case imageOnRight
    }
    
    public var title: String
    
    public var image: UIImage?
    
    public var spacing: CGFloat = 0  // 标题、图片间隔
    
    public var style: Style = .imageOnLeft // 样式 默认图片在左
    
    public init(title: String, image: UIImage? = nil) {
        self.title = title
        self.image = image
        super.init()
    }
    
}

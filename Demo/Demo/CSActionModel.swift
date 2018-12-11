//
//  CSActionModel.swift
//  Demo
//
//  Created by huangchusheng on 2018/12/6.
//  Copyright © 2018 huangchusheng. All rights reserved.
//

import UIKit

enum CSAction: String {
    case leftInset
    case rightInset
    case itemWidth
    case itemSpacing
    case selectedItemScale
    case indicatorWidth
    case indicatorHeight
    case indicatorAnimationType
    case selectedItemScrollPosition
    case separatorStyle
    case featherStyle
    case backgroundImage
    case indicatorColor
    case textFont
    case textColor
    case selectedTextColor
}

class CSActionModel: NSObject {
    
    let action: CSAction
    
    var selectedIndex: Int = 0
    
    init(action: CSAction) {
        self.action = action
    }
    
    
}

//
//  CSActionModel.swift
//  Demo
//
//  Created by huangchusheng on 2018/12/6.
//  Copyright © 2018 huangchusheng. All rights reserved.
//

import UIKit

enum CSAction: String {
    case separatorStyle
    case featherStyle
    case indicatorAnimationType
    case selectedItemScrollPosition
    case backgroundImage
    case indicatorWidth
    case indicatorHeight
    case indicatorColor
    case textFont
    case textColor
    case selectedTextColor
    case itemWidth
    case itemSpacing
    case leftInset
    case rightInset
}

class CSActionModel: NSObject {
    
    let action: CSAction
    
    var selectedIndex: Int = 0
    
    init(action: CSAction) {
        self.action = action
    }
    
    
}

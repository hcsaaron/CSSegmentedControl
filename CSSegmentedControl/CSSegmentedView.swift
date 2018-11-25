//
//  CSSegmentedView.swift
//  CSSegmentedControl
//
//  Created by 黄楚升 on 2018/11/21.
//  Copyright © 2018年 Aaron. All rights reserved.
//

import Foundation

class CSSegmentedView: UIView {
    var title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

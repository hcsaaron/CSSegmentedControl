//
//  CSSegmentedControl.swift
//  CSSegmentedControl
//
//  Created by 黄楚升 on 2018/11/21.
//  Copyright © 2018年 Aaron. All rights reserved.
//

import Foundation

public struct CSSegmentedConfigurator {
    
}

public class CSSegmentedControl: UIControl {
    
    enum SeparatorStyle {
        case none
        case `default`
    }
    
//    public static let automaticDimension: CGFloat = -1  //

    
    var itemWidth: Float = 0    // 为0时平均宽度，非0时按设定的宽度，超出可滑动
    
    var lineWidth: Float = 0    // 为0时宽度为item的宽度，非0时按设定的宽度
    
    var lineTintColor: UIColor = .black // 线的颜色
    
    var textColor: UIColor = .lightGray // 文字默认颜色
    
    var textHighlightColor: UIColor = .black    // 文字高亮颜色
    
    var automaticItemWidth: Bool = false    // 是否根据文字自动调整item宽度，if true：item宽度将根据文字自动调整
    
    var itemContentInsets: UIEdgeInsets = .zero // item内容insets
    
    var shadowImage: UIImage? {
        didSet {
            if shadowImage != nil {
                shadowImageView = UIImageView(frame: .zero)
                shadowImageView?.image = shadowImage
                addSubview(shadowImageView!)
                layoutSubviews()
            } else {
                shadowImageView?.removeFromSuperview()
                shadowImageView = nil
                layoutSubviews()
            }
        }
    }
    
    var backgroundImage: UIImage? {
        didSet {
            if backgroundImage != nil {
                backgroundImageView = UIImageView(frame: .zero)
                backgroundImageView?.image = backgroundImage
                addSubview(shadowImageView!)
                layoutSubviews()
            } else {
                backgroundImageView?.removeFromSuperview()
                backgroundImageView = nil
                layoutSubviews()
            }
        }
    }
    
    private var shadowImageView: UIImageView?
    
    private var backgroundImageView: UIImageView?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.delegate = self
        return scrollView
    }()
    
    lazy var leftFeatherImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ""))
        return imageView
    }()
    
    public var titles: [String] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    init(titles: [String]) {
        self.titles = titles
        super.init(frame: .zero)
        setUp()
    }
    
    private func setUp () {
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        var shadowHeight: CGFloat = 0
        if let shadowImageView = shadowImageView {
            shadowHeight = 0.5
            shadowImageView.frame = CGRect(x: 0, y: frame.height - shadowHeight, width: frame.width, height: shadowHeight)
        }
        if let backgroundImageView = backgroundImageView {
            backgroundImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - shadowHeight)
        }
    }
    
    
    
}

extension CSSegmentedControl: UIScrollViewDelegate {
    
}

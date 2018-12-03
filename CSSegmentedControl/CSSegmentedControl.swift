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

class CSSegment: UIView {
    
}

public class CSSegmentedControl: UIControl {
    
    enum SeparatorStyle {
        case none
        case `default`
    }
    
    // 用于保存各个状态的textAttributes的字典
    private var textAttributesDic: [UInt: [NSAttributedString.Key : Any]] = [:]
    
    var itemWidth: Float = 0    // 为0时平均宽度，非0时按设定的宽度，超出可滑动
    
    var indicatorWidth: Float = 0    // 为0时宽度为item的宽度，非0时按设定的宽度
    
    var indicatorColor: UIColor = .black
    
    var textColor: UIColor = .lightGray // 文字默认颜色
    
    var selectedTextColor: UIColor = .black    // 文字高亮颜色
    
    var textFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    var selectedTextFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    var automaticItemWidth: Bool = false    // 是否根据文字自动调整item宽度，if true：item宽度将根据文字自动调整
    
    var itemContentInsets: UIEdgeInsets = .zero // item内容insets
    
    // 分割线样式
    var separatorStyle: SeparatorStyle = .default {
        didSet {
            switch separatorStyle {
            case .none:
                self.shadowImage = nil
            case .default:
                self.shadowImage = CSSegmentedControlImage(imageName: "line_separator")
            }
        }
    }
    
    // 分割线图片
    private var shadowImage: UIImage? {
        didSet {
            if shadowImage != nil {
                shadowImageView = UIImageView(frame: .zero)
                shadowImageView?.image = shadowImage
                insertSubview(shadowImageView!, at: 0)
                layoutSubviews()
            } else {
                shadowImageView?.removeFromSuperview()
                shadowImageView = nil
                layoutSubviews()
            }
        }
    }
    
    // 背景图片
    var backgroundImage: UIImage? {
        didSet {
            if backgroundImage != nil {
                backgroundImageView = UIImageView(frame: .zero)
                backgroundImageView?.image = backgroundImage
                insertSubview(backgroundImageView!, at: 0)
                layoutSubviews()
            } else {
                backgroundImageView?.removeFromSuperview()
                backgroundImageView = nil
                layoutSubviews()
            }
        }
    }
    
    private var shadowImageView: UIImageView?   // 底部阴影ImageView
    
    private var backgroundImageView: UIImageView?   // 背景ImageView
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    // 左边的羽化ImagevIEW
    lazy var leftFeatherImageView: UIImageView = {
        let imageView = UIImageView(image: CSSegmentedControlImage(imageName: "feather_left"))
        return imageView
    }()
    
    // 右边的羽化ImagevIEW
    lazy var rightFeatherImageView: UIImageView = {
        let imageView = UIImageView(image: CSSegmentedControlImage(imageName: "feather_right"))
        return imageView
    }()
    
    // 显示的标题数组
    public var titles: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
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
        addSubview(collectionView)
    }
    
    open func setTitleTextAttributes(_ attributes: [NSAttributedString.Key : Any]?, for state: UIControl.State) {
        textAttributesDic[state.rawValue] = attributes
    }
    
    open func titleTextAttributes(for state: UIControl.State) -> [NSAttributedString.Key : Any]? {
        return textAttributesDic[state.rawValue]
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
        
        collectionView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - shadowHeight)
    }
}

extension CSSegmentedControl: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "cell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        var label = cell.viewWithTag(100) as? UILabel
        if label == nil {
            cell.contentView.backgroundColor = .white
            label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 44))
            label?.tag = 100
            cell.contentView.addSubview(label!)
        }
        
        let title = titles[indexPath.item]
        label?.text = title
        
        return cell
    }
}
extension CSSegmentedControl: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
}

extension CSSegmentedControl: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 44)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
}

//
//  CSSegmentedControl.swift
//  CSSegmentedControl
//
//  Created by 黄楚升 on 2018/11/21.
//  Copyright © 2018年 Aaron. All rights reserved.
//

import Foundation

private let kAnimatedDuration: TimeInterval = 0.25
private let kFeatherWidth: CGFloat = 30

public class CSSegmentedControl: UIControl {
    
    public enum SeparatorStyle {
        case none       // 无分割线
        case `default`  // 默认分割线
    }
    
    public enum FeatherStyle {
        case none       // 无羽化效果
        case `default`  // 默认羽化效果
    }
    
    private var shadowImageView: UIImageView?   // 底部阴影ImageView
    
    private var backgroundImageView: UIImageView?   // 背景ImageView
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = CGSize(width: 0, height: 44)
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CSSegmentCell.self, forCellWithReuseIdentifier: CSSegmentCell.identifier)
        return collectionView
    }()
    
    // 指示条
    private lazy var indicatorImageView: UIImageView = {
        let indicatorImageView = UIImageView(frame: .zero)
        indicatorImageView.backgroundColor = indicatorColor
        return indicatorImageView
    }()
    
    // 左边的羽化imageView
    lazy var leftFeatherImageView: UIImageView = {
        let imageView = UIImageView(image: CSSegmentedControlImage(imageName: "feather_left"))
        return imageView
    }()
    
    // 右边的羽化imageView
    lazy var rightFeatherImageView: UIImageView = {
        let imageView = UIImageView(image: CSSegmentedControlImage(imageName: "feather_right"))
        return imageView
    }()
    
    // 分割线图片
    private var shadowImage: UIImage? {
        didSet {
            if shadowImage != nil {
                if shadowImageView == nil {
                    shadowImageView = UIImageView(frame: .zero)
                    insertSubview(shadowImageView!, at: 0)
                }
                shadowImageView?.image = shadowImage
                layoutSubviews()
            } else {
                if shadowImageView != nil {
                    shadowImageView?.removeFromSuperview()
                    shadowImageView = nil
                    layoutSubviews()
                }
            }
        }
    }
    
    // MARK: ---------- Public ----------
    
    // 指示条宽度，为0时宽度为item的宽度，非0时按设定的宽度
    public var indicatorWidth: CGFloat = 0 {
        didSet {
            layoutIndicator()
        }
    }
    
    // 指示条高度
    public var indicatorHeight: CGFloat = 2 {
        didSet {
            layoutIndicator()
        }
    }
    
    // 指示条颜色
    public var indicatorColor: UIColor = .black {
        didSet {
            indicatorImageView.backgroundColor = indicatorColor
        }
    }
    
    // 字体颜色
    public var textFont: UIFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // 文字颜色
    public var textColor: UIColor = .gray {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // 选中的文字颜色
    public var selectedTextColor: UIColor = .black {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // 设置item宽度；为0时根据文字、图片自动调整item宽度
    public var itemWidth: CGFloat = 0 {
        didSet {
            if itemWidth == 0 {
                flowLayout.estimatedItemSize = CGSize(width: 0, height: 44)
            } else {
                flowLayout.estimatedItemSize = .zero
            }
            collectionView.reloadData()
        }
    }
    
    // item之间的间距
    public var itemSpacing: CGFloat = 10 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // 左边距
    public var leftInset: CGFloat = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // 右边距
    public var rightInset: CGFloat = 0 {
        didSet {
            collectionView.reloadData()
        }
    }

    // 分割线样式
    public var separatorStyle: SeparatorStyle = .none {
        didSet {
            switch separatorStyle {
            case .none:
                self.shadowImage = nil
            case .default:
                self.shadowImage = CSSegmentedControlImage(imageName: "line_separator")
            }
        }
    }
    
    // 羽化样式
    public var featherStyle: FeatherStyle = .none {
        didSet {
            refreshFeather()
        }
    }
    
    // 背景图片
    public var backgroundImage: UIImage? {
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
    
    // 选中的下标
    public var selectedSegmentIndex: Int = 0 {
        didSet {
            layoutIndicator()
        }
    }
    
    // CSSegmentItem数组
    public var items: [CSSegmentItem] = [] {
        didSet {
            collectionView.reloadData()
            if items.count > 0 {
                self.selectedSegmentIndex = 0
            }
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
    
    public init(items: [CSSegmentItem]) {
        self.items = items
        super.init(frame: .zero)
        setUp()
    }
    
    public init(titles: [String]) {
        super.init(frame: .zero)
        setTitles(titles: titles)
        setUp()
    }
    
    public func setTitles(titles: [String]) {
        var items: [CSSegmentItem] = []
        for title in titles {
            let item = CSSegmentItem(title: title)
            items.append(item)
        }
        self.items = items
    }
    
    private func setUp () {
        separatorStyle = .none
        featherStyle = .none

        addSubview(collectionView)
        collectionView.addSubview(indicatorImageView)
        addSubview(leftFeatherImageView)
        addSubview(rightFeatherImageView)
        
        collectionView.addObserver(self, forKeyPath: "contentSize", options: [.new, .old], context: nil)
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if collectionView.isDragging == false {
                refreshFeather()
                layoutIndicator()
            }
        }
    }
    
    // 设置选中下标，动画效果
    public func setSelectedSegmentIndex(index: Int, animated: Bool) {
        if animated {
            UIView.animate(withDuration: kAnimatedDuration) {
                self.selectedSegmentIndex = index
            }
        } else {
            selectedSegmentIndex = index
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        var shadowHeight: CGFloat = 0
        if shadowImageView != nil {
            shadowHeight = 0.5
            shadowImageView?.frame = CGRect(x: 0, y: frame.height - shadowHeight, width: frame.width, height: shadowHeight)
        }
        if backgroundImageView != nil {
            backgroundImageView?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - shadowHeight)
        }
        
        collectionView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - shadowHeight)
        
        leftFeatherImageView.frame = CGRect(x: 0, y: 0, width: kFeatherWidth, height: frame.height)
        rightFeatherImageView.frame = CGRect(x: frame.width - kFeatherWidth, y: 0, width: kFeatherWidth, height: frame.height)
    }
    
    private func layoutIndicator() {
        var indicatorFrame: CGRect = CGRect(x: 0, y: self.frame.height - indicatorHeight, width: 0, height: indicatorHeight)
        
        if let cell = collectionView.cellForItem(at: IndexPath(item: selectedSegmentIndex, section: 0)) {
            if indicatorWidth == 0 {
                indicatorFrame.origin.x = cell.frame.origin.x
                indicatorFrame.size.width = cell.frame.width
            } else {
                indicatorFrame.size.width = indicatorWidth
                indicatorFrame.origin.x = cell.frame.origin.x + (cell.frame.width - indicatorWidth) / 2
            }
        } else {
            if selectedSegmentIndex == 0 && selectedSegmentIndex < items.count {
                let size = sizeForItemAt(indexPath: IndexPath(item: selectedSegmentIndex, section: 0))
                if indicatorWidth == 0 {
                    indicatorFrame.size.width = size.width
                } else {
                    indicatorFrame.size.width = indicatorWidth
                    indicatorFrame.origin.x = (size.width - indicatorWidth) / 2
                }
            }
        }
        indicatorImageView.frame = indicatorFrame
    }
}

extension CSSegmentedControl: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshFeather()
    }
    
    // 刷新羽化效果
    private func refreshFeather() {
        switch featherStyle {
        case .none:
            leftFeatherImageView.alpha = 0
            rightFeatherImageView.alpha = 0
        case .default:
            let offsetX = collectionView.contentOffset.x
            let contentWidth = collectionView.contentSize.width
            
            let leftOffset = offsetX
            
            var temp = leftOffset > kFeatherWidth ? kFeatherWidth : (leftOffset < 0 ? 0 : leftOffset)
            leftFeatherImageView.alpha = temp / kFeatherWidth
            
            let rightOffset = contentWidth - offsetX - collectionView.frame.width
            temp = rightOffset > kFeatherWidth ? kFeatherWidth : (rightOffset < 0 ? 0 : rightOffset)
            rightFeatherImageView.alpha = temp / kFeatherWidth
        }
    }
}

extension CSSegmentedControl: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CSSegmentCell.identifier, for: indexPath) as! CSSegmentCell
        cell.titleLabel.font = textFont
        if indexPath.item == selectedSegmentIndex {
            cell.titleLabel.textColor = selectedTextColor
        } else {
            cell.titleLabel.textColor = textColor
        }
        
        cell.segmentItem = items[indexPath.item]
        return cell
    }
}
extension CSSegmentedControl: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        setSelectedSegmentIndex(index: indexPath.item, animated: true)
        collectionView.reloadData()
    }
    
}

extension CSSegmentedControl: UICollectionViewDelegateFlowLayout {
    
    // 计算item的size
    private func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        let item = items[indexPath.item]
        
        let text: NSString = item.title as NSString? ?? ""
        
        var rect = text.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textFont], context: nil)
        rect.size.width += 0.5
        rect.size.height = collectionView.frame.height
        
        if let image = item.image {
            var imageSize = image.size
            if imageSize.height > self.frame.height {
                let ratio = imageSize.width / imageSize.height
                imageSize.height = collectionView.frame.height
                imageSize.width = collectionView.frame.height * ratio
            }
            rect.size.width += imageSize.width + item.spacing
        }
        
        return rect.size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if itemWidth > 0 {
            return CGSize(width: itemWidth, height: collectionView.frame.height)
        } else {
            return sizeForItemAt(indexPath: indexPath)
        }
    }
    
    // MARK: collectionView横向滚动时，item的height与insetForSection的top、bottom之和应与collectionView的height一致，否则运行会报错（Make a symbolic breakpoint at UICollectionViewFlowLayoutBreakForInvalidSizes to catch this in the debugger.）
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    // MARK: collectionView横向滚动时，minimumLineSpacing和minimumInteritemSpacing如果不设置成一样的，会出现contentSize不正常的问题。原因未知
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
}

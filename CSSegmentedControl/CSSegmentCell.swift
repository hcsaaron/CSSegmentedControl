//
//  CSSegmentCell.swift
//  CSSegmentedControl
//
//  Created by huangchusheng on 2018/12/4.
//  Copyright © 2018 Aaron. All rights reserved.
//

import UIKit

class CSSegmentCell: UICollectionViewCell {
    
    static let identifier = "CSSegmentCell"
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    var segmentItem: CSSegmentItem? {
        didSet {
            if let segmentItem = segmentItem {
                stackView.spacing = segmentItem.spacing
                titleLabel.text = segmentItem.title
                stackView.removeArrangedSubview(imageView)
                if segmentItem.image != nil {
                    imageView.image = segmentItem.image
                    switch segmentItem.style {
                    case .imageOnLeft:
                        stackView.insertArrangedSubview(imageView, at: 0)
                    case .imageOnRight:
                        stackView.addArrangedSubview(imageView)
                    }
                } else {
                    imageView.image = nil
                }
            }
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        stackView.sizeToFit()
//        stackView.center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
//    }
}

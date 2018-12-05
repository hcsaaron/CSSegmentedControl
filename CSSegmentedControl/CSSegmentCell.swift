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
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = self.bounds
    }
}

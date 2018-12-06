
//
//  CSActionCell.swift
//  Demo
//
//  Created by huangchusheng on 2018/12/6.
//  Copyright © 2018 huangchusheng. All rights reserved.
//

import UIKit


class CSActionCell: UITableViewCell {
    
    typealias SegmentedControlValueChangedHandler = (CSActionCell, Int) -> Void

    static let identifier = "CSActionCell"

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var valueChangedHandler: SegmentedControlValueChangedHandler?
    
    var actionModel: CSActionModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    @objc func segmentedControlValueChanged() {
        actionModel?.selectedIndex = segmentedControl.selectedSegmentIndex
        if let handler = self.valueChangedHandler {
            handler(self, segmentedControl.selectedSegmentIndex)
        }
    }
    
    func setValueChangedHandler(handler: @escaping SegmentedControlValueChangedHandler) {
        self.valueChangedHandler = handler
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  ViewController.swift
//  Demo
//
//  Created by huangchusheng on 2018/11/26.
//  Copyright © 2018 huangchusheng. All rights reserved.
//

import UIKit
import CSSegmentedControl

class ViewController: UIViewController {
    
    enum CSAction: String {
        case separatorStyle
        case featherStyle
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
    
    @IBOutlet weak var segmentedControl: CSSegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    var actions: [CSAction] = [
        .separatorStyle,
        .featherStyle,
        .backgroundImage,
        .indicatorWidth,
        .indicatorHeight,
        .indicatorColor,
        .textFont,
        .textColor,
        .selectedTextColor,
        .itemWidth,
        .itemSpacing,
        .leftInset,
        .rightInset
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Demo"
        let titles = [
            "新能源",
            "热门",
            "商城",
            "评测",
            "论坛",
            "提问",
            "访谈",
            "视频",
        ]
        var items: [CSSegmentItem] = []
        for title in titles {
            let image: UIImage? = title == "商城" ? UIImage(named: "icon_shop"): UIImage(named: "icon_shop")
            let item = CSSegmentItem(title: title, image: image)
            items.append(item)
        }
        
        segmentedControl.items = items
        segmentedControl.itemSpacing = 10
        segmentedControl.featherStyle = .default
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        let action = actions[indexPath.row]
        
        cell?.textLabel?.text = action.rawValue
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = actions[indexPath.row]
        switch action {
        case .separatorStyle:
            segmentedControl.separatorStyle = segmentedControl.separatorStyle == .none ? .default : .none
        case .featherStyle:
            segmentedControl.featherStyle = segmentedControl.featherStyle == .none ? .default : .none
        case .backgroundImage:
            segmentedControl.backgroundImage = segmentedControl.backgroundImage == nil ? UIImage(named: "bg") : nil
        case .indicatorWidth:
            segmentedControl.indicatorWidth = segmentedControl.indicatorWidth == 0 ? 20 : 0
        case .indicatorHeight:
            segmentedControl.indicatorHeight = segmentedControl.indicatorHeight == 1 ? 2 : 1
        case .indicatorColor:
            segmentedControl.indicatorColor = segmentedControl.indicatorColor == .black ? .red : .black
        case .textFont:
            segmentedControl.textFont = segmentedControl.textFont.pointSize == 15 ? UIFont.systemFont(ofSize: 20) : UIFont.systemFont(ofSize: 15)
        case .textColor:
            segmentedControl.textColor = segmentedControl.textColor == .gray ? .green : .gray
        case .selectedTextColor:
            segmentedControl.selectedTextColor = segmentedControl.selectedTextColor == .black ? .red : .black
        case .itemWidth:
            segmentedControl.itemWidth = segmentedControl.itemWidth == 0 ? 80 : 0
        case .itemSpacing:
            segmentedControl.itemSpacing = segmentedControl.itemSpacing == 10 ? 0 : 10
        case .leftInset:
            segmentedControl.leftInset = segmentedControl.leftInset == 0 ? 30 : 0
        case .rightInset:
            segmentedControl.rightInset = segmentedControl.rightInset == 0 ? 30 : 0
        }
    }
}

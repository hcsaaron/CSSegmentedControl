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
    
    @IBOutlet weak var segmentedControl: CSSegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    var actions: [CSActionModel] = [
        CSActionModel(action: .separatorStyle),
        CSActionModel(action: .featherStyle),
        CSActionModel(action: .indicatorAnimationType),
        CSActionModel(action: .selectedItemScrollPosition),
        CSActionModel(action: .backgroundImage),
        CSActionModel(action: .indicatorWidth),
        CSActionModel(action: .indicatorHeight),
        CSActionModel(action: .indicatorColor),
        CSActionModel(action: .textFont),
        CSActionModel(action: .textColor),
        CSActionModel(action: .selectedTextColor),
        CSActionModel(action: .itemWidth),
        CSActionModel(action: .itemSpacing),
        CSActionModel(action: .leftInset),
        CSActionModel(action: .rightInset),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Demo"
        
        setUpSegmentedControl()
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(sender:)), for: .valueChanged)
    }
    
    @objc func segmentedControlValueChanged(sender: Any) {
        print("sender = \(sender)")
        print("index = \(segmentedControl.selectedSegmentIndex)")
    }
    
    func setUpSegmentedControl() {
        let titles = [
            "新能源",
            "热门",
            "商城",
            "评测",
            "论坛",
            "提问",
            "访谈",
            "视频",
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
            let image: UIImage? = title == "商城" ? UIImage(named: "icon_shop"): nil
            let item = CSSegmentItem(title: title, image: image)
            items.append(item)
        }
        
        segmentedControl.items = items
        segmentedControl.itemSpacing = 20
        segmentedControl.featherStyle = .default
        segmentedControl.indicatorAnimationType = .crawl
    }
    
    
    
    func titlesForAction(action: CSAction) -> [String] {
        switch action {
        case .separatorStyle:
            return ["none", "default"]
        case .featherStyle:
            return ["none", "default"]
        case .indicatorAnimationType:
            return ["none", "default", "crawl"]
        case .selectedItemScrollPosition:
            return ["none", "center", "left", "right"]
        case .backgroundImage:
            return ["无背景图", "有背景图"]
        case .indicatorWidth:
            return ["0", "20"]
        case .indicatorHeight:
            return ["2", "1"]
        case .indicatorColor:
            return ["black", "red"]
        case .textFont:
            return ["15", "20"]
        case .textColor:
            return ["gray", "green"]
        case .selectedTextColor:
            return ["black", "red"]
        case .itemWidth:
            return ["0", "100"]
        case .itemSpacing:
            return ["10", "20"]
        case .leftInset:
            return ["0", "30"]
        case .rightInset:
            return ["0", "30"]
        }
    }
    
    func changeIndexForAction(index: Int, action: CSAction) {
        switch action {
        case .separatorStyle:
            segmentedControl.separatorStyle = index == 0 ? .none : .default
        case .featherStyle:
            segmentedControl.featherStyle = index == 0 ? .none : .default
        case .indicatorAnimationType:
            segmentedControl.indicatorAnimationType = index == 0 ? .none : (index == 1 ? .default : .crawl)
        case .selectedItemScrollPosition:
            segmentedControl.selectedItemScrollPosition = index == 0 ? .none : (index == 1 ? .center : (index == 2 ? .left : .right))
        case .backgroundImage:
            segmentedControl.backgroundImage = index == 0 ? nil : UIImage(named: "bg")
        case .indicatorWidth:
            segmentedControl.indicatorWidth = index == 0 ? 0 : 20
        case .indicatorHeight:
            segmentedControl.indicatorHeight = index == 0 ? 2 : 1
        case .indicatorColor:
            segmentedControl.indicatorColor = index == 0 ? .black : .red
        case .textFont:
            segmentedControl.textFont = index == 0 ? UIFont.systemFont(ofSize: 15) : UIFont.systemFont(ofSize: 20)
        case .textColor:
            segmentedControl.textColor = index == 0 ? .gray : .green
        case .selectedTextColor:
            segmentedControl.selectedTextColor = index == 0 ? .black : .red
        case .itemWidth:
            segmentedControl.itemWidth = index == 0 ? 0 : 100
        case .itemSpacing:
            segmentedControl.itemSpacing = index == 0 ? 10 : 20
        case .leftInset:
            segmentedControl.leftInset = index == 0 ? 0 : 30
        case .rightInset:
            segmentedControl.rightInset = index == 0 ? 0 : 30
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CSActionCell.identifier) as! CSActionCell
        if cell.valueChangedHandler == nil {
            cell.setValueChangedHandler {[weak self] (theCell, index) in
                guard let `self` = self else { return }
                if let action = theCell.actionModel?.action {
                    self.changeIndexForAction(index: index, action: action)
                }
            }
        }
        
        let actionModel = actions[indexPath.row]
        cell.actionModel = actionModel
        cell.titleLabel.text = actionModel.action.rawValue
        
        let titles = titlesForAction(action: actionModel.action)
        cell.segmentedControl.removeAllSegments()
        for i in 0..<titles.count {
            let title = titles[i]
            cell.segmentedControl.insertSegment(withTitle: title, at: i, animated: false)
        }
        cell.segmentedControl.selectedSegmentIndex = actionModel.selectedIndex
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

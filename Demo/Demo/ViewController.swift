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
        CSActionModel(action: .leftInset),
        CSActionModel(action: .rightInset),
        CSActionModel(action: .itemWidth),
        CSActionModel(action: .itemSpacing),
        CSActionModel(action: .selectedItemScale),
        CSActionModel(action: .indicatorWidth),
        CSActionModel(action: .indicatorHeight),
        CSActionModel(action: .indicatorAnimationType),
        CSActionModel(action: .selectedItemScrollPosition),
        CSActionModel(action: .separatorStyle),
        CSActionModel(action: .featherStyle),
        CSActionModel(action: .backgroundImage),
        CSActionModel(action: .indicatorColor),
        CSActionModel(action: .textFont),
        CSActionModel(action: .textColor),
        CSActionModel(action: .selectedTextColor),
    ]
    
    lazy var items: [CSSegmentItem] = {
        let titles = [
            "推荐",
            "原创",
            "车家号",
            "视频",
            "轿车",
            "新能源",
            "直播",
            "VR体验中心",
            "小游戏",
            "服务",
            "图片",
            "话题",
            "旅行家",
            "Young",
            "车友圈",
            "关注",
            "行情",
            "问答",
            ]
        var items: [CSSegmentItem] = []
        for title in titles {
            let item = CSSegmentItem(title: title)
            if title == "轿车" {
                item.image = UIImage(named: "icon_car")
                item.spacing = 5
            } else if title == "直播" {
                item.image = UIImage(named: "icon_hot")
                item.style = .imageOnRight
            }
            items.append(item)
        }
        return items
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Demo"
        
        setUpSegmentedControl()
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(sender:)), for: .valueChanged)
        
        segmentedControl.addTarget(self, action: #selector(touchCancel), for: .touchCancel)
    }
    
    @objc func touchCancel() {
        print("touchCancel")
    }
    
    @objc func segmentedControlValueChanged(sender: Any) {
        print("sender = \(sender)")
        print("index = \(segmentedControl.selectedSegmentIndex)")
    }
    
    // CSSegmentedControl 基本配置
    func setUpSegmentedControl() {
//        CSSegmentedControl(items: <#T##[CSSegmentItem]#>)  // 实例化方法
//        CSSegmentedControl(titles: <#T##[String]#>)        // item只有title时可用这个实例化方法
        
        // 设置items
        segmentedControl.items = items
        
        // 样式配置
        segmentedControl.leftInset = 0                      // 左边inset
        segmentedControl.rightInset = 0                     // 右边inset
        segmentedControl.itemWidth = CSSegmentedControl.automaticDimension  // item宽度
        segmentedControl.itemSpacing = 10                   // item间距
        segmentedControl.selectedItemScale = 1              // 选中item的scale
        segmentedControl.indicatorWidth = CSSegmentedControl.automaticDimension // 指示条宽度
        segmentedControl.indicatorHeight = 2                // 指示条高度
        segmentedControl.indicatorAnimationType = .none     // 指示条的动画类型，无动画、默认平滑过渡、蠕动过渡
        segmentedControl.selectedItemScrollPosition = .none // 选中选项后的滚动位置，无滚动、滚到中间、左边、右边
        segmentedControl.separatorStyle = .none             // 底部分割线，无分割线、默认分割线
        segmentedControl.featherStyle = .none               // 左右两边的羽化层，无羽化、默认羽化
        segmentedControl.backgroundImage = nil              // 背景图片设置
        segmentedControl.indicatorColor = .black            // 指示条颜色
        segmentedControl.textFont = UIFont.systemFont(ofSize: 15)       // 字体大小
        segmentedControl.textColor = .gray                  // 文字颜色
        segmentedControl.selectedTextColor = .black         // 选中的文字颜色
    }
    
    func titlesForAction(action: CSAction) -> [String] {
        switch action {
        case .leftInset:
            return ["0", "30"]
        case .rightInset:
            return ["0", "30"]
        case .itemWidth:
            return ["automaticDimension", "equalDimension", "100"]
        case .itemSpacing:
            return ["10", "20"]
        case .selectedItemScale:
            return ["1", "1.5"]
        case .indicatorWidth:
            return ["automaticDimension", "20"]
        case .indicatorHeight:
            return ["2", "1"]
        case .indicatorAnimationType:
            return ["none", "default", "crawl"]
        case .selectedItemScrollPosition:
            return ["none", "center", "left", "right"]
        case .separatorStyle:
            return ["none", "default"]
        case .featherStyle:
            return ["none", "default"]
        case .backgroundImage:
            return ["no bg", "has bg"]
        case .indicatorColor:
            return ["black", "red"]
        case .textFont:
            return ["15", "20"]
        case .textColor:
            return ["gray", "green"]
        case .selectedTextColor:
            return ["black", "red"]
        }
    }
    
    func changeIndexForAction(index: Int, action: CSAction) {
        switch action {
        case .leftInset:
            segmentedControl.leftInset = index == 0 ? 0 : 30
        case .rightInset:
            segmentedControl.rightInset = index == 0 ? 0 : 30
        case .itemWidth:
            if index == 1 {
                // items数较少时，itemWidth才使用equalDimension
                segmentedControl.items = [
                    CSSegmentItem(title: "关注"),
                    CSSegmentItem(title: "热门")
                ]
                segmentedControl.itemWidth = CSSegmentedControl.equalDimension
            } else {
                segmentedControl.items = items
                segmentedControl.itemWidth = index == 0 ? CSSegmentedControl.automaticDimension : 100
            }
        case .itemSpacing:
            segmentedControl.itemSpacing = index == 0 ? 10 : 20
        case .selectedItemScale:
            segmentedControl.selectedItemScale = index == 0 ? 1 : 1.2
        case .indicatorWidth:
            segmentedControl.indicatorWidth = index == 0 ? CSSegmentedControl.automaticDimension : 20
        case .indicatorHeight:
            segmentedControl.indicatorHeight = index == 0 ? 2 : 1
        case .indicatorAnimationType:
            segmentedControl.indicatorAnimationType = index == 0 ? .none : (index == 1 ? .default : .crawl)
        case .selectedItemScrollPosition:
            segmentedControl.selectedItemScrollPosition = index == 0 ? .none : (index == 1 ? .center : (index == 2 ? .left : .right))
        case .separatorStyle:
            segmentedControl.separatorStyle = index == 0 ? .none : .default
        case .featherStyle:
            segmentedControl.featherStyle = index == 0 ? .none : .default
        case .backgroundImage:
            segmentedControl.backgroundImage = index == 0 ? nil : UIImage(named: "bg")
        case .indicatorColor:
            segmentedControl.indicatorColor = index == 0 ? .black : .red
        case .textFont:
            segmentedControl.textFont = index == 0 ? UIFont.systemFont(ofSize: 15) : UIFont.systemFont(ofSize: 20)
        case .textColor:
            segmentedControl.textColor = index == 0 ? .gray : .green
        case .selectedTextColor:
            segmentedControl.selectedTextColor = index == 0 ? .black : .red
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

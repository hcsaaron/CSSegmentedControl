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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Demo"
        let seg = UISegmentedControl(frame: .zero)
        segmentedControl.titles = [
            "新能源",
            "热门",
            "评测",
            "论坛",
            "提问",
            "访谈",
            "视频",
        ]
        print("titles = \(segmentedControl.titles)")
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell?.textLabel?.text = "\(indexPath.row)"
        
        return cell!
    }
}

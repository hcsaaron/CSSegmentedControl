//
//  CSSegmentedControlConstant.swift
//  CSSegmentedControl
//
//  Created by 黄楚升 on 2018/11/22.
//  Copyright © 2018年 Aaron. All rights reserved.
//

import Foundation

let kBundleName = "CSSegmentedControl"

func CSSegmentedControlBundle(bundleName: String) -> Bundle? {
    if let path = Bundle(for: CSSegmentedControl.self).path(forResource: bundleName, ofType: "bundle") {
        return Bundle(path: path)
    } else {
        return nil
    }
    
    // 当作为framework时，下面方法获取的路径有误
//    if let path = Bundle.main.path(forResource: bundleName, ofType: "bundle") {
//        return Bundle(path: path)
//    } else {
//        return nil
//    }
}

func CSSegmentedControlImage(imageName: String) -> UIImage? {
    guard let bundle = CSSegmentedControlBundle(bundleName: kBundleName) else {
        return nil
    }
    let bundlePath = bundle.bundlePath as NSString
    return UIImage(contentsOfFile: bundlePath.appendingPathComponent(imageName))
}


public enum SeparatorStyle {
    case none       // 无分割线
    case `default`  // 默认分割线
}

public enum FeatherStyle {
    case none       // 无羽化效果
    case `default`  // 默认羽化效果
}

public enum IndicatorAnimationType {
    case none           // 无动画
    case `default`      // 默认动画
    case crawl          // 爬行动画
}

public enum SelectedItemScrollPosition {
    case none   // 不滚动
    case center // 滚到中间
    case left   // 滚到左边
    case right  // 滚到右边
}

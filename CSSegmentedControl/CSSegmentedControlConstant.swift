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
    if let path = Bundle.main.path(forResource: bundleName, ofType: "bundle") {
        return Bundle(path: path)
    } else {
        return nil
    }
}

func CSSegmentedControlImage(imageName: String) -> UIImage? {
    guard let bundle = CSSegmentedControlBundle(bundleName: kBundleName) else {
        return nil
    }
    let bundlePath = bundle.bundlePath as NSString
    return UIImage(contentsOfFile: bundlePath.appendingPathComponent(imageName))
}

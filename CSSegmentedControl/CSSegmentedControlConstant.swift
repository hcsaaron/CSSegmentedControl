//
//  CSSegmentedControlConstant.swift
//  CSSegmentedControl
//
//  Created by 黄楚升 on 2018/11/22.
//  Copyright © 2018年 Aaron. All rights reserved.
//

import Foundation

let kBundleName = "CSSegmentedControl"

func cs_bundle(bundleName: String) -> Bundle? {
    if let path = Bundle.main.path(forResource: bundleName, ofType: "bundle") {
        return Bundle(path: path)
    } else {
        return nil
    }
}

//func cs_image(imageName: String) -> UIImage? {
//    if let bundle = cs_bundle(bundleName: kBundleName) {
//        
//        let image = UIImage(contentsOfFile: bundle.bundlePath)
//
//    }
//}

//
//  DemoColor.swift
//  Example-swift
//
//  Created by rocky on 2020/9/7.
//  Copyright © 2020 Rocky. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var backgroundColor = UIColor.init(
        red: 0,
        green: 0,
        blue: 1/255.0,
        alpha: 1
    )
    static var decorateColor = UIColor.init(
        red: 26/255.0,
        green: 28/255.0,
        blue: 30/255.0,
        alpha: 1
    )
    static var titleColor = UIColor(red:0.49, green:0.49, blue:0.49, alpha:1.00)
    static var textColor = UIColor(red:0.36, green:0.37, blue:0.40, alpha:1.00)
    static var themeColor = UIColor(red:1.00, green:0.31, blue:0.15, alpha:1.00)
}

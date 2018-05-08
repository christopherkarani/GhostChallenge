//
//  UIColor_Ext.swift
//  GhostChallenge
//
//  Created by Chris Karani on 5/8/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

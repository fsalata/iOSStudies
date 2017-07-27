//
//  UIColor+extension.swift
//  GameOfChats
//
//  Created by Fábio Salata on 27/07/17.
//  Copyright © 2017 Fábio Salata. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b:CGFloat) {
        self.init(red:r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

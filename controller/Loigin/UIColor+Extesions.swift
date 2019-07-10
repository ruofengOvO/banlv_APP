//
//  UIColor.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/5.
//  Copyright © 2019 Rohlf W. All rights reserved.
//


import UIKit

extension UIColor {
    
    static let themePink = #colorLiteral(red: 0.9763443845, green: 0.8437117314, blue: 0.3941021258, alpha: 1)
    static let themeBlue = #colorLiteral(red: 0.8071065989, green: 0.5720788801, blue: 0.3428734382, alpha: 1)
    
    convenience public init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    convenience public init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
    
}

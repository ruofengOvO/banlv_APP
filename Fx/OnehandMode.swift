//
//  OnehandMode.swift
//  temp1
//
//  Created by 韩梓健 on 2019/3/9.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import UIKit

class OnehandMode{
    static func OnehandMode()->CGFloat{
        switch PhoneModelDetecter.iphoneType(){
            case "iPod Touch 5": return 50
            case "iPod Touch 6": return 50
            case "iPhone 5s": return 50
            case "iPhone SE": return 50
            case "iPhone 6": return 100
            case "iPhone 6s": return 100
            case "iPhone 7": return 100
            case "iPhone 8": return 100
            case "iPhone 6 Plus": return 120
            case "iPhone 6s Plus": return 120
            case "iPhone 7 Plus": return 120
            case "iPhone 8 Plus": return 120
            case "iPhone X": return 150
            case "iPhone XS": return 150
            case "iPhone XS Max": return 150
            case "iPhone XR": return 150
        default: return 200
        }
    }
    static func OnehandMode1()->Int{
        switch PhoneModelDetecter.iphoneType(){
        case "iPhone SE": return 2
        case "iPhone 6s": return 2
        case "iPhone 7": return 2
        case "iPhone 8": return 2
        case "iPhone 6s Plus": return 3
        case "iPhone 7 Plus": return 3
        case "iPhone 8 Plus": return 3
        case "iPhone X": return 3
        case "iPhone XS": return 3
        case "iPhone XS Max": return 3
        case "iPhone XR": return 3
        default: return 2
        }
    }
}

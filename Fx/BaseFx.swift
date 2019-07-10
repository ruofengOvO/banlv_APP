//
//  BaseFx.swift
//  UIView
//
//  Created by 韩梓健 on 2019/3/3.
//  Copyright © 2019 韩梓健. All rights reserved.
//

import UIKit

class BaseFx: NSObject {
    func Smaller(Button: UIButton){
        Button.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
    }
    func Smaller(Text: UITextField){
        Text.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
    }
    func Smaller(Text: UILabel){
        Text.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
    }
}

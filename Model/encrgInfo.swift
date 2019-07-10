//
//  encrgInfo.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/4.6
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import Foundation
class encrgInfo{
    private var encrgID:String?
    private var encrgSendID:String?
    private var encrgReciverID:String?
    private var encrgTime:String?
    private var encrgMoney:Double?
    private var encrgNote:String?
    
    init(encrgID:String,encrgSendID:String,encrgReciverID:String) {
        self.encrgID = encrgID
        self.encrgSendID = encrgSendID
        self.encrgReciverID = encrgReciverID
    }
}

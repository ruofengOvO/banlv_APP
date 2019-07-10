//
//  historyInfo.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/4.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import Foundation
class historyInfo{
    private var historyID:String?
    private var userID:String?
    private var articleID:String?
    
    init(historyID:String,userID:String,articleID:String){
        self.historyID = historyID
        self.userID = userID
        self.articleID = articleID
    }
}

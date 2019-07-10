//
//  favoriteInfo.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/4.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import Foundation
class favoriteInfo{
    private var favoriteID:String?
    private var userID:String?
    private var articleID:String?
    
    init(favoriteID:String,userID:String,articleID:String) {
        
        self.favoriteID = favoriteID
        self.userID = userID
        self.articleID = articleID
    }
}

//
//  articleInfo.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/4.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import Foundation
class articleInfo{
    var articleID:String?
    var articleText:String?
    var articleTime:String="0.00"
    var articleWriterID:String?
    var articleimage:[String]?
    var title:String?
    init(articleID:String, articleWriterID:String,title:String,images:[String],text:String) {
        self.articleID = articleID
        self.articleWriterID = articleWriterID
        self.articleimage=images
        self.title=title
        self.articleText=text
    }
}

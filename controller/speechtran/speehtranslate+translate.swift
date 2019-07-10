//
//  speehtranslate+translate.swift
//  test2
//
//  Created by miaoz on 2019/2/17.
//  Copyright © 2019 miaoz. All rights reserved.
//

import Foundation
import  UIKit
import SwiftyJSON
extension speeh_text_ViewController{
    func translate(text:String,type:String)
    {
        var to:String
        if type=="before"
        {
            to=lau_date[tar]!
        }else
        {
            to=lau_date[souce]!
        }
        var translatedtext:String=""
        let rnden:String="123123"//String(arc4random())
        var sign="\(appid)\(text)\(rnden)\(baidukey)"
        sign=sign.utf8encodedString()
        sign=sign.md5()
        let urlstring:String="https://fanyi-api.baidu.com/api/trans/vip/translate?q=\(text)&from=auto&to=\(to)&appid=\(appid)&salt=\(rnden)&sign=\(sign)"
        let newurlSTring=urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let config=URLSessionConfiguration.default
        let url=URL(string: newurlSTring!)
        let request=URLRequest(url: url!)
        let session=URLSession(configuration: config)
        let task=session.dataTask(with: request){
            (date,response,error)in
            let dict=try?JSON(data: date!)
            print(dict as Any)
            translatedtext=dict!["trans_result"][0]["dst"].stringValue
            self.trandatedict.append(trandate(before_text: text, after_text: translatedtext, type: type))
            print("and:"+translatedtext)
        }
        task.resume()
    }
    
}

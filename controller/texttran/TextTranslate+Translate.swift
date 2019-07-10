//
//  TextTranslate+Translate.swift
//  test2
//
//  Created by miaoz on 2019/2/17.
//  Copyright © 2019 miaoz. All rights reserved.
//

import Foundation
import SwiftyJSON
import ROGoogleTranslate
extension FirstViewController{
    func translate1()
    {
        let text=before_text.text!
        print(text)
        let to:String=lau_date[tar]!
        print(to)
        var translatedtext:String=""
        let rnden:String="12312113"//String(arc4random())
        var sign="\(appid)\(text)\(rnden)\(baidukey)"
//        sign=sign.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        sign=MD5(sign)
        sign=sign.lowercased()
        print(sign)
        let urlstring:String="https://fanyi-api.baidu.com/api/trans/vip/translate?q=\(text)&from=auto&to=\(to)&appid=\(appid)&salt=\(rnden)&sign=\(sign)"
        let newurlSTring=urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let config=URLSessionConfiguration.default
        let url=URL(string: newurlSTring!)
        let request=URLRequest(url: url!)
        let session=URLSession(configuration: config)
        let task=session.dataTask(with: request){
            (date,response,error)in
            let dict=try?JSON(data: date!)
            print(dict)
            translatedtext=dict!["trans_result"][0]["dst"].stringValue
            self.translatedtext=translatedtext
            print("and:"+translatedtext)
        }
        task.resume()
    }
    func translate()
    {
//        let text=before_text.text!
//        print(text)
//        let urlstring =  "https://www.googleapis.com/language/translate/v2?key=AIzaSyDIDsQx7-LDEDETrvObj0IDvDJj5-VPMdo&q=\(self.before_text.text)&source=\(self.souce)&target=\(self.tar)&format=\(text)"
//        let newurlSTring=urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        let config=URLSessionConfiguration.default
//        let url=URL(string: newurlSTring!)
//        let request=URLRequest(url: url!)
//        let session=URLSession(configuration: config)
//        let task=session.dataTask(with: request){
//            (date,response,error)in
//            let dict=try?JSON(data: date!)
//            print(dict)
//            let translatedtext=dict!["trans_result"][0]["dst"].stringValue
//            self.translatedtext=translatedtext
//        }
//        task.resume()
       

        let translator = ROGoogleTranslate()
        translator.apiKey = "AIzaSyDIDsQx7-LDEDETrvObj0IDvDJj5-VPMdo" // Add your API Key here
        
        var params = ROGoogleTranslateParams()
        params.source = Lautype_Apikey_date.google_Lau_date[self.souce] ?? "en"
        params.target = Lautype_Apikey_date.google_Lau_date[self.tar] ?? "zh-CN"
        params.text = self.before_text.text ?? "no"
        print(params.source+params.target+params.text)
        translator.translate(params: params) { (result) in
            DispatchQueue.main.async {
               self.translatedtext = "\(result)"
               print(result+"ll")
                }
        }
        print(params.source+params.target+"lll")
        
//            { (result) in
//                DispatchQueue.main.async {
//                    self.translatedtext = "\(result)"
//                    print(result+"ll")
//                }
//        }
    }
}

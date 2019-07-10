//
//  phototranslate+translate.swift
//  test2
//
//  Created by miaoz on 2019/2/17.
//  Copyright © 2019 miaoz. All rights reserved.
//

import Foundation
import  SwiftyJSON

extension PictranVC{
    func translate(text:String,to:String)->String
    {
        var translatedtext:String=""
        var rnden:String="123123"//String(arc4random())
        var sign="\(appid)\(text)\(rnden)\(baidukey)"
        sign=sign.utf8encodedString()
        sign=sign.md5()
        let urlstring:String="https://fanyi-api.baidu.com/api/trans/vip/translate?q=\(text)&from=auto&to=\(to)&appid=\(appid)&salt=\(rnden)&sign=\(sign)"
        let newurlSTring=urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let config=URLSessionConfiguration.default
        let url=URL(string: newurlSTring!)
        let request=URLRequest(url: url!)
        let session=URLSession(configuration: config)
        let semaphore=DispatchSemaphore(value: 0)
        let task=session.dataTask(with: request){
            (date,response,error)in
            //   print(date)
            let dict=try?JSON(data: date!)
            print(dict)
            translatedtext=dict!["trans_result"][0]["dst"].stringValue
            print("and:"+translatedtext)
            semaphore.signal()
        }
        task.resume()
        _=semaphore.wait(timeout: DispatchTime.distantFuture)
        return translatedtext
        //   return self.translatedtext
    }
    func translatedate(data:[loc],to:String)
    {
        var dictt=data
        //let json=try!JSON(data: data)
        let group=DispatchGroup()
        for (index,arrayitem)in dictt.enumerated(){
            group.enter()
            var text=arrayitem.text
            var translatedtext:String=""
            var rnden:String="123123"//String(arc4random())
            var sign="\(self.appid)\(text)\(rnden)\(self.baidukey)"
            sign=sign.utf8encodedString()
            sign=sign.md5()
            let urlstring:String="https://fanyi-api.baidu.com/api/trans/vip/translate?q=\(text)&from=auto&to=\(to)&appid=\(self.appid)&salt=\(rnden)&sign=\(sign)"
            let newurlSTring=urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let config=URLSessionConfiguration.default
            let url=URL(string: newurlSTring!)
            let request=URLRequest(url: url!)
            let session=URLSession(configuration: config)
            let task=session.dataTask(with: request){
                (date,response,error)in
                //   print(date)
                let dict=try?JSON(data: date!)
                //  print(dict)
                translatedtext=dict!["trans_result"][0]["dst"].stringValue
                dictt[index].text=translatedtext
                print("and:"+translatedtext)
                group.leave()
            }
            task.resume()
        }
        group.notify(queue: .main, execute: {
            print(dictt)
            self.updateimageview(date: dictt)
        })
    }
    func showResult(data:Data) {
        var dict:[loc]=[]
        let json = try! JSON(data: data)
        print(json)
        for (_,subJson):(String, JSON) in json["words_result"]{
            let temp:loc=loc.init(text: subJson["words"].stringValue, width: subJson["location"]["width"].intValue, heith: subJson["location"]["height"].intValue, left: subJson["location"]["left"].intValue, top: subJson["location"]["top"].intValue)
            dict.append(temp)
        }
        self.translatedate(data: dict, to: self.lau_date[self.tar]!)
   //      self.updateimageview(date: dict)
        print(self.imagett.size.height,"/",self.imagett.size.width)
    }
    func updateimageview(date:[loc])
    {
        DispatchQueue.main.async {
            var si:Int=OnehandMode.OnehandMode1()
            for item in date{
                //self.imagett=self.imagett.drawtext(text: item.text,point: CGRect(x: item.left, y: item.top, width: item.width, height: item.heith))
                self.drawmao(rect: CGRect(x: item.left/si, y: item.top/si, width: item.width/si, height: item.heith/si))
                print(item)
            }
            for item in date{
                self.drawtext(text: item.text,rect: CGRect(x: item.left/si, y: item.top/si, width: item.width/si, height: item.heith/si))
            }
        }
    }
    
    
}

//
//  arplace.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/6.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SwiftyJSON
import Foundation
extension arplaceViewController{

    func base64EncodeImage(_ image: UIImage) -> String {
        var imagedata = image.pngData()
        
        // Resize the image if it exceeds the 2MB API limit
        if (imagedata!.count > 2097152) {
            let oldSize: CGSize = image.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            
            imagedata = resizeImage(newSize, image: image)
        }
        var tt=imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
        return tt.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
    }
    
    func createRequest(with imageBase64: String) {
        // Create our request URL
        var request = URLRequest(url: googleURL)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type")
        // request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        // Build our API request
        var body:String="image=" + imageBase64
        let jsonRequest = [
            "image":imageBase64
        ]
        let jsonObject = JSON(jsonRequest)
        // Serialize the JSON
        guard let data = try? jsonObject.rawData() else {
            return
        }
        request.httpBody = body.data(using: .utf8)
        
        // Run the request on a background thread
        DispatchQueue.global().async { self.runRequestOnBackgroundThread(request) }
    }
    func runRequestOnBackgroundThread(_ request: URLRequest) {
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            // print(data)
            let json = try?JSON(data:data)
            self.ocrdate=json
            print(json)
            self.showResult(data: data)
        }
        task.resume()
    }
    func afrequest(with imagebase64:String)
    {
        var body:String="image=" + imagebase64
    }
    func translatedate2(data:[loc],to:String){
        var texttemp:String!
        for (index,arrayitem)in data.enumerated(){
            if index != 0 {
                texttemp=texttemp+"/n\(arrayitem.text)"}
            else{
                texttemp=arrayitem.text
            }
        }
        var dictt=data
        //let json=try!JSON(data: data)
        let group=DispatchGroup()
        group.enter()
        var text=texttemp
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
            print(dict)
            // translatedtext=dict!["trans_result"][0]["dst"].stringValue
            print("and:"+translatedtext)
            group.leave()
        }
        task.resume()
        group.notify(queue: .main, execute: {
            print(dictt)
            
        })
    }
    
    func translatedate(data:[loc],to:String)
    {
        
        var dictt=data
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
            self.draw(date: dictt)
            
        })
    }
    func showResult(data:Data) {
        var dict:[loc]=[]
        let json = try! JSON(data: data)
        //   var point=self.scenView.frame.get_point_maxl()
        print(json)
        for (_,subJson):(String, JSON) in json["words_result"]{
            let temp:loc=loc.init(text: subJson["words"].stringValue, width: subJson["location"]["width"].intValue, heith: subJson["location"]["height"].intValue, left: subJson["location"]["left"].intValue, top: subJson["location"]["top"].intValue)
            dict.append(temp)
        }
       // self.draw(date: dict)
        self.translatedate(data: dict, to: self.lau_date[self.tar]!)
}
    func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
        UIGraphicsBeginImageContext(imageSize)
        image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let resizedImage = newImage!.pngData()
        UIGraphicsEndImageContext()
        self.imagett=newImage
        print(imagett.size.height)
        return resizedImage!
    }
    
}

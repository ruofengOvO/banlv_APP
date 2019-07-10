//
//  get_weather.swift
//  test2
//
//  Created by miaoz on 2019/2/18.
//  Copyright © 2019 miaoz. All rights reserved.
//

import Foundation
import SwiftyJSON
class get_weather :NSObject{
    func getwether()->String
    {
        var weather:String=""
        let semaphore=DispatchSemaphore(value: 0)
        let urlstring:String="https://sapi.k780.com/?app=weather.future&weaid=\(get_ip.ipAddress)&appkey=\(Lautype_Apikey_date.NowApiKey)&sign=\(Lautype_Apikey_date.NowSign)&format=json"
        let newurlSTring=urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let config=URLSessionConfiguration.default
        let url=URL(string: newurlSTring!)
        let request=URLRequest(url: url!)
        let session=URLSession(configuration: config)
        let task=session.dataTask(with: request){
            (date,response,error)in
            let dict=try?JSON(data: date!)
            weather=dict!["result"][0]["weather"].stringValue
            print(dict)
            semaphore.signal()
            
        }
        task.resume()
        _=semaphore.wait(timeout: DispatchTime.distantFuture)
        return weather
    }
}

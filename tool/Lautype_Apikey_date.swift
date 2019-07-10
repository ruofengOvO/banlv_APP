//
//  choice_delegate_type.swift
//  test2
//
//  Created by miaoz on 2019/2/16.
//  Copyright © 2019 miaoz. All rights reserved.
//

import Foundation
import UIKit
class Lautype_Apikey_date:NSObject {
    var userimagedate:[UIImage]=[UIImage(named: "avatar-3")!,UIImage(named: "xiaobing")!,UIImage(named: "pangding")!]
    let GoogleAPIKey = "24.e8a1ca0b3602b0785d517078e7d132ca.2592000.1554373499.282335-15688658"
    let Baiduappid="20190317000278056"
    //"20190201000261846"
    let Baidukey="9tLMgAyH36_jyP1nQiqL"
    //"_dTto8Nhuzcy1wq9gzHi"
    let Lau_date:[String:String]=["英语":"en","中文":"zh","德语":"de","日语":"jp"]
    static let google_Lau_date:[String:String]=["英语":"en","中文":"zh-CN","德语":"de","日语":"jp"]
    let IOS_Speech_laudate:[String:String]=["英语":"en-US","中文":"zh-CN","德语":"de-DE","日语":"ja-JP"]
    static let Lau_type_date:[String]=["英语","中文","德语","日语"]
    static let NowApiKey:String="40239"
    static let NowSign:String="759e08d283ceae2b7e8e29fa2c0b4538"
    static let BaiduAK:String="qi0g82MG020ktj3RGgkiWKLGfrzhwxG7"
    static let BaiduSk:String="dtI5pXp8MQL35QX1znweSlqPwm9fUW7h"
    func BaiduAppid()->String {
        return Baiduappid
    }
    func googelAPIKey() -> String {
        return GoogleAPIKey
    }
    func baiduAPIKey()  -> String{
        return Baidukey
    }
    func lau_Date()  -> [String:String]{
        return Lau_date
    }
    func ios_Speech_laudate()  ->[String:String]{
        return IOS_Speech_laudate
    }
//    func lau_type_date()  ->[String]{
//        return self.Lau_type_date
//    }
}

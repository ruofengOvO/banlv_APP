//
//  baidu_paice_api.swift
//  test2
//
//  Created by miaoz on 2019/2/22.
//  Copyright © 2019 miaoz. All rights reserved.
//

import Foundation
import CommonCrypto
import SwiftyJSON
import MapKit
import SceneKit
import ARKit
import CoreLocation
import  ARCL
extension arplaceViewController{
    func loadpalce(adress:String,query:String){
        //let text=before_text.text!
        let adress1=adress
        //print(adress)
        let urlstring:String="http://api.map.baidu.com/place/v2/search?query=\(query)&location=\(adress)&radius=1000&output=json&scope=2&ak=\(Lautype_Apikey_date.BaiduAK)"
        let newurlSTring=urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let config=URLSessionConfiguration.default
        let url=URL(string: newurlSTring!)
        let request=URLRequest(url: url!)
        let session=URLSession(configuration: config)
        let task=session.dataTask(with: request){
            (date,response,error)in
            let dict=try?JSON(data: date!)
            print(dict)
            self.placedict=dict
            self.loadplace()
            self.placedetail(uid: dict!["results"][0]["uid"].stringValue)
        }
        task.resume()
    }
    func loadplace()
    {
        for (_,item) in self.placedict["results"]{
            let x=item["location"]["lat"].doubleValue
            let y=item["location"]["lng"].doubleValue
            print(x)
            print(y)
            let coordinate=CLLocationCoordinate2D(latitude: x, longitude: y)
            let loction=CLLocation(coordinate: coordinate, altitude: 100)
            var image:UIImage=(UIImage(named: "标志")?.ardrawtext(text: item["name"].stringValue, point: CGRect(x: 50, y: 5, width: 160, height: 20),fontsize: 15))!
            image=image.ardrawtext(text: "距离：\(item["detail_info"]["distance"].stringValue)M", point: CGRect(x: 50, y: 30, width: 160, height: 15), fontsize: 10)
            let annonode=LocationAnnotationNode(location: loction, image: image)

            annonode.name=item["name"].stringValue
            annodct[item["name"].stringValue]=annonode
            webdict[item["name"].stringValue]=item["detail_info"]["detail_url"].stringValue
          //  UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
            scenlocview.addLocationNodeWithConfirmedLocation(locationNode: annonode)
        }
        print(annodct)
    }
    func placedetail(uid:String)
    {
        print(uid)
        let urlstring:String="http://api.map.baidu.com/place/v2/detail?uid=\(uid)&output=json&scope=2&ak=\(Lautype_Apikey_date.BaiduAK)"
        let newurlSTring=urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let config=URLSessionConfiguration.default
        let url=URL(string: newurlSTring!)
        let request=URLRequest(url: url!)
        let session=URLSession(configuration: config)
        let task=session.dataTask(with: request){
            (date,response,error)in
            let dict=try?JSON(data: date!)
            print(dict)
        }
        task.resume()
    }
}
extension ar_ViewController{
    func loadpalce(adress:String,query:String){
        //let text=before_text.text!
        let adress1=adress
        //print(adress)
        let urlstring:String="http://api.map.baidu.com/place/v2/search?query=\(query)&location=\(adress)&radius=2000&output=json&scope=2&ak=\(Lautype_Apikey_date.BaiduAK)"
        let newurlSTring=urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let config=URLSessionConfiguration.default
        let url=URL(string: newurlSTring!)
        let request=URLRequest(url: url!)
        let session=URLSession(configuration: config)
        let task=session.dataTask(with: request){
            (date,response,error)in
            let dict=try?JSON(data: date!)
            print(dict)
            self.placedict=dict;
            self.placedetail(uid: dict!["results"][0]["uid"].stringValue)
          // http://api.map.baidu.com/place/v2/detail?uid=435d7aea036e54355abbbcc8&output=json&scope=2&ak=
            //translatedtext=dict!["trans_result"][0]["dst"].stringValue
           // self.translatedtext=translatedtext
          //  print("and:"+translatedtext)
        }
        task.resume()
    }
    func placedetail(uid:String)
    {
        print(uid)
        let urlstring:String="http://api.map.baidu.com/place/v2/detail?uid=\(uid)&output=json&scope=2&ak=\(Lautype_Apikey_date.BaiduAK)"
        let newurlSTring=urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let config=URLSessionConfiguration.default
        let url=URL(string: newurlSTring!)
        let request=URLRequest(url: url!)
        let session=URLSession(configuration: config)
        let task=session.dataTask(with: request){
            (date,response,error)in
            let dict=try?JSON(data: date!)
            print(dict)
        }
        task.resume()
    }
    func loadplace()
    {
        var cx:Double!
        var cy:Double!
        LocationManager.shareManager.creatLocationManager().startLocation{(loc,adress,error)in
            cx=Double((loc?.coordinate.latitude)!)
            cy=Double((loc?.coordinate.longitude)!)
            print("*****")
            print(cx)
            print(cy)
            print("*****")
            for (index,item) in self.placedict["results"]{
                let mat=SCNMaterial()
                mat.diffuse.contents=UIColor.red
                let x=item["location"]["lat"].doubleValue
                let y=item["location"]["lng"].doubleValue
                print(x)
                print(y)
                var _:Float!
                let angel:Float=Float(Alltool().getangel(latitude1: cx, longitude1: cy, latitude2: x, longitude2: y))
                print(angel)
                _=SCNVector3Make(10*cos(angel*180), 10*sin(angel*180),0.45 )
                let textscen=SCNText(string: "123", extrusionDepth: 1)
                 let textnode=SCNNode()
                 textnode.scale=SCNVector3Make(
                 0.0003,0.0003, 0.0003)
                 textscen.materials=[mat]
                 textnode.geometry=textscen
                let ptrotation=self.scenView.pointOfView?.rotation
                textnode.rotation=SCNVector4(0,(ptrotation?.y)!,0, (ptrotation?.w)!)
                DispatchQueue.main.async {
                  self.scenView.scene.rootNode.addChildNode(textnode)
                }
            }
        }
       
    }
}


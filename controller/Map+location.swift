//
//  Map+location.swift
//  test2
//
//  Created by miaoz on 2019/2/18.
//  Copyright © 2019 miaoz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation
extension Map_ViewController{
    func reverseGeocodeLocation(location:CLLocation){
        _=LocationManager.shareManager.creatLocationManager().startLocation{(loc,adress,error)in
            let objectAnnotation = MKPointAnnotation()
            if error == nil{
                //设置大头针的显示位置
                objectAnnotation.coordinate = (location.coordinate)
                //设置点击大头针之后显示的标题
                objectAnnotation.title = adress
                //设置点击大头针之后显示的描述
                //0  objectAnnotation.subtitle =  (loc?.subLocality)!+(loc?.locality)! + (loc?.subThoroughfare)!
                //设置大头针的显示位置
                objectAnnotation.coordinate = (location.coordinate)
            }
            else{
                objectAnnotation.coordinate = (location.coordinate)
                //设置点击大头针之后显示的标题
                objectAnnotation.title = "定位失败"
                //设置点击大头针之后显示的描述
                objectAnnotation.subtitle =  ""
                //设置大头针的显示位置
                objectAnnotation.coordinate = (location.coordinate)
            }
            self.mainMapView.addAnnotation(objectAnnotation)
        }
    }
    func refresh_map(){
        //地图类型设置 - 标准地图
        self.mainMapView.mapType = MKMapType.standard
        //创建一个MKCoordinateSpan对象，设置地图的范围（越小越精确）
        let latDelta = 0.05
        let longDelta = 0.05
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        //定义地图区域和中心坐标（
        //使用当前位置
        var center:CLLocation = locationManager.location ?? CLLocation()
        reverseGeocodeLocation(location: center)
        //使用自定义位置
        /*let center:CLLocation = CLLocation(latitude: 32.029171, longitude: 118.788231)
         */
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate,span: currentLocationSpan)
        //设置显示区域
        self.mainMapView.setRegion(currentRegion, animated: true)
    }
}

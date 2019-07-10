//
//  LocationUtil.swift
//  LoveHome
//
//  Created by Apple on 2018/11/5.
//  Copyright © 2018年 Apple. All rights reserved.
//


/*
 //使用示例代码
 LocationUtil.shareInstance.getCurrentLocation(isOnce: true) { (loc, errorMsg) -> () in
 if errorMsg == nil {
    print(loc?.administrativeArea ?? "")
    }
 }
 */
import Foundation
import CoreLocation

typealias LocationResultBlock = (_ loc: CLPlacemark?, _ errorMsg: String?) -> ()

typealias LocationPointResultBlock = (_ loc: CLLocation?, _ errorMsg: String?) -> ()

class LocationUtil: NSObject {
    
    var isOnce: Bool = false
    
    var isLocation = false
    
    var locationCode : CLPlacemark?
    
    static let share = LocationUtil()
    
    lazy var locationM: CLLocationManager = {
        
        let locationM = CLLocationManager()
        locationM.requestAlwaysAuthorization()
        //设备使用电池供电时最高的精度
        locationM.desiredAccuracy = kCLLocationAccuracyBest
        
        //精确到1000米,距离过滤器，定义了设备移动后获得位置信息的最小距离
        locationM.distanceFilter = kCLLocationAccuracyKilometer
        locationM.delegate = self
        
        // 请求授权
        if #available(iOS 8.0, *) {
            
            // 请求前后台定位授权
            
            // 请求, 前台定位授权
            
            // 1. 获取info.plist文件内容
            guard let infoDic = Bundle.main.infoDictionary else { return locationM }
            
            // 2. 获取前台定位授权的key 值
            let whenInUse = infoDic["NSLocationWhenInUseUsageDescription"]
            
            // 3. 获取前后台定位授权key 值
            let always = infoDic["NSLocationAlwaysUsageDescription"]
            
            // 4. 判断: 如果两个都有, 请求权限比较高的哪一个
            //  如果只有某一个, 那就请求对应的授权
            //  如果两个都没有, 给其他开发者提醒
            
            if always != nil {
                locationM.requestAlwaysAuthorization()
            }else if whenInUse != nil {
                locationM.requestWhenInUseAuthorization()
                
                // 1. 判断后台模式有没有勾选location updates
                // 2. 判断当前版本时候是ios9.0, 因为只有在ios9.0以后, 才需要额外的设置一个属性为true
                let backModes = infoDic["UIBackgroundModes"]
                if backModes != nil {
                    let resultBackModel = backModes as! [String]
                    
                    if resultBackModel.contains("location") {
                        
                        if #available(iOS 9.0, *){
                            locationM.allowsBackgroundLocationUpdates = true
                        }
                    }
                }
            }else {
                print("错误提示: 不要紧张 在ios8.0以后,想要使用用户位置, 你应该先在info.plist 配置NSLocationWhenInUseUsageDescription 或者 NSLocationAlwaysUsageDescription")
            }
            //5. 每隔100 米定位一次
            locationM.distanceFilter = 100
            
        }
        return locationM
        
    }()
    
    var resultBlock: LocationResultBlock?
    
    func getCurrentLocation(isOnce: Bool,resultBlock: @escaping LocationResultBlock) -> () {
        
        self.isOnce = isOnce
        // 1. 记录block
        self.resultBlock = resultBlock
        
        if locationCode != nil && self.resultBlock != nil {
            
            resultBlock(locationCode, nil)
        }
        
        // 2. 在合适的地方执行
        if CLLocationManager.locationServicesEnabled() {
            if isOnce == true {
                // 单次定位请求
                // 必须实现代理的定位失败方法
                // 不能与startUpdatingLocation方法同时使用
                if #available(iOS 9.0, *) {
                    locationM.requestLocation()
                } else {
                    locationM.startUpdatingLocation()
                }
            }else{
                locationM.startUpdatingLocation()
            }
        }else {
            if self.resultBlock != nil {
                self.resultBlock!(nil, "当前没有开启定位服务")
            }
        }
    }
    
    var resultPointBlock: LocationPointResultBlock?
    /// 仅获取经纬度
    func getCurrentPointLocation(isOnce: Bool,resultPointBlock: @escaping LocationPointResultBlock) -> () {
        
        self.isOnce = isOnce
        // 1. 记录block
        self.resultPointBlock = resultPointBlock
        
        self.isLocation = true
        
        // 2. 在合适的地方执行
        if CLLocationManager.locationServicesEnabled() {
            if isOnce == true {
                // 单次定位请求
                // 必须实现代理的定位失败方法
                // 不能与startUpdatingLocation方法同时使用
                if #available(iOS 9.0, *) {
                    locationM.requestLocation()
                } else {
                    locationM.startUpdatingLocation()
                }
            }else{
                locationM.startUpdatingLocation()
            }
        }else {
            if self.resultPointBlock != nil {
                self.resultPointBlock!(nil, "当前没有开启定位服务")
            }
        }
    }
}

extension LocationUtil: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        // 判断有没有到达10s
        //manager.startUpdatingLocation()
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "closeLoading"), object: nil)
//        if self.resultPointBlock != nil {
//            self.resultPointBlock!(nil, "当前没有开启定位服务")
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let loc = locations.last else {
            if isLocation == false {
                if resultBlock != nil {
                    resultBlock!(nil, "没有获取到位置信息")
                }
                if resultPointBlock != nil {
                    resultPointBlock!(nil, "没有获取到位置信息")
                }
            }
            return
        }
        
        if resultPointBlock != nil {
            resultPointBlock!(loc, nil)
        }
        
        if isLocation == false {
            let geoCoder = CLGeocoder()
            
            geoCoder.reverseGeocodeLocation(loc, completionHandler: {(placemarks, error)->Void in
                var placemark:CLPlacemark!
                
                if error == nil && (placemarks?.count)! > 0 {
                    placemark = (placemarks?[0])! as CLPlacemark
                    self.locationCode = placemark
                    self.resultBlock!(placemark, nil)
                }
            })
            if isOnce {
                manager.stopUpdatingLocation()
            }
        }
    }
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        guard let resultBlock2 = resultBlock else {return}
        
        switch status {
        case .denied:        resultBlock2(nil, "当前被拒绝")
        case .restricted:    resultBlock2(nil, "当前受限制")
        case .notDetermined: resultBlock2(nil, "用户没有决定")
        default: print("nono")
        }
    }
}

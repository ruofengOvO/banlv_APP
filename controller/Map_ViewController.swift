//
//  Map_ViewController.swift
//  test2
//
//  Created by miaoz on 2019/2/17.
//  Copyright © 2019 miaoz. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation
class Map_ViewController: UIViewController {
    
    @IBOutlet weak var mainMapView: MKMapView!
    //定位管理器
    let locationManager:CLLocationManager = CLLocationManager()
    
    @IBAction func refresh(_ sender: Any) {
        refresh_map()//刷新
    }
    @IBAction func guide(_ sender: Any) {
        let geocoder: CLGeocoder = CLGeocoder()
        
        let loc:MKMapItem=MKMapItem.forCurrentLocation()
        let mapItems: [MKMapItem] = [loc, loc]// 起点和终点
        
        let dic: [String : Any] = [// 导航设置字典
            
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,// 导航模式
            
            MKLaunchOptionsMapTypeKey: MKMapType.standard.rawValue,// 地图样式
            
            MKLaunchOptionsShowsTrafficKey: true// 显示交通
            
        ]
        
        MKMapItem.openMaps(with: mapItems, launchOptions: dic)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        refresh_map()//加载
    }
    
}
    


    


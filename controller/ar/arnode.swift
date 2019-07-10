//
//  arnode.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/17.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import UIKit
import ARCL
import CoreLocation
import ARKit
import SceneKit
import SwiftyJSON
import MapKit
extension arplaceViewController{
    func openweb(item:String){
        if webdict[item] != ""{
            let sb=UIStoryboard(name: "Main", bundle: nil)
            let vc=sb.instantiateViewController(withIdentifier: "palcedetail") as!palcefrtail_viewcontroller
            vc.type=item
            vc.urlstring=(webdict[item]?.deletexie())!
            print(vc.urlstring)
            self.present(vc, animated: true, completion: nil)
        }
    }
    func playVideo(url: URL) {
        let boxNode = SCNNode()
        if let videoSize:CGSize =  CGSize(width: 400, height: 300){
            var width: CGFloat = 2
            if videoSize.width > videoSize.height {
                width = 3
            }
            let height: CGFloat = CGFloat(width) * videoSize.height/videoSize.width
            let box = SCNBox(width: 0.3, height: height, length: width  , chamferRadius: 0)
            boxNode.geometry = box
            boxNode.geometry?.firstMaterial?.isDoubleSided = true
            
            boxNode.rotation=SCNVector4(x: (scenlocview.pointOfView?.rotation.x)!, y: 0, z: 0, w: (scenlocview.pointOfView?.rotation.z)!)
            // boxNode.position = poinst?
            
            let camer = scenlocview.session.currentFrame?.camera.transform.columns.3
            boxNode.position=SCNVector3((camer?.x)!+4, (camer?.y)!, (camer?.z)!)
            //SCNVector3Make(2, 2, -3)
            box.firstMaterial?.diffuse.contents = UIColor.red
            //boxNode.rotation=SCNVector4(, <#T##y: Int##Int#>, <#T##z: Int##Int#>, <#T##w: Int##Int#>)
            //  scenlocview.scene.rootNode.addChildNode(boxNode)
            scenlocview.scene.rootNode.addChildNode(boxNode)
            let avplayer = AVPlayer(url: url)
            avplayer.volume =  0
            videoPlayer = avplayer
            let videoNode = SKVideoNode(avPlayer: avplayer)
            //            NotificationCenter.default.addObserver(self, selector: #selector(playEnd(notify:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
            videoNode.size = CGSize(width: 600, height: 300)
            videoNode.position = CGPoint(x: videoNode.size.width/2, y: videoNode.size.height/2)
            videoNode.zRotation = CGFloat(Float.pi)
            let skScene = SKScene()
            skScene.addChild(videoNode)
            skScene.size = videoNode.size
            box.firstMaterial?.diffuse.contents = skScene
            videoNode.play()
        }
    }
    func gide(loc:LocationAnnotationNode){
        let geocoder: CLGeocoder = CLGeocoder()
        
        let pl=MKPlacemark(coordinate: loc.location.coordinate, addressDictionary: [loc.name!:0])
        let loc1:MKMapItem=MKMapItem(placemark: pl)
        loc1.name=loc.name
        let center:CLLocation = locationManager.location!
        let cenpl=MKPlacemark(coordinate: center.coordinate)
        let cenloc:MKMapItem=MKMapItem(placemark: cenpl)
        cenloc.name="你的位置"
        let mapItems: [MKMapItem] = [cenloc, loc1]// 起点和终点
        let dic: [String : Any] = [// 导航设置字典
            
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,// 导航模式
            
            MKLaunchOptionsMapTypeKey: MKMapType.standard.rawValue,// 地图样式
            
            MKLaunchOptionsShowsTrafficKey: true// 显示交通
            
        ]
        
        MKMapItem.openMaps(with: mapItems, launchOptions: dic)
    }
}

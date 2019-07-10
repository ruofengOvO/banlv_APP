//
//  arplaceViewController.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/1.
//  Copyright © 2019 Rohlf W. All rights reserved.
//
import UIKit
import ARCL
import CoreLocation
import ARKit
import SceneKit
import SwiftyJSON
import MapKit
class arplaceViewController:UIViewController,choice_delgate{
//    let rescouceManager = RescouceManager.share
//    let rescoucceConfiguration = RescouceConfiguration.share
    let locationManager:CLLocationManager = CLLocationManager()
    var videoPlayer: AVPlayer?
    lazy var musicPlayer: AVPlayer = {
        let  musicPlayer = AVPlayer()
        return musicPlayer
    }()
    
    @IBAction func Meishi(_ sender: Any) {
        var cx:Double=0
        var cy:Double=0
         LocationManager.shareManager.creatLocationManager().startLocation{(loc,adress,error)in
            cx=Double((loc?.coordinate.latitude)!)
            cy=Double((loc?.coordinate.longitude)!)
            self.loction=CLLocationCoordinate2D(latitude: cx, longitude: cy)
            self.loadpalce(adress: "\(1*cx),\(1*cy)",query: "美食")
        }
        UIView.animate(withDuration: 0.5) {
            self.NearByView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 600)
            self.Meishi.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.Jiaotong.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.Jiudian.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.JIngdian.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        }
    }
    
    @IBAction func Jiaotong(_ sender: Any) {
        var cx:Double=0
        var cy:Double=0
        LocationManager.shareManager.creatLocationManager().startLocation{(loc,adress,error)in
            cx=Double((loc?.coordinate.latitude)!)
            cy=Double((loc?.coordinate.longitude)!)
            self.loction=CLLocationCoordinate2D(latitude: cx, longitude: cy)
            self.loadpalce(adress: "\(1*cx),\(1*cy)",query: "交通")
        }
        UIView.animate(withDuration: 0.5) {
            self.NearByView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 600)
            self.Meishi.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.Jiaotong.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.Jiudian.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.JIngdian.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        }
    }
    @IBAction func Jingdian(_ sender: Any) {
        var cx:Double=0
        var cy:Double=0
        LocationManager.shareManager.creatLocationManager().startLocation{(loc,adress,error)in
            cx=Double((loc?.coordinate.latitude)!)
            cy=Double((loc?.coordinate.longitude)!)
            self.loction=CLLocationCoordinate2D(latitude: cx, longitude: cy)
            self.loadpalce(adress: "\(1*cx),\(1*cy)",query: "旅游景点")
        }
        UIView.animate(withDuration: 0.5) {
            self.NearByView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 600)
            self.Meishi.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.Jiaotong.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.Jiudian.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.JIngdian.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        }
    }
    @IBAction func Jiudian(_ sender: Any) {
        var cx:Double=0
        var cy:Double=0
        LocationManager.shareManager.creatLocationManager().startLocation{(loc,adress,error)in
            cx=Double((loc?.coordinate.latitude)!)
            cy=Double((loc?.coordinate.longitude)!)
            self.loction=CLLocationCoordinate2D(latitude: cx, longitude: cy)
            self.loadpalce(adress: "\(1*cx),\(1*cy)",query: "酒店")
        }
        UIView.animate(withDuration: 0.5) {
            self.NearByView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 600)
            self.Meishi.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.Jiaotong.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.Jiudian.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.JIngdian.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        }
    }
    @IBOutlet weak var Meishi: UIButton!
    @IBOutlet weak var Jiudian: UIButton!
    @IBOutlet weak var JIngdian: UIButton!
    @IBOutlet weak var Jiaotong: UIButton!
    @IBAction func NearByBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.NearByView.transform = CGAffineTransform.identity
            self.Meishi.transform = CGAffineTransform.identity
            self.Jiudian.transform = CGAffineTransform.identity
            self.JIngdian.transform = CGAffineTransform.identity
            self.Jiaotong.transform = CGAffineTransform.identity
        }
    }
    @IBAction func Play(_ sender: Any) {
        playVideo(url: URL(string: "http://yuokonw.oss-cn-shenzhen.aliyuncs.com/%E5%8A%B1%E5%BF%97%E5%88%B0%E7%88%86%E8%A1%A8%EF%BC%8C%E5%B0%8F%E7%B1%B35%E5%91%A8%E5%B9%B4%E6%84%9F%E6%81%A9%E8%A7%86%E9%A2%91%E2%80%94%E2%80%94%E5%A5%94%E8%B7%91%E5%90%A7%EF%BC%81%E5%85%84%E5%BC%9F_%E8%B6%85%E6%B8%85.mp4")!)
    }
    @IBAction func Info(_ sender: Any) {
        openweb(item: (Info.titleLabel?.text)!)
    }
    @IBAction func Navi(_ sender: Any) {
        gide(loc: giedeloction)
    }
    static var tag = 0
    @IBOutlet weak var Play: UIButton!
    @IBOutlet weak var Info: UIButton!
    @IBOutlet weak var Navi: UIButton!
    @IBOutlet weak var TranBtn: UIButton!
    @IBOutlet weak var Language: UIButton!
    @IBAction func BackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func CloseBtn2(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.NearByView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 600)
            self.Meishi.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.Jiaotong.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.Jiudian.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.JIngdian.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        }
    }
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var Nearby: UIButton!
    @IBAction func CloseBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.InfoView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 600)
            self.Navi.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.Play.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.Info.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        }
        
    }
    func clikedvalue(souce: String, tar: String) {
        self.tar=tar
        self.souce=souce
    }
    @IBOutlet weak var InfoView: UIView!
    @IBOutlet weak var LocationFuc: UILabel!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let theSegue=segue.destination as! Language1VC
        theSegue.delegate=self
        theSegue.souce=self.souce
        theSegue.tar=self.tar
        theSegue.touch="souce"
        
    }
    var place_url:String="http://api.map.baidu.com/place/v2/search?query=银行&location=39.915,116.404&radius=2000&output=xml&ak=您的密钥"
    var googleAPIKey = Lautype_Apikey_date().googelAPIKey()
    var appid=Lautype_Apikey_date().BaiduAppid()
    var baidukey=Lautype_Apikey_date().baiduAPIKey()
    var requestdate:String!
    var translatedtext:String=""
    var imagett:UIImage!
    var tar:String="中文"
    var souce:String="英语"
    var flo_y:Float!
    var giedeloction:LocationAnnotationNode!
    let lau_date:[String:String]=Lautype_Apikey_date().lau_Date()
    struct loc{
        var text:String
        var width:Int
        var heith:Int
        var left:Int
        var top:Int
    }
    let session = URLSession.shared
    var ocrdate:JSON!
    var googleURL: URL
    {
        return URL(string: "https://aip.baidubce.com/rest/2.0/ocr/v1/general?access_token=\(googleAPIKey)")!
    }
    var placetype:[String] = ["美食","酒店","景点","交通设施"]
    var scenlocview=SceneLocationView()
    var annodct=[String:LocationAnnotationNode]()
    var webdict=[String:String]()
    var loction:CLLocationCoordinate2D!
    var placedict:JSON!
    {
        didSet{
            DispatchQueue.main.async {
                self.loadplace()
            }
        }
    }
    var Effects = SnowingEffect()
    @objc func tapHandle(gesture:UITapGestureRecognizer){
        let results:[SCNHitTestResult] = (self.scenlocview.hitTest(gesture.location(ofTouch: 0, in: self.scenlocview), options: nil))
        guard let firstNode  = results.first else{
            return
        }
        for item in annodct{
            if item.value.childNodes.first==firstNode.node{
                print(item.key)
                print(webdict)
                self.giedeloction=item.value
                UIView.animate(withDuration: 0.5) {
                    self.InfoView.transform = CGAffineTransform.identity
                    self.Info.setTitle(item.key, for: UIControl.State.normal)
                    self.Navi.transform = CGAffineTransform.identity
                    self.Info.transform = CGAffineTransform.identity
                    self.Play.transform = CGAffineTransform.identity
                    self.LocationFuc.text=item.value.name
                }
            }
        }
    }
    @IBOutlet weak var neby_label: UILabel!
    @IBOutlet weak var hotel_label: UILabel!
    @IBOutlet weak var find_gotel_label: UILabel!
    @IBOutlet weak var fanteat_label: UILabel!
    @IBOutlet weak var find_eat_label: UILabel!
    @IBOutlet weak var jindian_label: UILabel!
    @IBOutlet weak var find_jindian_label: UILabel!
    @IBOutlet weak var Neby_shutdown_label: UIButton!
    @IBOutlet weak var jiaoton_label: UILabel!
    @IBOutlet weak var fin_jiaoton_label: UILabel!
    
    
    
    
    
    @IBOutlet weak var guide_label: UILabel!
    @IBOutlet weak var go_guide: UILabel!
    @IBOutlet weak var info_label: UILabel!
    @IBOutlet weak var see_info: UILabel!
    @IBOutlet weak var play_info: UILabel!
    @IBOutlet weak var play_info1: UILabel!
    @IBOutlet weak var info_back: UIButton!
    func loaclized(){
        DispatchQueue.main.async {
             self.neby_label.text=NSLocalizedString("附近", comment: "附近")
             self.fanteat_label.text=NSLocalizedString("美食", comment: "美食")
             self.hotel_label.text=NSLocalizedString("酒店", comment: "酒店")
             self.jindian_label.text=NSLocalizedString("景点", comment: "景点")
             self.hotel_label.text=NSLocalizedString("酒店", comment: "酒店")
             self.find_gotel_label.text=NSLocalizedString("寻找酒店", comment: "寻找酒店")
             self.find_eat_label.text=NSLocalizedString("查找餐厅", comment: "查找餐厅")
             self.fin_jiaoton_label.text=NSLocalizedString("查找交通设施", comment: "查找交通设施")
             self.find_jindian_label.text=NSLocalizedString("发现景点", comment: "发现景点")
             self.Neby_shutdown_label.setTitle(NSLocalizedString("关闭", comment: "关闭"), for: .normal)
            
            self.guide_label.text=NSLocalizedString("导航", comment: "导航")
              self.go_guide.text=NSLocalizedString("导航到这里去", comment: "导航到这里去")
            self.info_label.text=NSLocalizedString("详细信息", comment: "详细信息")
            self.see_info.text=NSLocalizedString("查看这里的详细信息", comment: "查看这里的详细信息")
             self.play_info.text=NSLocalizedString("播放介绍", comment: "播放介绍")
             self.play_info1.text=NSLocalizedString("观看介绍片", comment: "观看介绍片")
            self.info_back.setTitle(NSLocalizedString("关闭", comment: "关闭"), for: .normal)
            
            
            
            
            self.TranBtn.setTitle(NSLocalizedString("翻译", comment: "翻译"), for: .normal)
            self.Language.setTitle(NSLocalizedString("语言", comment: "语言"), for: .normal)
             self.BackBtn.setTitle(NSLocalizedString("返回", comment: "返回"), for: .normal)
             self.Nearby.setTitle(NSLocalizedString("附近", comment: "附近"), for: .normal)
            // self.bartitle.title = NSLocalizedString("翻译与工具", comment: "翻译与工具")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loaclized()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandle(gesture:)))
        scenlocview.addGestureRecognizer(tap)
        BackBtn.backgroundColor = UIColor.white
        BackBtn.layer.cornerRadius = 16
        BackBtn.alpha = 0.5
        Nearby.backgroundColor = UIColor.white
        Nearby.layer.cornerRadius = 16
        Nearby.alpha = 0.5
        Language.backgroundColor = UIColor.white
        Language.layer.cornerRadius = 16
        Language.alpha = 0.5
        TranBtn.backgroundColor = UIColor.white
        TranBtn.layer.cornerRadius = 16
        TranBtn.alpha = 0.5
        scenlocview.run()
        containview.addSubview(scenlocview)
        InfoView.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0.8)
        InfoView.layer.cornerRadius = 16
        InfoView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 600)
        Navi.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        Play.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        Info.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        NearByView.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0.8)
        NearByView.layer.cornerRadius = 16
        NearByView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 600)
        Meishi.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        Jiudian.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        JIngdian.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        Jiaotong.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
//        Navi.isHidden = true
//        Info.isHidden = true
//        Play.isHidden = true
        
    }
    @IBOutlet weak var NearByView: UIView!
    @IBAction func lau_choicebtn_touch(_ sender: Any) {
        
        
    }
    @IBOutlet weak var containview: UIView!
    @IBOutlet weak var loadola: UIButton!
    @IBAction func loadola(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            self.loadola.transform = CGAffineTransform.identity.rotated(by:CGFloat (Double.pi))
            self.loadola.transform = CGAffineTransform.identity
        }
        let image=scenlocview.snapshot()
        fetchIdentifications(for: image)
        var cx:Double=0
        var cy:Double=0
        LocationManager.shareManager.creatLocationManager().startLocation{(loc,adress,error)in
            cx=Double((loc?.coordinate.latitude)!)
            cy=Double((loc?.coordinate.longitude)!)
            self.loction=CLLocationCoordinate2D(latitude: cx, longitude: cy)
            self.loadpalce(adress: "\(1*cx),\(1*cy)",query: "饭店")
        }
    }
    //@IBOutlet weak var arkitview: UIView!
    @IBAction func translate_btntouch(_ sender: Any) {
        
        
    }
    @IBAction func tran_touch(_ sender: Any) {
        let image=self.scenlocview.snapshot()
        //current = scenlocview.session.currentFrame
      //  UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        createRequest(with: base64EncodeImage(image))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scenlocview.frame=containview.bounds
        // scenlocview.locationDelegate=self
    }
}
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch:AnyObject in touches{
//            let t:UITouch=touch as! UITouch
//            let touchpoint=t.location(in: view)
//            let results=scenlocview.hitTest(touchpoint, options: nil)
//            guard let result = results.first else {
//                return
//            }
//            print(result)
//            for item in annodct{
//                if item.value.childNodes.first==result.node{
//                    print(item.key)
//                    print(webdict)
//                    self.giedeloction=item.value
//                    UIView.animate(withDuration: 0.5) {
//                        self.InfoView.transform = CGAffineTransform.identity
//                        self.Info.setTitle(item.key, for: UIControl.State.normal)
//                        self.Navi.transform = CGAffineTransform.identity
//                        self.Info.transform = CGAffineTransform.identity
//                        self.Play.transform = CGAffineTransform.identity
//                        self.LocationFuc.text=item.value.name
//                    }
    
                    
//                    Navi.transform = CGAffineTransform.identity
//                    Play.transform = CGAffineTransform.identity
//                    Info.transform = CGAffineTransform.identity
//
//                   Navi.isHidden = false
//                    Play.isHidden = false
//                    Info.isHidden = false
//
//                   Navi.frame = CGRect.init(x: touchpoint.x, y: touchpoint.y, width: 50, height: 50)
//                    Play.frame = CGRect.init(x: touchpoint.x, y: touchpoint.y, width: 50, height: 50)
//                    Info.frame = CGRect.init(x: touchpoint.x, y: touchpoint.y, width: 50, height: 50)
//                    Navi.alpha = 0.4
//                    Play.alpha = 0.4
//                    Info.alpha = 0.4
//                    UIView.animate(withDuration: 0.4, delay: 0,usingSpringWithDamping: 0.7, initialSpringVelocity: 2 ,options: [],animations: {
//                        self.Navi.transform = CGAffineTransform.init(translationX: -20, y: 0)
//                        self.Navi.alpha = 1
//                    })
//                    UIView.animate(withDuration: 0.4, delay: 0.05,usingSpringWithDamping: 0.7, initialSpringVelocity: 2 ,options: [],animations: {
//                        self.Info.transform = CGAffineTransform.init(translationX: -40, y: -40)
//                        self.Info.alpha = 1
//                    })
//                    UIView.animate(withDuration: 0.4, delay: 0.05,usingSpringWithDamping: 0.7, initialSpringVelocity: 2 ,options: [],animations: {
//                        self.Play.transform = CGAffineTransform.init(translationX: 0, y: 40)
//                        self.Play.alpha = 1
//                    })
                   // playVideo(url: URL(string: "http://yuokonw.oss-cn-shenzhen.aliyuncs.com/%E5%8A%B1%E5%BF%97%E5%88%B0%E7%88%86%E8%A1%A8%EF%BC%8C%E5%B0%8F%E7%B1%B35%E5%91%A8%E5%B9%B4%E6%84%9F%E6%81%A9%E8%A7%86%E9%A2%91%E2%80%94%E2%80%94%E5%A5%94%E8%B7%91%E5%90%A7%EF%BC%81%E5%85%84%E5%BC%9F_%E8%B6%85%E6%B8%85.mp4")!)
                    
                    

                //openweb(item: item.key)
                    
//                    let anno=LocationAnnotationNode(location: item.value.location, image: UIImage(named: "233")!)
//                    scenlocview.addLocationNodeWithConfirmedLocation(locationNode: anno)
                    
//                    let sb=UIStoryboard(name: "Mqain", bundle: nil)
//                  let nib=UINib(nibName: "button1", bundle: nil)
//                    let vc=sb.instantiateViewController(withIdentifier: "button_ar") as!button_ViewController
//                    let loc=LocationAnnotationNode(location: item.value.location, view:Navi)
//                    scenlocview.addLocationNodeWithConfirmedLocation(locationNode:loc )
                    
//                }
//            }
//        }
//    }
//    func playVideo(url: URL) {
//        let boxNode = SCNNode()
//        if let videoSize = rescouceManager.videoImage?.size {
//            var width: CGFloat = 2.0
//            if videoSize.width > videoSize.height {
//                width = 4.0
//            }
//            let height: CGFloat = CGFloat(width) * videoSize.height/videoSize.width
//            let box = SCNBox(width: width, height: height, length: 0.3, chamferRadius: 0)
//            boxNode.geometry = box
//            boxNode.geometry?.firstMaterial?.isDoubleSided = true
//            boxNode.position = SCNVector3Make(0, 0, -5)
//            box.firstMaterial?.diffuse.contents = UIColor.red
//            self.scene.rootNode.addChildNode(boxNode)
//
//            let avplayer = AVPlayer(url: url)
//            avplayer.volume = rescoucceConfiguration.video_isSilence ? 0.0 : 3.0
//            videoPlayer = avplayer
//            let videoNode = SKVideoNode(avPlayer: avplayer)
//            NotificationCenter.default.addObserver(self, selector: #selector(playEnd(notify:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
//            videoNode.size = CGSize(width: 1600, height: 900)
//            videoNode.position = CGPoint(x: videoNode.size.width/2, y: videoNode.size.height/2)
//            videoNode.zRotation = CGFloat(Float.pi)
//            let skScene = SKScene()
//            skScene.addChild(videoNode)
//            skScene.size = videoNode.size
//            box.firstMaterial?.diffuse.contents = skScene
//            videoNode.play()
//        }
//    }

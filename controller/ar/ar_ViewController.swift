//
//  ar_ViewController.swift
//  test2
//
//  Created by miaoz on 2019/2/20.
//  Copyright © 2019 miaoz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SpriteKit
import SceneKit
import ARKit
import SwiftyJSON

class ar_ViewController: UIViewController, ARSCNViewDelegate ,ARSKViewDelegate,choice_delgate{
    func clikedvalue(souce: String, tar: String) {
        self.tar=tar
        self.souce=souce
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let theSegue=segue.destination as! Language1VC
            theSegue.delegate=self
            theSegue.souce=self.souce
            theSegue.tar=self.tar
            theSegue.touch="souce"
    }
     let locationManager:CLLocationManager = CLLocationManager()
    var place_url:String="http://api.map.baidu.com/place/v2/search?query=银行&location=39.915,116.404&radius=2000&output=xml&ak=您的密钥"
    var googleAPIKey = Lautype_Apikey_date().googelAPIKey()
    var appid=Lautype_Apikey_date().BaiduAppid()
    var baidukey=Lautype_Apikey_date().baiduAPIKey()
    var requestdate:String!
    var translatedtext:String=""
    var imagett:UIImage!
    var tar:String="中文"
    var souce:String="英语"
    var placedict:JSON!
    var flo_y:Float!
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
    @IBOutlet weak var scenView: ARSCNView!
    var skview:ARSKView!
    var scene=SCNScene()
    var current:ARFrame!
    @IBAction func tran_touch(_ sender: Any) {
        let image=self.scenView.snapshot()
        current = scenView.session.currentFrame
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        createRequest(with: base64EncodeImage(image))
    }
    @IBAction func nearby_touch(_ sender: Any) {
    loadplace()
       /* let sphere = SCNSphere(radius: 15)
        let sphereNode = SCNNode(geometry: sphere)
        sphere.firstMaterial?.isDoubleSided = true
        sphere.firstMaterial?.diffuse.contents = UIImage(named: "151134460803-05-34-.jpg")
        sphereNode.position = SCNVector3Zero
        scenView.scene.rootNode.addChildNode(sphereNode)
 */
    }
    
    @IBAction func lauchage_touch(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
  
        var cx:Double!
        var cy:Double!
        LocationManager.shareManager.creatLocationManager().startLocation{(loc,adress,error)in
            cx=Double((loc?.coordinate.latitude)!)
            cy=Double((loc?.coordinate.longitude)!)
            self.loadpalce(adress: "\(1*cx),\(1*cy)",query: "饭店")
        }
        // Set the view's deleg
        scenView.delegate = self
        
        // Show statistics such as fps and timing information
        scenView.showsStatistics = true
        
        // Create a new scene
      // scene.rootNode.addChildNode(SCNScene(named: "art.scnassets/ship.scn")!)
        // Set the scene to the view
       //scenView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        scenView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        scenView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    func base64EncodeImage(_ image: UIImage) -> String {
        var imagedata = image.pngData()
        
        // Resize the image if it exceeds the 2MB API limit
        if (imagedata!.count > 2097152) {
            let oldSize: CGSize = image.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            
            // imagedata = resizeImage(newSize, image: image)
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
        self.draw(date: dict)
        self.translatedate(data: dict, to: self.lau_date[self.tar]!)
       
        //print(self.imagett.size.height,"/",self.imagett.size.width)
    }
}

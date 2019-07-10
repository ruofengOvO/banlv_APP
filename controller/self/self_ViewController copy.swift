//
//  self_ViewController.swift
//  temp1
//
//  Created by 韩梓健 on 2019/3/8.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
class self_ViewController: UIViewController,ARSCNViewDelegate ,ARSKViewDelegate{
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var MediumView: UIView!
    @IBOutlet weak var BottomView: UIScrollView!
    @IBOutlet weak var arview: ARSCNView!
    
    @IBOutlet weak var LocationLabel: UILabel!
    
    @IBAction func LoginBtn(_ sender: Any) {
    }
 
    @IBOutlet weak var FavorBtn: UIView!
    @IBOutlet weak var CashBtb: UIView!
    @IBOutlet weak var LogoutBtn: UIButton!
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var FavorView: UIButton!
    @IBOutlet weak var CashView: UIButton!
    @IBOutlet weak var Useremail: UILabel!
    @IBOutlet weak var Userimg: UIImageView!
    @IBAction func zhuxiao(_ sender: Any) {
        UserDefaults.standard.setValue("0", forKey: "tag")
    }
    override func viewWillLayoutSubviews() {
        LocationManager.shareManager.creatLocationManager().startLocation{(loc,adress,error)in
            if(error == nil){
                self.LocationLabel.text = adress
                self.LocationLabel.adjustsFontSizeToFitWidth=true
                self.LocationLabel.minimumScaleFactor=0.5
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        BottomView.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0.0)
        MediumView.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0.0)
        TopView.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0.0)
        CashView.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0.5)
        CashView.layer.cornerRadius = 16
        FavorView.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0.5)
        FavorView.layer.cornerRadius = 16
        CashBtb.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0.0)
        CashBtb.layer.cornerRadius = 16
        FavorBtn.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0.0)
        FavorBtn.layer.cornerRadius = 16
        LogoutBtn.backgroundColor = UIColor.red
        LogoutBtn.alpha = 0.8
        LogoutBtn.layer.cornerRadius = 16
         arview.delegate = self
        if (UserDefaults.standard.string(forKey: "tag") == "0"){
            CashView.isHidden = true
            FavorView.isHidden = true
            LoginBtn.isHidden = true
        }else{
            LoginBtn.isHidden = true
        }
        //arview.showsStatistics = true
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        arview.session.run(configuration)
        let sphere = SCNSphere(radius: 15)
        let sphereNode = SCNNode(geometry: sphere)
        sphere.firstMaterial?.isDoubleSided = true
        sphere.firstMaterial?.diffuse.contents = UIImage(named: "eaa9d478b372016cbbcef56484b82f83.jpg")
        sphereNode.position = SCNVector3Zero
        arview.scene.rootNode.addChildNode(sphereNode)
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       
        
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        arview.session.run(configuration)
    }
//    func Weather(){
//        self.LocationLabel.textColor = UIColor.white
//        self.WeatherImg.image = UIImage(named:"SunnyBack")
//        self.Sun.image = UIImage(named:"Sun")
//        UIView.animateKeyframes(withDuration: 5, delay: 0, options: .repeat, animations: {
//            self.Sun.transform = CGAffineTransform.identity.rotated(by:CGFloat (Double.pi/2))
//            self.Sun.transform = CGAffineTransform.identity
//        })
//
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

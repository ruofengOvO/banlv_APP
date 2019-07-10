//
//  PictranVC.swift
//  UIView
//
//  Created by 韩梓健 on 2019/3/3.
//  Copyright © 2019 韩梓健. All rights reserved.
//

import UIKit
import SwiftyJSON
import CommonCrypto
class PictranVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,choice_delgate {
    @IBOutlet weak var Onehand: NSLayoutConstraint!
    var tag=0
    var googleAPIKey = Lautype_Apikey_date().googelAPIKey()
    var appid=Lautype_Apikey_date().BaiduAppid()
    var baidukey=Lautype_Apikey_date().baiduAPIKey()
    var requestdate:String!
    var translatedtext:String=""
    var imagett:UIImage!
    var tar:String="中文"
    var souce:String="英语"
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
    
    
    
    
    
    
    
    
    //

    @IBAction func SelectLanguage(_ sender: Any) {
    }
    @IBOutlet weak var SelectLanguage: UIButton!
    
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var Image: UIImageView!
    @IBAction func CamAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5){
            self.TitleLabel.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: 180).rotated(by:CGFloat (Double.pi/2)).scaledBy(x: 0.2, y: 0.2)
            self.TitleLabel.alpha = 0
            self.Status.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: 180).rotated(by:CGFloat (Double.pi/2)).scaledBy(x: 0.2, y: 0.2)
            self.Status.alpha = 0
            self.FromCam.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
            self.FromGallary.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
            //self.TextView2.transform = CGAffineTransform.identity
            self.BackBtn.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: 160)
        }
        tag=1
        let imagepick=UIImagePickerController()
        imagepick.delegate=self
        imagepick.sourceType=UIImagePickerController.SourceType.camera
        self.present(imagepick, animated: true, completion:{
            ()->Void in
        })
    }
    @IBAction func GallAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5){
            self.TitleLabel.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: 180).rotated(by:CGFloat (Double.pi/2)).scaledBy(x: 0.2, y: 0.2)
            self.TitleLabel.alpha = 0
            self.Status.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: 180).rotated(by:CGFloat (Double.pi/2)).scaledBy(x: 0.2, y: 0.2)
            self.Status.alpha = 0
            self.FromCam.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
            self.FromGallary.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
            //self.TextView2.transform = CGAffineTransform.identity
            self.BackBtn.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: 160)
        }
        tag=1
        let imagepick=UIImagePickerController()
        imagepick.delegate=self
        imagepick.sourceType=UIImagePickerController.SourceType.photoLibrary
        self.present(imagepick, animated: true, completion:{
            ()->Void in
        })
        
    }
    @IBOutlet weak var FromGallary: UIButton!
    @IBOutlet weak var FromCam: UIButton!
    @IBAction func BackBtn(_ sender: Any) {
        if tag==1{
        let storybord=UIStoryboard(name: "Main", bundle: nil)
        let vc=storybord.instantiateViewController(withIdentifier: "pothotran")
            //self.dismiss(animated: true, completion: nil)
        self.present(vc, animated: true, completion: nil)
        }
        else if tag==0{
            let storybord=UIStoryboard(name: "Main", bundle: nil)
            let vc=storybord.instantiateViewController(withIdentifier: "Launch_iden") as! UITabBarController
            vc.selectedIndex=1
            self.present(vc, animated: true, completion: nil)
            //self.dismiss(animated: true, completion: nil)
        }else if tag==2{
            exit(0)
        }
        // self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var Onehand2: NSLayoutConstraint!
    
    func loaclized(){
        DispatchQueue.main.async {
            self.BackBtn.setTitle(NSLocalizedString("返回", comment: "back1") , for: .normal)
            self.SelectLanguage.setTitle(NSLocalizedString("选择语言", comment: "选择语言") , for: .normal)
            self.TitleLabel.text=NSLocalizedString("图片翻译", comment: "图片翻译")
            self.Status.text=NSLocalizedString("选择你需要的模式", comment: "选择你需要的模式")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loaclized()
        SelectLanguage.backgroundColor = UIColor.brown
        SelectLanguage.layer.cornerRadius = 16
        Onehand.constant = OnehandMode.OnehandMode()
        Onehand2.constant = OnehandMode.OnehandMode()
        self.Image.alpha = 0
        self.FromCam.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
        UIView.animate(withDuration: 1.2, delay: 0.5,usingSpringWithDamping: 0.7 , initialSpringVelocity: 2,options: [], animations:{
            self.FromCam.transform = CGAffineTransform.identity
        })
        self.FromGallary.transform = CGAffineTransform.init(scaleX: 0.55, y: 0.2)
        UIView.animate(withDuration: 1.2, delay: 0.05,usingSpringWithDamping: 0.7 , initialSpringVelocity: 2,options: [], animations:{
            self.FromGallary.transform = CGAffineTransform.identity
        })

        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PictranVC{
    func drawmao(rect:CGRect){
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = rect
        self.Image.addSubview(blurView)
        print("drawmaoed")
    }
    func drawtext(text:String,rect:CGRect){
        let label=UILabel()
        label.text=text
        label.backgroundColor=UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0)
        label.frame=rect
        label.adjustsFontSizeToFitWidth=true
        label.minimumScaleFactor=0.5
        self.Image.addSubview(label)
    }
    func screenShot() -> UIImage? {
        guard self.Image.frame.size.height > 0 && self.Image.frame.size.width > 0 else {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(self.Image.frame.size, false, 0)
        self.Image.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

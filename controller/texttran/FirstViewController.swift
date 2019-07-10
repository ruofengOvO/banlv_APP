//
//  FirstViewController.swift
//  test2
//
//  Created by miaoz on 2019/2/13.
//  Copyright © 2019 miaoz. All rights reserved.
//

import UIKit
import SwiftyJSON
import IQKeyboardManagerSwift

class FirstViewController: UIViewController,choice_delgate{
    let fx=BaseFx()
    @IBOutlet weak var Onehand: NSLayoutConstraint!
    @IBAction func BackBtn(_ sender: Any) {
        if tag==2{
            exit(0)
       }
//        let storybord=UIStoryboard(name: "Main", bundle: nil)
//        let vc=storybord.instantiateViewController(withIdentifier: "Launch_iden")
//        self.present(vc, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var Switcher: UIButton! //互换两个语言
    @IBAction func SwitcherAction(_ sender: Any) {
        UIView.animate(withDuration: 0.2){
            self.Switcher.transform = CGAffineTransform.identity.rotated(by: CGFloat(Double.pi))
            
        }
        self.Switcher.transform = CGAffineTransform.identity
        
        swap(&tar, &souce)
    }//Switcher的action
    //@IBOutlet weak var weather: UILabel!
    @IBOutlet weak var TranBtn: UIButton!
    @IBOutlet weak var tar_btn: UIButton!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var souce_btn: UIButton!
    @IBOutlet weak var before_text: UITextView!
    @IBOutlet weak var after_text: UITextView!
    var tag:Int=0
    var translatedtext:String!{
        didSet{
            DispatchQueue.main.async {
                self.after_text.text=self.translatedtext
            }
        }
    }
    var tar:String="中文"{
        didSet{
            DispatchQueue.main.async {
                self.tar_btn.setTitle(NSLocalizedString(self.tar, comment: "back1"), for: .normal)
                
            }
        }
    }
    var souce:String="英语"{
        didSet{
            DispatchQueue.main.async {
                self.souce_btn.setTitle(NSLocalizedString(self.souce, comment: "back1"), for: .normal)
            }
        }
    }
    var googleAPIKey = Lautype_Apikey_date().googelAPIKey()
    var appid=Lautype_Apikey_date().BaiduAppid()
    var baidukey=Lautype_Apikey_date().baiduAPIKey()
    let lau_date:[String:String]=Lautype_Apikey_date().Lau_date
    @IBOutlet weak var Onehan2: NSLayoutConstraint!
    @IBAction func tran_btn_touch(_ sender: Any) {
        UIView.animate(withDuration: 0.5){
            self.TitleLabel.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: 180).rotated(by:CGFloat (Double.pi/2)).scaledBy(x: 0.2, y: 0.2)
            self.TitleLabel.alpha = 0
            self.after_text.alpha = 1
            //self.TextView2.transform = CGAffineTransform.identity
            
        }
        translate1()
    }
    func loaclized(){
        DispatchQueue.main.async {
            self.souce_btn.setTitle(NSLocalizedString(self.souce, comment: "back1"), for: .normal)
            self.tar_btn.setTitle(NSLocalizedString(self.tar, comment: "back1"), for: .normal)
            self.BackBtn.setTitle(NSLocalizedString("返回", comment: "back1") , for: .normal)
            self.TranBtn.setTitle(NSLocalizedString("翻译", comment: "tran") , for: .normal)
           self.TitleLabel.text=NSLocalizedString("翻译", comment: "tran")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

      
        IQKeyboardManager.shared.enable = true
            before_text.backgroundColor=UIColor.init(displayP3Red: 1, green: 0.9725490, blue: 0.862745, alpha: 1)
        
        if (OnehandMode.OnehandMode()==50){
            Onehand.constant = OnehandMode.OnehandMode()+50
            Onehan2.constant = 2.0
        }
        before_text.layer.cornerRadius = 16
        after_text.backgroundColor=UIColor.init(displayP3Red: 1, green: 0.9725490, blue: 0.862745, alpha: 1)
        after_text.layer.cornerRadius = 16
        //TextView2.backgroundColor=UIColor.init(displayP3Red: 1, green: 0.9725490, blue: 0.862745, alpha: 1)
        //TextView2.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
        after_text.alpha = 0
        
        after_text.isEditable = false
        
        TranBtn.backgroundColor = UIColor.brown
        TranBtn.layer.cornerRadius = 16
        self.view.addGestureRecognizer(UITapGestureRecognizer(target:self,action:#selector(FirstViewController.handleTap(sender:))))
        
        
        DispatchQueue.main.async {
            //self.weather.text=get_weather().getwether()}
        self.tar_btn.setTitle(self.tar, for: .normal)
        self.souce_btn.setTitle(self.souce, for: .normal)
    }
        loaclized()
   
}
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended
        {
            before_text.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }

}

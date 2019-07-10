//
//  FuncSelecterVC.swift
//  UIView
//
//  Created by 韩梓健 on 2019/3/2.
//  Copyright © 2019 韩梓健. All rights reserved.
//

import UIKit

class FuncSelecterVC: UIViewController {
    let Snowing = SnowingEffect();
    let fx = BaseFx();
    @IBOutlet weak var bartitle: UITabBarItem!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var TabbarItem: UITabBarItem!
    @IBOutlet weak var ARBtn: UIButton!
    @IBOutlet weak var TomorrowBtn: UIButton!
    @IBOutlet weak var TextTranBtn: UIButton!
    @IBOutlet weak var PicTranBtn: UIButton!
    @IBOutlet weak var VoiceTranBtn: UIButton!
    @IBOutlet weak var Onehand: NSLayoutConstraint!
    @IBOutlet weak var Onehand2: NSLayoutConstraint!
    func loaclized(){
        DispatchQueue.main.async {
            self.titlelabel.text=NSLocalizedString("翻译与工具", comment: "翻译与工具")
           // self.bartitle.title = NSLocalizedString("翻译与工具", comment: "翻译与工具")
        }
        
    }
    override func
        viewDidLoad() {
        super.viewDidLoad()
        loaclized()
        Onehand.constant = OnehandMode.OnehandMode()
        Onehand2.constant = OnehandMode.OnehandMode()
        //Snowing.StarSnow(view: view)
        if (TextTranBtn.isSelected){
            TextTranBtn.setBackgroundImage(UIImage (imageLiteralResourceName: "TextTranBtnSelected"), for: UIControl.State.normal)
            //fx.Bigger(Button: TextTranBtn)
            
        }
        if (PicTranBtn.isSelected){
            PicTranBtn.setBackgroundImage(UIImage (imageLiteralResourceName: "PicTranBtnSelected"), for: UIControl.State.normal)
        }
        if (VoiceTranBtn.isSelected){
            VoiceTranBtn.setBackgroundImage(UIImage (imageLiteralResourceName: "VoiceTranBtnSelected"), for: UIControl.State.normal)
        }
        self.TextTranBtn.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
        
        self.PicTranBtn.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
        self.VoiceTranBtn.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
        self.ARBtn.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
        self.TomorrowBtn.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
        UIView.animate(withDuration: 0.8, delay: 0.0,usingSpringWithDamping: 0.7 , initialSpringVelocity: 2,options: [], animations:{
            self.TextTranBtn.transform = CGAffineTransform.identity
        })
        UIView.animate(withDuration: 0.8, delay: 0.05,usingSpringWithDamping: 0.7 , initialSpringVelocity: 2,options: [], animations:{
            self.PicTranBtn.transform = CGAffineTransform.identity
        })
        UIView.animate(withDuration: 0.8, delay: 0.1,usingSpringWithDamping: 0.7 , initialSpringVelocity: 2,options: [], animations:{
            self.VoiceTranBtn.transform = CGAffineTransform.identity
        })
        UIView.animate(withDuration: 0.8, delay: 0.15,usingSpringWithDamping: 0.7 , initialSpringVelocity: 2,options: [], animations:{
            self.ARBtn.transform = CGAffineTransform.identity
        })
        UIView.animate(withDuration: 0.8, delay: 0.2,usingSpringWithDamping: 0.7 , initialSpringVelocity: 2,options: [], animations:{
            self.TomorrowBtn.transform = CGAffineTransform.identity
        })
        TabbarItem.badgeColor = UIColor.brown
        
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

//
//  imageandtext.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/16.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
class imageandtext:UIViewController, UIScrollViewDelegate{
    @IBOutlet weak var lll: UIActivityIndicatorView!
    @IBOutlet weak var maintext: UITextView!
    @IBOutlet weak var titletext: UITextView!
    @IBOutlet weak var back: UIButton!
   
    //@IBOutlet weak var cllocetvvv: UICollectionView!
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var Pic: UIView!
    @IBAction func backon(_ sender: Any) {
        Thread.sleep(forTimeInterval: 0.5)
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        lll.alpha=0
        lll.startAnimating()
        self.maintext.layer.borderColor = UIColor(red: 60/255, green: 40/255, blue: 129/255, alpha: 1).cgColor;
        
        self.maintext.layer.borderWidth = 2;
        
        self.maintext.layer.cornerRadius = 16;
        let vc = PictureViewController()
        self.addChild(vc)
        back.alpha = 0.6
        //let viewt =   vc.pictureCollectonView
       vc.view.frame=Pic.frame
        Pic.addSubview(vc.pictureCollectonView)
        vc.pictureCollectonView.backgroundColor=UIColor.white
        IQKeyboardManager.shared.enable = true
        super.viewDidLoad()
    }
}
//
//        scroll.frame = self.view.frame
//
//        topView.backgroundColor = UIColor.green
//
//        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
//        imageView?.image = image
//
//        imageView?.contentMode = UIView.ContentMode.scaleAspectFill
//
//        topView.addSubview(imageView!)
//
//        var st=view.frame.width
//
//        label = UILabel(frame: CGRect(x: 10, y: 50, width: st-20, height: 50))
//        label?.numberOfLines = 0
//        label?.text = "课程描述：UIKit框架是iPhone应用程序开发中最基本的框架，也是用得最多、最重要的框架，从名字我们就能理解是界面相关操作组件集合。本套课程系统全面的学习iOS界面组件UIKit，不但熟悉各个界面组件操作，更重要的是深入浅出的理解原理，实在是市面不可多得的iOS界面教学课程。"
//        label?.font = UIFont.systemFont(ofSize: 16)
//
//        scroll.addSubview(topView)
//
//
//        var labelHeight = label?.frame.height
//        var topHeight = imageView?.frame.height
//        print("\(labelHeight), \(topHeight)")
//
//        scroll.contentSize = CGSize(width: self.view.frame.width, height: labelHeight!+topHeight!)
//        scroll.addSubview(label!)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//
//    }
//}

//
//  palcefrtail_viewcontroller.swift
//  temp1
//
//  Created by 韩梓健 on 2019/3/7.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import UIKit
import  WebKit
class palcefrtail_viewcontroller: UIViewController {

    @IBOutlet weak var BackBtn: UIButton!
    @IBAction func BackBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            self.BackBtn.transform = CGAffineTransform.identity.rotated(by:CGFloat (Double.pi))
            self.BackBtn.transform = CGAffineTransform.identity
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBOutlet weak var webview: WKWebView!
    
    @IBOutlet weak var test: UILabel!
    var type:String=""
    var urlstring:String=""
    override func viewDidLoad() {
        super.viewDidLoad()
        BackBtn.alpha = 0.6
        print(urlstring)
        self.webview.load(URLRequest(url: URL(string:urlstring)!))
        self.test.text=self.type
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

//
//  iamgepicViewController.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/17.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import UIKit
class iamgepicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let vc = PictureViewController()
        self.addChild(vc)
        //self.view.frame = vc.view.frame
        self.view.addSubview(vc.pictureCollectonView)
        
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

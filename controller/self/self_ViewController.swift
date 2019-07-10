//
//  self_ViewController.swift
//  temp1
//
//  Created by 韩梓健 on 2019/3/8.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import UIKit
class self_ViewController: UIViewController {

    @IBAction func zhuxiao(_ sender: Any) {
        UserDefaults.standard.setValue("0", forKey: "tag")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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

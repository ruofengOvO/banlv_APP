//
//  sugestViewController.swift
//  temp1
//
//  Created by miaoz on 2019/3/21.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import UIKit

class sugestViewController: UIViewController {

    @IBOutlet weak var bartitle: UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        bartitle.title = NSLocalizedString("推荐与周边", comment: "推荐与周边")

        
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

//
//  Tabbar_ViewController.swift
//  temp1
//
//  Created by 韩梓健 on 2019/3/6.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import UIKit

class Tabbar_ViewController: UITabBarController {

    @IBOutlet weak var tabbar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        tabbar.items?.first!.title = NSLocalizedString("推荐与周边", comment: "推荐与周边")
        tabbar.items?[1].title = NSLocalizedString("翻译与工具", comment: "翻译与工具")
        tabbar.items?[2].title = NSLocalizedString("个人与收藏", comment: "个人与收藏")
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

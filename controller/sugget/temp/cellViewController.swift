//
//  cellViewController.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/3.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import UIKit

@objc(cellViewController) class cellViewController: UIViewController {

    @IBOutlet var cell: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
     override func awakeFromNib() {
        let label=self.cell.viewWithTag(1001) as!UILabel
        label.text="123"
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

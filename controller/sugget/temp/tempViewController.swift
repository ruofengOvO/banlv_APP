//
//  tempViewController.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/3.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import UIKit

class tempViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    let lau_viewdate:[String]=["as","as"]
    @IBOutlet weak var tabelview: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lau_viewdate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "tabelcell", for: indexPath)
        let label=cell.viewWithTag(1001) as! UILabel
        label.text=lau_viewdate[indexPath.row]
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabelview.delegate=self
        self.tabelview.dataSource=self
        self.tabelview.allowsSelection=false

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


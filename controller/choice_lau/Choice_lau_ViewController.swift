//
//  Choice_lau_ViewController.swift
//  test2
//
//  Created by miaoz on 2019/2/14.
//  Copyright © 2019 miaoz. All rights reserved.
//
//
//import UIKit
//protocol choice_delgate {
//    func clikedvalue(souce: String, tar: String)
//}
//class Choice_lau_ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
//    @IBOutlet weak var segmented_control: UISegmentedControl!
//    @IBOutlet weak var tableview: UITableView!
//    var delegate:choice_delgate?
//    var souce:String!
//    var tar:String!
//    var touch:String!
//    let lau_date=["英语":"en","中文":"zh","俄语":"de"]
//    let lau_viewdate:[String]=Lautype_Apikey_date.Lau_type_date
//    
//    
//    @IBAction func choice_lau_changed(_ sender: Any) {
//        if self.touch=="tar"
//        {
//            self.touch="souce"
//        }
//        else{
//            self.touch="tar"
//        }
//    }
//    @IBAction func cell_touch(_ sender: Any) {
//        let btn=sender as!UIButton
//        let cell=btn.superView(of: UITableViewCell.self)!
//        let label=cell.viewWithTag(100)as! UILabel
//        if self.touch=="tar"
//        {
//            self.tar=label.text
//            print(1)
//        }
//        else{
//            self.souce=label.text
//            print(2)
//        }
//        delegate?.clikedvalue(souce: self.souce, tar: self.tar)
//        self.dismiss(animated: true, completion: nil)
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if self.touch == "tar"{
//        self.segmented_control.selectedSegmentIndex=1
//        }
//        self.tableview.delegate=self
//        self.tableview.dataSource=self
//        self.tableview.allowsSelection=false
//    }
//
//}
//

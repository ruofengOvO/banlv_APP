//
//  speechtranslate+tabelview.swift
//  test2
//
//  Created by miaoz on 2019/2/17.
//  Copyright © 2019 miaoz. All rights reserved.
//

import Foundation
import  UIKit
extension speeh_text_ViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trandatedict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempdate=trandatedict[indexPath.row]
        var tag:Int=210
        var cell:UITableViewCell!
        if tempdate.type=="before"{
            cell=tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        }
        else{
            cell=tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            tag=tag+10
        }
        let textview1=cell.viewWithTag(tag+1)as! UILabel
       // let textview2=cell.viewWithTag(tag+2)as! UITextView
        
        let tag1:Int = 1024
        if tempdate.type=="after"
        {
            let View2 = cell.viewWithTag(tag1+1) as! UIView
           // textview2.textAlignment = .right
            textview1.textAlignment = .right
            //textview1.layer.cornerRadius = 16
            View2.backgroundColor = UIColor.init(displayP3Red: 0.529411, green: 0.807843, blue: 0.980392, alpha: 0.5)
            View2.layer.cornerRadius = 16
        }else{
            let View1 = cell.viewWithTag(tag1) as! UIView
            View1.backgroundColor = UIColor.init(displayP3Red: 1, green: 0.627450, blue: 0.478431, alpha: 0.5)
            View1.layer.cornerRadius = 16
            //textview1.layer.cornerRadius = 16
        }
        textview1.numberOfLines=0
        //textview1.lineBreakMode=UILineBreakModeCharacterWrap
        textview1.text=tempdate.before_text+"\n"+" "+tempdate.after_text
        textview1.adjustsFontSizeToFitWidth=true
        textview1.minimumScaleFactor=0.5
       // textview2.text=tempdate.after_text
        return cell
    }
}

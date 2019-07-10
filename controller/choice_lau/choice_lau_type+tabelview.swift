//
//  choice_lau_type+tabelview.swift
//  test2
//
//  Created by miaoz on 2019/2/17.
//  Copyright © 2019 miaoz. All rights reserved.
//

import Foundation
import UIKit
extension Language1VC{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lau_viewdate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let label=cell.viewWithTag(100) as! UILabel
        let btn=cell.viewWithTag(520) as! UIButton
        btn.setTitle(NSLocalizedString("选择", comment: "选择"), for: .normal)
        label.text=NSLocalizedString(lau_viewdate[indexPath.row], comment: lau_viewdate[indexPath.row])
        return cell
    }
}

//
//  tempTableViewCell.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/3.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import UIKit

class tempTableViewCell: TestTableViewCell {
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.label.layer.cornerRadius=8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

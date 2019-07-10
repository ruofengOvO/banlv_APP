//
//  photoTranslate+protrol+segue.swift
//  test2
//
//  Created by miaoz on 2019/2/17.
//  Copyright © 2019 miaoz. All rights reserved.
//

import Foundation
import  UIKit
extension PictranVC{
    func clikedvalue(souce: String, tar: String) {
        self.souce=souce
        self.tar=tar
        print(souce+"..."+tar)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let theSegue=segue.destination as! Language1VC
        theSegue.delegate=self
        theSegue.souce=self.souce
        theSegue.tar=self.tar
        theSegue.touch="souce"
    }
}

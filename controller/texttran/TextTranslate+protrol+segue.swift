//
//  TextTranslate+protrol+segue.swift
//  test2
//
//  Created by miaoz on 2019/2/17.
//  Copyright © 2019 miaoz. All rights reserved.
//

import Foundation
import  UIKit

extension FirstViewController{
    func clikedvalue(souce: String, tar: String) {
        self.souce=souce
        self.tar=tar
        print(souce+"..."+tar)
//        self.tar_btn.setTitle(self.tar, for: .normal)
//        self.souce_btn.setTitle(self.souce, for: .normal)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="souce_touch"
        {
            let theSegue=segue.destination as! Language1VC
            theSegue.delegate=self
            theSegue.souce=self.souce
            theSegue.tar=self.tar
            theSegue.touch="souce"
        }
        if segue.identifier=="tar_touch"
        {
            let theSegue=segue.destination as! Language1VC
            theSegue.delegate=self
            theSegue.souce=self.souce
            theSegue.tar=self.tar
            theSegue.touch="tar"
        }
    }
}

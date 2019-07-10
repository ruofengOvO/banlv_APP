//
//  UserInfo.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/3.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import Foundation
class UserInfo{
    var userID:String?
    var userName:String?
    var userPassword:String?
    var userTel:String?
    var userEmail:String?
    var userCredit:String?
    var userState:String?
    
    
init(userID:String,userName:String,userPassword:String,userTel:String,userEmail:String,userCredit:String,userState:String)
    {
    self.userID=userID
        self.userName=userName
        self.userPassword=userPassword
        self.userTel=userTel
        self.userEmail=userEmail
        self.userCredit=userCredit
        self.userState=userState
    }
    
    
    
}

//
//  ConnectSQL.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/14.
//  Copyright © 2019 Rohlf W. All rights reserved.
//

import Foundation
import OHMySQL



class ConnectSQL {
    var coordinator  = OHMySQLStoreCoordinator()
    let context = OHMySQLQueryContext()
    
    let dbName = "banlv"//数据库模块名称
    
    var tableName = "Article"//表名
     
    ///MySQL Server
    
    let SQLUserName = ""//数据库用户名
    
    let SQLPassword = ""//数据库密码
    
    
    let SQLServerName = ""
    
    let SQLServerPort: UInt = 3306//数据库端口号，默认是3306
    
    func Conected(){
        let user = OHMySQLUser(userName: SQLUserName, password: SQLPassword, serverName: SQLServerName, dbName: dbName, port: SQLServerPort, socket: nil) //mac本地socket为/tmp/mysql.sock，远程连接socket直接为nil即可
        coordinator = OHMySQLStoreCoordinator(user: user!)
        
        coordinator.encoding = .UTF8//编码方式
        
        coordinator.connect()//连接数据库
        //判断是否成功数据库
        
        let sqlConnected: Bool = coordinator.isConnected
        if sqlConnected {
            print("数据库连接成功...枸杞泡咖啡爱你...")
            
        }
        
        //连接成功后保存协调器到当前的上下文，即可不用每次操作数据库都要重新连接
        
        context.storeCoordinator = coordinator
        
    }
    
    func Closed(){
        coordinator.disconnect()//与数据库断开连接
    }
    
}

    //查询
//    let query = OHMySQLQueryRequestFactory.select("Text", condition: "id = 33")
//do{
//    //INSERT - 增
//
//    let query2 = OHMySQLQueryRequestFactory.insert("Text", set: ["text":"nihao!!","pics": imagedata, "id": 33])
//
//    //DELETE - 删
//
//    //let query3 = OHMySQLQueryRequestFactory.delete(tableName, condition: "username = 'amberoot'")
//
//    //UPDATE - 改
//
//    // let query4 = OHMySQLQueryRequestFactory.update(tableName, set: ["password": "10000"], condition: "username = 'amberoot2'")
//    try context.execute(query2)
//
//    let response = try context.executeQueryRequestAndFetchResult(query)
//    //print(response)
//    // print( NSString(data: response.first!["text"] as! Data, encoding:)
//    // try context.execute(query3)
//    // try context.execute(query4)
//
//}catch{
//    print("MySQL_Error:\(error)")
//}


//
//  AccountService.swift
//  foodOrderApp
//
//  Created by sean on 2018/4/3.
//  Copyright © 2018年 NAsoftware. All rights reserved.
//

import Foundation

class AccountService {
    class func login(account: String, password: String, callBack:@escaping (String) -> Void) {
        FOSNetworking.get(url: FOSNetworking.address, paras: ["command": "login",
                                                              "account": account,
                                                              "password": password]
            ,success: {(result) in
                if let value = result {
                    print("================================ 登陆成功 ================================")
                    callBack(value["result"] as! String)
                }
        }, failture: { (errorDescription) in
            print("================================ 登陆失败 ================================")
            callBack(errorDescription)
        })
    }
    
    class func signUp(account: String, password: String, callBack:@escaping (String) -> Void) {
        FOSNetworking.get(url: FOSNetworking.address, paras: ["command": "signUp",
                                                              "account": account,
                                                              "password": password]
            ,success: {(result) in
                if let value = result {
                    print("================================ 注册成功 ================================")
                    callBack(value["result"] as! String)
                }
        }, failture: { (errorDescription) in
            print("================================ 注册失败 ================================")
            callBack(errorDescription)
        })
    }
}

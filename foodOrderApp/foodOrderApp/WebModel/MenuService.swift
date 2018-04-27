//
//  MenuService.swift
//  foodOrderApp
//
//  Created by sean on 4/11/18.
//  Copyright © 2018 NAsoftware. All rights reserved.
//

import Foundation

class MenuService {
    class func getMenu(account: String, callBack:@escaping ([String: String]) -> Void) {
        FOSNetworking.get(url: FOSNetworking.address, paras: ["command": "getMenu",
                                                              "account": account]
            ,success: {(result) in
                if let value = result as? Dictionary<String, String> {
                    print("================================ 获取菜单成功 ================================")
                    callBack(value)
                }
        }, failture: { (errorDescription) in
            print("================================ 获取菜单失败 ================================")
            callBack(["error": errorDescription])
        })
    }
    
    class func addMenuItem(account: String, foodName: String, price: String, callBack:@escaping (String) -> Void) {
        FOSNetworking.get(url: FOSNetworking.address, paras: ["command": "addMenuItem",
                                                              "account": account,
                                                              "itemName": foodName,
                                                              "itemPrice": price]
            ,success: {(result) in
                if result!["error"]! as! String == "0" {
                    print("================================ 添加菜单项成功 ================================")
                    callBack("success")
                } else {
                    print("================================ 添加菜单项失败 ================================")
                    callBack(result!["error"]! as! String)
                }
        }) { (errorDescription) in
            print("================================ 添加菜单项失败 ================================")
            callBack(errorDescription);
        }
    }
    
    class func removeMenuItem(account: String, foodName: String, callBack:@escaping (String) -> Void) {
        FOSNetworking.get(url: FOSNetworking.address, paras: ["command": "removeMenuItem",
                                                              "account": account,
                                                              "itemName": foodName]
            , success: { (result) in
                if result!["error"]! as! String == "0" {
                    print("================================ 移除菜单项成功 ================================")
                    callBack("success")
                } else {
                    print("================================ 移除菜单项失败 ================================")
                    callBack(result!["error"]! as! String)
                }
        }) { (errorDescription) in
            print("================================ 移除菜单项失败 ================================")
            callBack(errorDescription)
        }
    }
}

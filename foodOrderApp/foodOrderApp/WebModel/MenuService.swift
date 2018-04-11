//
//  MenuService.swift
//  foodOrderApp
//
//  Created by sean on 4/11/18.
//  Copyright © 2018 NAsoftware. All rights reserved.
//

import Foundation

class MenuService {
    class func getMenu(account: String, callBack:@escaping ([(String, String)]) -> Void) {
        FOSNetworking.get(url: FOSNetworking.address, paras: ["command": "getMenu",
                                                              "account": account]
            ,success: {(result) in
                if let value = result {
                    print("================================ 获取菜单成功 ================================")
                    print(value)
                }
        }, failture: { (errorDescription) in
            print("================================ 获取菜单失败 ================================")
        })
    }
}

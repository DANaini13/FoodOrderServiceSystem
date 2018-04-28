//
//  OrderService.swift
//  foodOrderApp
//
//  Created by sean on 4/27/18.
//  Copyright © 2018 NAsoftware. All rights reserved.
//

import Foundation

struct OrderItem {
    let foodName:String
    let number:Int
}

class OrderService
{
    class func orderFoods(account:String, foods:[String], tableNumber:Int, callBack:@escaping (String) -> Void) {
        var order:[String:String] = [:]
        for x in foods {
            if(order[x] != nil) {
                order[x]! = "\(Int(order[x]!)! + 1)"
            }else {
                order[x] = "1"
            }
        }
        order["tableNumber"] = "\(tableNumber)"
        order["account"] = account
        order["command"] = "orderFood"
        FOSNetworking.get(url: FOSNetworking.address, paras: order
            ,success: {(result) in
            print("================================ 发送订单成功 ================================")
            callBack("success")
        }, failture: { (errorDescription) in
            print("================================ 发送订单失败 ================================")
            callBack(errorDescription)
        })
    }
}

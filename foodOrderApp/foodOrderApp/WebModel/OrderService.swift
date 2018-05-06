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
    
    class func registerOrderChecker(account:String, callBack:@escaping ([(String, String)]) -> Void) {
        var buffer:[(String, String)] = []
        DispatchQueue.global(qos: .utility).async {
            while(true) {
                FOSNetworking.get(url: FOSNetworking.address, paras: ["account": account,
                                                                      "command": "checkOrder"]
                    ,success: {(result) in
                        print("================================ 已刷新订单信息 ================================")
                        if result!["error"]! as! String == "0" {
                            buffer = []
                            for x in result! {
                                if(x.key == "error") {
                                    continue
                                }
                                let parts = x.key.components(separatedBy: "+")
                                let name = parts[1]
                                let table = parts[0]
                                let rightParts = (x.value as! String).components(separatedBy: "+")
                                let time = rightParts[1]
                                let number = rightParts[0]
                                let ready = rightParts[2]
                                let value = table + "+" + time + "+" + number + "+" + ready
                                buffer.append((name, value))
                            }
                            callBack(buffer)
                        }
                }, failture: { (errorDescription) in
                    print("================================ 新订单信息失败 ================================")
                })
                sleep(3)
            }
        }
    }
    
    class func registerOrderStatusChecker(account: String, table:String, callBack:@escaping ([(String, String)]) -> Void) {
        var buffer:[(String, String)] = []
        DispatchQueue.global(qos: .utility).async {
            while(true) {
                FOSNetworking.get(url: FOSNetworking.address, paras: ["account": account,
                                                                      "command": "checkOrderStatus",
                                                                      "table": table]
                    ,success: {(result) in
                        print("================================ 已刷新订单状态 ================================")
                        buffer = []
                        for x in result! {
                            let name = x.key;
                            let finished = x.value;
                            buffer.append((name, finished as! String))
                        }
                        callBack(buffer)
                }, failture: { (errorDescription) in
                    print("================================ 新订单状态失败 ================================")
                })
                sleep(3)
            }
        }
    }
    
    class func finishFood(account: String, table: String, foodName: String, callBack:@escaping (String) -> Void) {
        FOSNetworking.get(url: FOSNetworking.address, paras: ["account": account,
                                                              "command": "finishedFood",
                                                              "table": table,
                                                              "foodName": foodName]
            ,success: {(result) in
                print("================================ 更新了订单 ================================")
                callBack(result!["result"] as! String)
        }, failture: { (errorDescription) in
            print("================================ 更新订单失败 ================================")
        })
    }
}

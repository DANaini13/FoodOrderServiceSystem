//
//  WebInfo.swift
//  foodOrderApp
//
//  Created by sean on 2018/4/3.
//  Copyright © 2018年 NAsoftware. All rights reserved.
//

import Foundation
import AFNetworking

let address:String = "http://localhost:8888"

class FOSNetworking {
    class func get(url: String, paras: Dictionary<String, Any?>?,
                   success: (Dictionary<String, Any?>?) -> Void,
        failture:(String) -> Void){
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.get(url, parameters: paras, success: {
            (operation: URLSessionTask, resopnseObj: Any?) in
            print("JSON: " + resopnseObj.debugDescription)
            let value = resopnseObj! as? Dictionary<String, Any>
            print(value)
        }, failure:{
            (operation: URLSessionDataTask?, error: Error) in
                print(error.localizedDescription)
                print("falied!")
        })
    }
}

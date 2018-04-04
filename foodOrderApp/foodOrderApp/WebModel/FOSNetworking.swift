//
//  WebInfo.swift
//  foodOrderApp
//
//  Created by sean on 2018/4/3.
//  Copyright © 2018年 NAsoftware. All rights reserved.
//

import Foundation
import AFNetworking

class FOSNetworking {
    static let address:String = "http://localhost:8888"
    
    class func get(url: String, paras: Dictionary<String, Any?>?,
                   success: @escaping (Dictionary<String, Any?>?) -> Void,
                   failture:@escaping (String) -> Void){
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.get(url, parameters: paras, success: {
            (operation: URLSessionTask, resopnseObj: Any?) in
            if let value = resopnseObj! as? Dictionary<String, Any> {
                print("JSON: " + "\(value)")
                success(value)
            }else{
                print("JSON parse error!!!")
            }
        }, failure:{
            (operation: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
            failture(error.localizedDescription)
        })
    }
}

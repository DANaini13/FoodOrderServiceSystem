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

class FOSNetworking : NSObject {
    class func get(url: String, parameters: Dictionary<String, Any?>?,
                   success: (Dictionary<String, Any?>?) -> Void,
        failture:(String) -> Void){
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html") as! Set<String>
        manager.get(url, parameters: parameters, success: {
            (operation: URLSessionTask, resopnseObj: Any?) in
            print(resopnseObj)
            print(resopnseObj as? Dictionary<String, Any?>)
        }, failure:{
            (operation: URLSessionDataTask?, error: Error) in
                print(error.localizedDescription)
                print("falied!")
        })
    }
}

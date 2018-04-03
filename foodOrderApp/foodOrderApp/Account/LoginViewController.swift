//
//  ViewController.swift
//  foodOrderApp
//
//  Created by NA-Sean on 3/22/18.
//  Copyright © 2018 NAsoftware. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak private var accountPlaceHolder: UITextField!
    @IBOutlet weak private var passwordPlaceHolder: UITextField!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction private func touchedLogin(_ sender: UIButton) {
        FOSNetworking.get(url: address, paras: ["test": "lol"], success: {
            (result: Dictionary<String, Any?>?) in
            print(result)
        }, failture: {(reason: String) in
            print(reason)
        })
        guard accountPlaceHolder.text != nil && passwordPlaceHolder.text != nil  else {
            return
        }
        let account = accountPlaceHolder.text!
        let password = passwordPlaceHolder.text!
        
    }
    

    
}


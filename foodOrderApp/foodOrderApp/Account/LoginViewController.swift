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
        guard accountPlaceHolder.text != "" && passwordPlaceHolder.text != ""  else {
            let alertController = UIAlertController(title: "login failed!", message: "plase fill out the account and password!", preferredStyle: .alert)
            let okAcount = UIAlertAction(title: "Ok", style: .cancel, handler: {
                action in
            })
            alertController.addAction(okAcount)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let account = accountPlaceHolder.text!
        let password = passwordPlaceHolder.text!
        AccountService.login(account: account, password: password, callBack: { (result) in
            if result == "success" {
                self.performSegue(withIdentifier: "mainSection", sender: self)
            }else {
                let alertController = UIAlertController(title: "login failed!", message: result, preferredStyle: .alert)
                let okAcount = UIAlertAction(title: "Ok", style: .cancel, handler: {
                    action in
                })
                alertController.addAction(okAcount)
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
    
    
    
}


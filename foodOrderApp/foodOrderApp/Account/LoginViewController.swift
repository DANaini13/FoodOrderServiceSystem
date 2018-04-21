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
        let accountTemp = UserDefaults.standard.string(forKey: "account")
        let passwordTemp = UserDefaults.standard.string(forKey: "password")
        if let account = accountTemp, let password = passwordTemp {
            AccountService.login(account: account, password: password, callBack: { (result) in
                if result == "success" {
                    self.performSegue(withIdentifier: "mainSection", sender: self)
                }else {
                    let alertController = UIAlertController(title: "自动登录失败！请手动登录", message: result, preferredStyle: .alert)
                    let okAcount = UIAlertAction(title: "好吧", style: .cancel, handler: {
                        action in
                    })
                    alertController.addAction(okAcount)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction private func touchedLogin(_ sender: UIButton) {
        guard accountPlaceHolder.text != "" && passwordPlaceHolder.text != ""  else {
            let alertController = UIAlertController(title: "登录失败", message: "请填写账号密码", preferredStyle: .alert)
            let okAcount = UIAlertAction(title: "好的", style: .cancel, handler: {
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
                UserDefaults.standard.set(account, forKey: "account")
                UserDefaults.standard.set(password, forKey: "password")
                self.performSegue(withIdentifier: "mainSection", sender: self)
            }else {
                let alertController = UIAlertController(title: "登录失败", message: result, preferredStyle: .alert)
                let okAcount = UIAlertAction(title: "好的", style: .cancel, handler: {
                    action in
                })
                alertController.addAction(okAcount)
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
    
    
    
}


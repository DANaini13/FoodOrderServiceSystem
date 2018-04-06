//
//  RegisterViewController.swift
//  foodOrderApp
//
//  Created by sean on 3/28/18.
//  Copyright © 2018 NAsoftware. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak private var accountPlaceHolder: UITextField!
    @IBOutlet weak private var passwordPlaceHolder: UITextField!
    @IBOutlet weak private var confrimPlaceHolder: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction private func touchedRegister(_ sender: UIButton) {
        guard accountPlaceHolder.text != "" && passwordPlaceHolder.text != "" && confrimPlaceHolder.text != "" else {
            let alertController = UIAlertController(title: "sign up failed!", message: "plase fill out the account and password!", preferredStyle: .alert)
            let okAcount = UIAlertAction(title: "Ok", style: .cancel, handler: {
                action in
            })
            alertController.addAction(okAcount)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard passwordPlaceHolder.text == confrimPlaceHolder.text else {
            let alertController = UIAlertController(title: "sign up failed!", message: "password does not match the confrimation!", preferredStyle: .alert)
            let okAcount = UIAlertAction(title: "Ok", style: .cancel, handler: {
                action in
            })
            alertController.addAction(okAcount)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if let account = accountPlaceHolder.text, let password = passwordPlaceHolder.text {
            AccountService.signUp(account: account, password: password) { (result) in
                if result == "success" {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    let alertController = UIAlertController(title: "sign up failed!", message: result, preferredStyle: .alert)
                    let okAcount = UIAlertAction(title: "Ok", style: .cancel, handler: {
                        action in
                    })
                    alertController.addAction(okAcount)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
    
}

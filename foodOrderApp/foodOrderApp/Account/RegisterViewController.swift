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
        guard accountPlaceHolder.text != nil else {
            return
        }
        guard passwordPlaceHolder.text == confrimPlaceHolder.text && confrimPlaceHolder.text != nil else {
            return
        }
    }
    
}

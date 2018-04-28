//
//  ManagerViewController.swift
//  foodOrderApp
//
//  Created by sean on 4/28/18.
//  Copyright © 2018 NAsoftware. All rights reserved.
//

import UIKit

class ManagerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableNumberTextField: UITextField!
    
    @IBAction func touchGuest(_ sender: UIButton) {
        if tableNumberTextField.text! == "" {
            let alertController = UIAlertController(title:"信息不完整", message:"请工作人员填写食客餐桌号！", preferredStyle: .alert)
            let okAcount = UIAlertAction(title: "我知道了", style: .cancel, handler: {
                action in
            })
            alertController.addAction(okAcount)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if let _ = Int(tableNumberTextField.text!){
            UserDefaults.standard.set(tableNumberTextField.text!, forKey: "table")
            self.performSegue(withIdentifier: "costumer", sender: self)
        }else {
            let alertController = UIAlertController(title:"信息有问题", message:"请填写餐桌号对应的数字！", preferredStyle: .alert)
            let okAcount = UIAlertAction(title: "我知道了", style: .cancel, handler: {
                action in
            })
            alertController.addAction(okAcount)
            self.present(alertController, animated: true, completion: nil)
            return
        }
    }
}

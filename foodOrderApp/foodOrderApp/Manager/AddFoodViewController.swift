//
//  AddFoodViewController.swift
//  foodOrderApp
//
//  Created by sean on 4/7/18.
//  Copyright © 2018 NAsoftware. All rights reserved.
//

import UIKit

class AddFoodViewController: UIViewController {

    @IBOutlet weak var foodNameTextField: UITextField!
    @IBOutlet weak var foodPriceTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchAdd(_ sender: UIButton) {
        guard foodNameTextField.text != "" && foodPriceTextField.text != "" else {
            let alertController = UIAlertController(title: "添加失败", message: "请填写食物价格和名字", preferredStyle: .alert)
            let okAcount = UIAlertAction(title: "好的", style: .cancel, handler: {
                action in
            })
            alertController.addAction(okAcount)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let accountTemp = UserDefaults.standard.string(forKey: "account")
        print(foodNameTextField.text!)
        MenuService.addMenuItem(account: accountTemp!, foodName: foodNameTextField.text!, price: foodPriceTextField.text!) { (result) in
            
        }
    }
    
}

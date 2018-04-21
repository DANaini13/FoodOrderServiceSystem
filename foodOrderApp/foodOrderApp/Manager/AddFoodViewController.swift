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
        MenuService.addMenuItem(account: accountTemp!, foodName: foodNameTextField.text!, price: foodPriceTextField.text!) { [weak self] (result) in
            if result == "success" {
                if let food = self!.foodNameTextField.text, let price = self!.foodPriceTextField.text {
                    let alertController = UIAlertController(title: "添加成功", message: "菜单项：\(food)  价格：\(price)", preferredStyle: .alert)
                    let okAcount = UIAlertAction(title: "好的", style: .cancel, handler: {
                        action in
                    })
                    alertController.addAction(okAcount)
                    self?.present(alertController, animated: true, completion: nil)
                }
            } else {
                let alertController = UIAlertController(title: "添加失败", message: result, preferredStyle: .alert)
                let okAcount = UIAlertAction(title: "好的", style: .cancel, handler: {
                    action in
                })
                alertController.addAction(okAcount)
                self?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}

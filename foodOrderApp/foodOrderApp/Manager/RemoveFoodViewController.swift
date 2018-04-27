//
//  removeFoodViewController.swift
//  foodOrderApp
//
//  Created by sean on 4/21/18.
//  Copyright © 2018 NAsoftware. All rights reserved.
//

import UIKit

class RemoveFoodViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var foodNameTextField: UITextField!
    
    @IBAction func touchRemoveButton(_ sender: UIButton) {
        guard foodNameTextField.text != "" else {
            return
        }
        let accountTemp = UserDefaults.standard.string(forKey: "account")
        MenuService.removeMenuItem(account: accountTemp!, foodName: foodNameTextField.text!) { [weak self] (result) in
            if result == "success" {
                let alertController = UIAlertController(title: "移除成功", message: "菜单项：\(self?.foodNameTextField.text! ?? "未知") ", preferredStyle: .alert)
                let okAcount = UIAlertAction(title: "好的", style: .cancel, handler: {
                    action in
                })
                alertController.addAction(okAcount)
                self?.present(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "移除失败", message: result, preferredStyle: .alert)
                let okAcount = UIAlertAction(title: "好的", style: .cancel, handler: {
                    action in
                })
                alertController.addAction(okAcount)
                self?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}

//
//  ManagerViewController.swift
//  foodOrderApp
//
//  Created by sean on 4/6/18.
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

    @IBAction func touchManager(_ sender: UIButton) {
        self.performSegue(withIdentifier: "adminSection", sender: nil)
    }
    
    
    @IBAction func touchGuest(_ sender: UIButton) {
        self.performSegue(withIdentifier: "guastSection", sender: nil)
    }
}

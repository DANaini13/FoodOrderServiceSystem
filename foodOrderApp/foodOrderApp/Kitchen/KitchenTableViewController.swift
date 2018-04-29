//
//  KitchenTableViewController.swift
//  foodOrderApp
//
//  Created by sean on 4/28/18.
//  Copyright © 2018 NAsoftware. All rights reserved.
//

import UIKit

class KitchenTableViewController: UITableViewController {
    
    var data:[(String, String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let accountTemp = UserDefaults.standard.string(forKey: "account")
        OrderService.registerOrderChecker(account: accountTemp!) {
            [weak self] (result) in
            self?.data = []
            for x in result {
                let parts = x.1.components(separatedBy: "+");
                let ready = parts[3]
                if ready == "false" {
                    self?.data.append((x.0, x.1))
                }
            }
            self?.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kitchenCell", for: indexPath) as! KitchenTableViewCell
        let parts = self.data[indexPath.row].1.components(separatedBy: "+");
        let table = parts[0]
        let time = parts[1]
        let number = parts[2]
        //let ready = parts[3]
        cell.foodName.text = self.data[indexPath.row].0
        cell.table.text = "餐桌：" + table
        cell.time.text = "下单时间：" + time
        cell.number.text = "数量：" + number
        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "提醒", message: "这份食物做完了吗？", preferredStyle: .alert)
        let accountTemp = UserDefaults.standard.string(forKey: "account")
        let tableNumber = UserDefaults.standard.string(forKey: "table")
        let okAcount = UIAlertAction(title: "好的", style: .default, handler: {
            [weak self] action in
            OrderService.finishFood(account: accountTemp!, table: tableNumber!, foodName: (self?.data[indexPath.row].0)!, callBack: { (result) in
                
            })
        })
        let cancelAction = UIAlertAction(title: "点错了", style: .cancel, handler: {
            action in
        })
        alertController.addAction(okAcount)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */


}

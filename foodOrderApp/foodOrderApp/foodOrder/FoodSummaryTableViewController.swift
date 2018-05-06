//
//  FoodSummaryTableViewController.swift
//  foodOrderApp
//
//  Created by sean on 4/27/18.
//  Copyright © 2018 NAsoftware. All rights reserved.
//

import UIKit

class FoodSummaryTableViewController: UITableViewController {
    
    var data:[(String, String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= self.data.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderedItemTotal", for: indexPath)
            cell.textLabel?.text = "总价"
            var value = 0.0
            for x in self.data {
                value += Double(x.1)!
            }
            cell.detailTextLabel?.text = "\(value)"
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderedItem", for: indexPath)
            cell.textLabel?.text = self.data[indexPath.row].0
            cell.detailTextLabel?.text = "价格：" + self.data[indexPath.row].1
            return cell
        }
    }
    @IBAction func touchedOrderButton(_ sender: UIButton) {
        var foods:[String] = []
        for x in data {
            foods.append(x.0)
        }
        let accountTemp = UserDefaults.standard.string(forKey: "account")
        let tableNumber = Int(UserDefaults.standard.string(forKey: "table")!)
        OrderService.orderFoods(account: accountTemp!, foods: foods, tableNumber: tableNumber!) {
            (result) in
            if(result == "success") {
                self.performSegue(withIdentifier:"waitingController", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "waitingController" {
            if let controller = segue.destination as? WaitingTableViewController {
                controller.data = self.data
                controller.title = "请耐心等待"
            }
        }
    }
}

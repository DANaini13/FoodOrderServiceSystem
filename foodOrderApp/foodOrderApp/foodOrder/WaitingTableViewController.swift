//
//  WaitingTableViewController.swift
//  foodOrderApp
//
//  Created by sean on 4/28/18.
//  Copyright © 2018 NAsoftware. All rights reserved.
//

import UIKit

class WaitingTableViewController: UITableViewController {
    
    var data:[(String, String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let accountTemp = UserDefaults.standard.string(forKey: "account")
        let tableNumber = UserDefaults.standard.string(forKey: "table")
        OrderService.registerOrderStatusChecker(account: accountTemp!, table: tableNumber!) {
            [weak self] (result) in
            self?.data = []
            for x in result {
                let parts = x.1.components(separatedBy: "+")
                if parts[0] == "false" {
                    self?.data.append((x.0 + " x " + parts[1], parts[0]))
                }else {
                    self?.data.append((x.0 + "x" + parts[1], parts[0]))
                }
            }
            self?.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "waitingCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].0
        if data[indexPath.row].1 == "false" {
            cell.detailTextLabel?.text = "厨师正在玩儿命烹饪中。。。"
            cell.detailTextLabel?.textColor = UIColor.red
        }
        else {
            cell.detailTextLabel?.text = "厨房正在上菜啦，请享用"
            cell.detailTextLabel?.textColor = UIColor.green
        }
        return cell
    }

}

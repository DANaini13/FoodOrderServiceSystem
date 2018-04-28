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
        for i in 0..<data.count {
            data[i] = (data[i].0, "厨师玩儿命烹饪中。。。")
        }
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "waitingCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].0
        cell.detailTextLabel?.text = data[indexPath.row].1
        cell.detailTextLabel?.textColor = UIColor.red
        return cell
    }

}

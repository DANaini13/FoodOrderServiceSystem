//
//  foodOrderTableViewController.swift
//  foodOrderApp
//
//  Created by sean on 4/7/18.
//  Copyright © 2018 NAsoftware. All rights reserved.
//

import UIKit

class FoodOrderTableViewController: UITableViewController {
    
    var data:[(String, String)] = []
    var ordered:[(String, String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
        self.tableView.reloadData()
    }
    
    func updateData() {
        data = []
        let accountTemp = UserDefaults.standard.string(forKey: "account")
        if let account = accountTemp {
            MenuService.getMenu(account: account, callBack:  {[weak self] (result) in
                guard result["error"]! == "0" else {
                    let alertController = UIAlertController(title: "获取菜单失败！", message: result["error"], preferredStyle: .alert)
                    let okAcount = UIAlertAction(title: "Ok", style: .cancel, handler: {
                        action in
                    })
                    alertController.addAction(okAcount)
                    self?.present(alertController, animated: true, completion: nil)
                    return
                }
                for (key, value) in result {
                    if key == "error" {
                        continue
                    }
                    self?.data.append((key, value))
                }
                self?.tableView.reloadData()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count + 1
    }
    
    @IBAction func touchSummary(_ sender: UIButton) {
        self.performSegue(withIdentifier: "summaryItems", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= self.data.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "foodOrderItemTotal", for: indexPath)
            cell.textLabel?.text = "总价"
            var value = 0.0
            for x in self.ordered {
                value += Double(x.1)!
            }
            cell.detailTextLabel?.text = "\(value)"
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "foodOrderItem", for: indexPath)
            cell.textLabel?.text = self.data[indexPath.row].0
            cell.detailTextLabel?.text = "价格：" + self.data[indexPath.row].1
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "提醒", message: "确定要这份食物吗？", preferredStyle: .alert)
        let okAcount = UIAlertAction(title: "好的", style: .default, handler: {
            [weak self] action in
            self?.ordered.append(((self?.data[indexPath.row].0)!, (self?.data[indexPath.row].1)!))
            self?.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "点错了", style: .cancel, handler: {
            action in
            
        })
        alertController.addAction(okAcount)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "summaryItems" {
            if let controller = segue.destination as? FoodSummaryTableViewController {
                controller.data = self.ordered
                controller.title = "我点过的"
            }
        }
    }
}

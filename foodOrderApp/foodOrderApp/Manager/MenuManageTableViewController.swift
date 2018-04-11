//
//  MenuManageTableViewController.swift
//  foodOrderApp
//
//  Created by sean on 4/7/18.
//  Copyright © 2018 NAsoftware. All rights reserved.
//

import UIKit

class MenuManageTableViewController: UITableViewController {
    
    var data:[(String, String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                    self?.data.append((key, "价格：" + value))
                }
                self?.tableView.reloadData()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuItemCell", for: indexPath)
        cell.textLabel?.text = self.data[indexPath.row].0
        cell.detailTextLabel?.text = self.data[indexPath.row].1
        return cell
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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  KitchenTableViewCell.swift
//  foodOrderApp
//
//  Created by sean on 4/28/18.
//  Copyright © 2018 NAsoftware. All rights reserved.
//

import UIKit

class KitchenTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var table: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var number: UILabel!
    
}

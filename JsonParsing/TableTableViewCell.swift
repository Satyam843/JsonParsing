//
//  TableTableViewCell.swift
//  JsonParsing
//
//  Created by soc-admin on 8/19/20.
//  Copyright © 2020 soc-admin. All rights reserved.
//

import UIKit

class TableTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCustomer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

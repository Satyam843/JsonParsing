//
//  TableTableViewCell.swift
//  JsonParsing
//
//  Created by soc-admin on 8/19/20.
//  Copyright © 2020 soc-admin. All rights reserved.
//

import UIKit

class TableTableViewCell: UITableViewCell {
    //IB Outlets
    @IBOutlet weak var lblAutoAlertDateTime: UILabel!
    @IBOutlet weak var lblIsActive: UILabel!
    @IBOutlet weak var lblCreditLimit: UILabel!
    @IBOutlet weak var lblUsedCredit: UILabel!
    @IBOutlet weak var lblUserId: UILabel!
    @IBOutlet weak var lblCustomer: UILabel!
    @IBOutlet weak var lblwalletBalance: UILabel!
    //View life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

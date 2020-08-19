//
//  PaymentModel.swift
//  JsonParsing
//
//  Created by soc-admin on 8/17/20.
//  Copyright © 2020 soc-admin. All rights reserved.
//

import UIKit

class PaymentModel: Decodable {
    
    
    var customer_id :String?
    var user_id :String?
    var credit_limit:String?
    var used_credit:String?
    var wallet_balance:String?
    var auto_alert_datetime:String?
    var is_active = false
    init(json:[String:Any]) {
        if let customer_id = json["customer_id"] as? String {
            self.customer_id = customer_id
        } else if let customer_id = json["customer_id"] as? Int {
            self.customer_id = "\(customer_id)"
        }
        if let user_id = json["user_id"] as? String {
            self.user_id = user_id
        } else if let user_id = json["user_id"] as? Int {
            self.user_id = "\(user_id)"
        }
        if let credit_limit = json["credit_limit"] as? String {
            self.credit_limit = credit_limit
        } else if let credit_limit = json["credit_limit"] as? Int {
            self.credit_limit = "\(credit_limit)"
        }
        if let used_credit = json["used_credit"] as? String {
            self.used_credit = used_credit
        } else if let used_credit = json["api_key"] as? Int {
            self.used_credit = "\(used_credit)"
        }
        if let wallet_balance = json["wallet_balance"] as? String {
            self.wallet_balance = wallet_balance
        } else if let wallet_balance = json["wallet_balance"] as? Int {
            self.wallet_balance = "\(wallet_balance)"
        }
        if let auto_alert_datetime = json["auto_alert_datetime"] as? String {
            self.auto_alert_datetime = auto_alert_datetime
        } else if let auto_alert_datetime = json["auto_alert_datetime"] as? Int {
            self.auto_alert_datetime = "\(auto_alert_datetime)"
        }
        
        if let removed = json["is_active"] as? Bool {
            self.is_active = removed
        }else if let removed = json["is_active"] as? String{
            self.is_active = !(removed == "0")
        } else if let removed = json["is_active"] as? NSNumber{
            self.is_active = !(Int(removed) == 0)
        }
    }
}

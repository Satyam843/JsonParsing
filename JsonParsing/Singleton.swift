//
//  Singleton.swift
//  JsonParsing
//
//  Created by soc-admin on 8/18/20.
//  Copyright © 2020 soc-admin. All rights reserved.
//

import UIKit

class Singleton: NSObject {
static let sharedInstance = Singleton()
    var paymentWallet:PaymentModel?
}

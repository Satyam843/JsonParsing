//
//  ViewController.swift
//  JsonParsing
//
//  Created by soc-admin on 8/11/20.
//  Copyright © 2020 soc-admin. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    //IB Outlets
    @IBOutlet weak var tableView: UITableView!
    //Variables
    var paymentWallet:PaymentModel?
    //View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //getData()
        apiHitForWalletData()
        self.tableView.reloadData()
    }
    //Private methods
    func apiHitForWalletData() {
        let params = ["access_token":"75fb17f1fe727af8ceef0225bee4f232"]
        APIManager.sharedInstance.serverCall(apiName: API_NAME.get_customer_wallet, params: params as [String : AnyObject]?, httpMethod: HTTP_METHOD.POST) {(isSucceeded, response) in
           // ActivityIndicator.sharedInstance.hideActivityIndicator()
            if isSucceeded == true{
                if let data = response["data"] as? [String:Any]{
                    self.paymentWallet = PaymentModel(json: data)
                    Singleton.sharedInstance.paymentWallet = PaymentModel(json: data)
                   // self.apiHitForTranxHistory(startDateParam: self.beginDay, endDateParam: self.endDay)
                }
            }else {
                if let statusCode = response["status"] as? Int{
                    print(response)
                    if statusCode == STATUS_CODES.BAD_REQUEST{
                        
                    }else{
                        print("error found")
                    }
                }
                
            }
        }
    }
   
/*
func getData()
{
    let urlName = "https://api-7033.tookanapp.com:444/get_customer_wallet"
      let params = ["access_token":"26d00375329b7933007abfba64c94ce4" ]
    
    guard let url = URL(string: urlName ) else { return}
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    guard  let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {return}
    request.httpBody = httpBody
    request.addValue("application/json", forHTTPHeaderField: "Content-type")
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        if  let response = response
        {
            print(response)
        }
        if let data = data
        {
            do
            {
               // let json = try JSONSerialization.jsonObject(with: data, options: [])
                //self.array_data = try JSONDecoder().decode([PaymentModel].self, from: data)
                self.array_data = try JSONDecoder().decode(PaymentModel.self, from: data)
                print(self.array_data?.customer_id)
                //print(json)
 
            }
            catch
            {
                print(error)
            }
        }
    }.resume()
  
}*/
}
//extensions
extension ViewController : UITableViewDelegate,UITableViewDataSource
   {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableTableViewCell
        cell.lblCustomer.text = paymentWallet?.customer_id
        cell.lblUserId.text = paymentWallet?.user_id
        cell.lblwalletBalance.text = paymentWallet?.wallet_balance
        cell.lblCreditLimit.text = paymentWallet?.credit_limit
        cell.lblUsedCredit.text = paymentWallet?.used_credit
        //cell.lblIsActive.text = paymentWallet?.is_active
       // cell.lblUserId.
        if ((paymentWallet?.is_active! = true) != nil)
        {
            cell.lblIsActive.text = "User is active"
        }
        else
        {
            cell.lblIsActive.text = "User is inactive"
        }
        cell.lblAutoAlertDateTime.text = paymentWallet?.auto_alert_datetime
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
   }


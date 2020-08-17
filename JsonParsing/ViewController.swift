//
//  ViewController.swift
//  JsonParsing
//
//  Created by soc-admin on 8/11/20.
//  Copyright © 2020 soc-admin. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }

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
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
            catch
            {
                print(error)
            }
        }
    }.resume()
  /*  let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
        error == nil
        else
        {
            print(error?.localizedDescription ?? "error in parsing")
            return
        }
        do
        {
            let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
            print(jsonResponse)
        }
        catch let parsingError
        {
            print("Error",parsingError)
        }
    }*/
    //task.resume()
}
}


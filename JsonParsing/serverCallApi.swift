//
//  serverCallApi.swift
//  JsonParsing
//
//  Created by soc-admin on 8/18/20.
//  Copyright © 2020 soc-admin. All rights reserved.
//

import Foundation
func sendRequestToServer(baseUrl:String = "https://api-7033.tookanapp.com:444/",_ url: String, params: [String:AnyObject], httpMethod: String, isZipped:Bool, receivedResponse:@escaping (_ succeeded:Bool, _ response:[String:Any]) -> ()){

    
    
    let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    var request = URLRequest(url: URL(string: (baseUrl) + urlString!)!)
    request.httpMethod = httpMethod as String
    request.timeoutInterval = 20
    print(request)
    if(httpMethod == "POST")
    {
        request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        if isZipped == false {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } else {
            request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
            request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Encoding: gzip")
        }
        request.addValue("application/json", forHTTPHeaderField: "Accept")
    }
    let task = URLSession.shared.dataTask(with: request) {data, response, error in
        if(response != nil && data != nil) {
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] {
                    
                    

                    
                    //     let success = json["success"] as? Int                                  // Okay, the `json` is here, let's get the value for 'success' out of it
                    // print("Success: \(success)")
                //    FIRAnalytics.logEvent(withName: ANALYTICS_KEY.API_SUCCESS, parameters: ["API":urlString! as NSObject])
                //    Answers.logCustomEvent(withName: ANALYTICS_KEY.API_SUCCESS, customAttributes: ["API":urlString])
                    receivedResponse(true, json)
                } else {
                //    FIRAnalytics.logEvent(withName: ANALYTICS_KEY.API_FAILURE, parameters: ["API":urlString! as NSObject])
                //    Answers.logCustomEvent(withName: ANALYTICS_KEY.API_FAILURE, customAttributes: ["API":urlString])

                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)    // No error thrown, but not NSDictionary
                    print("Error could not parse JSON: \(jsonStr ?? "none")")
                    receivedResponse(false, [:])
                }
            } catch let parseError {
                print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Error could not parse JSON: '\(jsonStr ?? "none")'")
            //    FIRAnalytics.logEvent(withName: ANALYTICS_KEY.API_FAILURE, parameters: ["API":urlString! as NSObject])
            //    Answers.logCustomEvent(withName: ANALYTICS_KEY.API_FAILURE, customAttributes: ["API":urlString])
                receivedResponse(false, [:])
            }
        } else {
           // FIRAnalytics.logEvent(withName: ANALYTICS_KEY.API_FAILURE, parameters: ["API":urlString! as NSObject])
          //  Answers.logCustomEvent(withName: ANALYTICS_KEY.API_FAILURE, customAttributes: ["API":urlString])
            receivedResponse(false, [:])
        }
    }
    task.resume()
}

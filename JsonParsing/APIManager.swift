//
//  APIManager.swift
//  JsonParsing
//
//  Created by soc-admin on 8/17/20.
//  Copyright © 2020 soc-admin. All rights reserved.
//

import UIKit
import CoreLocation
class APIManager: NSObject {
        static let sharedInstance = APIManager()
    func serverCall(baseURl:String = "https://api-7033.tookanapp.com:444/",apiName:String,params: [String : AnyObject]?,httpMethod:String,receivedResponse:@escaping (_ succeeded:Bool, _ response:[String:Any]) -> ()) {
           
           print(params ?? "")
           
        sendRequestToServer(baseUrl:baseURl,apiName, params: params! , httpMethod: httpMethod, isZipped:false) { (succeeded:Bool, response:[String:Any]) -> () in
                       DispatchQueue.main.async {
                           if(succeeded){
                               if let status = response["status"] as? Int {
                                   
                                   switch(status) {
                                   case STATUS_CODES.SHOW_DATA:
                                       DispatchQueue.main.async(execute: { () -> Void in
                                           receivedResponse(true, response)
                                          // logEvent(label: "api_success")
                                       })
                                       break
                                       
                                   case STATUS_CODES.INVALID_ACCESS_TOKEN:
                                     //  Singleton.sharedInstance.logoutButtonAction()
                                      // Singleton.sharedInstance.showAlert(response["message"] as? String ?? "")
                                       receivedResponse(false, response)
                                       //logEvent(label: "api_failure")
                                       break
                                       
                                   case STATUS_CODES.SHOW_MESSAGE:
                                       receivedResponse(false, response)
                                      // logEvent(label: "api_failure")
                                       break
                                       
                                   default:
                                       receivedResponse(false, response)
                                      // logEvent(label: "api_failure")
                                   }
                               } else {
                                   receivedResponse(false, ["message":"Error message: Server not responding"])
                                   //logEvent(label: "api_failure")
                               }
                           } else {
                               receivedResponse(false, ["message":"ERROR_MESSAGE.SERVER_NOT_RESPONDING"])
                               //logEvent(label: "api_failure")
                           }
                       }
                   }
           
       }
}


//
//  BaseNetworkClass.swift
//  cityride
//
//  Created by Matthew Attou on 5/21/16.
//  Copyright © 2016 Matthew Attou. All rights reserved.
//

import Foundation
import Alamofire


class BaseNetworkClass:NSObject {
    
    // GET request
    func getRequest(url: String, parameters:Dictionary<String, String>, completion: (result: AnyObject) -> Void) {
        
        Alamofire.request(
            
            .GET, url,
            parameters: parameters)
            .responseJSON {
                
                response in
                
                completion(result: response.result.value!)
        }
    }
    
    // POST request
    func postRequest(url: String, parameters:Dictionary<String, NSDictionary>, completion: (result: AnyObject) -> Void) {
        
        let aManager = Manager.sharedInstance
            aManager.session.configuration.HTTPAdditionalHeaders = [
                                                                    "Content-Type": "application/json",
                                                                    "Accept": "application/vnd.com.teradata.rest-v1.0+json",
                                                                    "Authorization":"Basic aGFjazA2dXNlcjp3ZWxsc2NsYXNzNTgzMQ==",]
        
        Alamofire.request(
            
            .POST,
            url,
            parameters: nil)
            .responseJSON {
                
                response in
                
                completion(result: response.result.value!)
        }
    }
    
    func printResult(response: Response<AnyObject, NSError>) {
        
        print(response.request)  // original URL request
        print(response.response) // URL response
        print(response.data)     // server data
        print(response.result)   // result of response serialization
        if let JSON = response.result.value {
            print("JSON: \(JSON)")
        }
    }
}
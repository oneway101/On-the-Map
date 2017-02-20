//
//  Convenience.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/10/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit

// MARK: - UdacityClient (Convenient Resource Methods)

extension UdacityClient{

    /*
     Steps for Udaicty Authentication...
     Step 1: Post a session
     Step 2: Get public user data
     Step 3: Logout
     */
    
    func udacityLogin(username: String, password: String, completionHandlerForSession: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        let methodParameters = [String:AnyObject]()
        let urlString = Constants.SessionURL
        let jsonBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
        /* Make the request */
        let _ = taskForPOSTMethod(urlString, parameters: methodParameters as [String:AnyObject], jsonBody: jsonBody) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                print(error)
                completionHandlerForSession(false, "Login Failed.")
            } else {
                if let account = results?[JSONResponseKeys.Account] as? NSDictionary {
                    if let accountKey = account[JSONResponseKeys.AccountKey] as? String{
                        self.accountKey = accountKey
                        completionHandlerForSession(true, nil)
                    }
                    
                } else {
                    print("Could not find \(JSONResponseKeys.AccountKey) in \(results)")
                    completionHandlerForSession(false, "Login Failed. Could not find the account key.")
                }
            }
        }
    }
    
}

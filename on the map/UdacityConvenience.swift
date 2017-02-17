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
        print("jsonBody-->\(jsonBody)")
        /* Make the request */
        let _ = taskForPOSTMethod(urlString, parameters: methodParameters as [String:AnyObject], jsonBody: jsonBody) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                print(error)
                completionHandlerForSession(false, "Login Failed (Session ID).")
            } else {
                if let sessionID = results?[JSONResponseKeys.Session] as? String {
                    // TODO: Where to store the sessionID?
                    completionHandlerForSession(true, nil)
                } else {
                    print("Could not find \(JSONResponseKeys.Session) in \(results)")
                    completionHandlerForSession(false, "Login Failed (Session ID).")
                }
            }
        }
    }
    
}

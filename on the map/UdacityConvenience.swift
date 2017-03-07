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
    
    func udacityLogin(username: String, password: String, _ completionHandlerForLogin: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        //let methodParameters = [String:AnyObject]()
        let urlString = Constants.SessionURL
        let headerFields = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        let jsonBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
        /* Make the request */
        let _ = taskForPOSTMethod(urlString: urlString, headerFields: headerFields, jsonBody: jsonBody) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                print(error.localizedDescription)
                completionHandlerForLogin(false, error.localizedDescription)
            } else {
                if let account = results?[JSONResponseKeys.Account] as? NSDictionary {
                    if let accountKey = account[JSONResponseKeys.AccountKey] as? String{
                        StudentDataModel.accountKey = accountKey
                        completionHandlerForLogin(true, nil)
                    }
                    
                } else {
                    print("Could not find \(JSONResponseKeys.AccountKey) in \(results)")
                    completionHandlerForLogin(false, "Could not login.")
                }
            }
        }
    }//Udacity Login
    
    func getUserData(_ completionHandlerForUserData: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        let urlString = Constants.UserURL + "/\(StudentDataModel.accountKey)"
        let headerFields = [String:String]()
        /* Make the request */
        let _ = taskForGETMethod(urlString: urlString, headerFields: headerFields, client: "udacity") { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                print(error.localizedDescription)
                completionHandlerForUserData(false, "There was an error getting user data.")
            } else {
                if let user = results?[JSONResponseKeys.User] as? NSDictionary {
                    if let userFirstName = user[JSONResponseKeys.firstName] as? String, let userLastName = user[JSONResponseKeys.lastName] as? String {
                        StudentDataModel.firstName = userFirstName
                        StudentDataModel.lastName = userLastName
                        completionHandlerForUserData(true, nil)
                    }
                    
                } else {
                    print("Could not find \(JSONResponseKeys.User) in \(results)")
                    completionHandlerForUserData(false,"Could not get the user data.")
                }
            }
        }
    }//GetUserData
    
    func udacityLogout(_ completionHandlerForLogout: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        let urlString = Constants.SessionURL
        let request = NSMutableURLRequest(url:URL(string:urlString)!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        /* Make the request */
        let _ = taskForDELETEMethod(request as URLRequest) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                print(error.localizedDescription)
                completionHandlerForLogout(false, "There was an error with logout.")
            } else {
                if let session = results?[JSONResponseKeys.Session] as? NSDictionary {
                    if let expiration = session[JSONResponseKeys.Expiration] as? String{
                        print("logged out: \(expiration)")
                        completionHandlerForLogout(true, nil)
                    }
                    
                } else {
                    print("Could not find \(JSONResponseKeys.Session) in \(results)")
                    completionHandlerForLogout(false,"Could not logout.")
                }
            }
        }
    }//Udacity logout
    
}

//
//  UdacityClient.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/10/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import Foundation

class UdacityClient: Client {
    
    // MARK: Properties
    var sessionID: String? = nil
    
    // MARK: Constants
    struct Constants {
        static let SessionURL = "https://www.udacity/api/session"
        static let UserURL = "https://www.udacity/api/user"
    }
    
    // MARK: Parameter Keys
    struct ParameterKeys {
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        static let Account = "account"
        static let Session = "session"
    }
    
    // MARK: Shared Instance
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }

}

//
//  StudentInformation.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/10/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import Foundation

struct StudentInformations {
    
    // MARK: Properties
    let objectId: String
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let location: String
    let website: String
    let latitude: Int
    let longitude: Int
    
    // MARK: Initializers
    init(dictionary: [String:AnyObject]) {
        objectId = dictionary[ParseClient.JSONResponseKeys.ObjectId] as! String
        uniqueKey = dictionary[ParseClient.JSONResponseKeys.UniqueKey] as! String
        firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as! String
        lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as! String
        location = dictionary[ParseClient.JSONResponseKeys.Location] as! String
        website = dictionary[ParseClient.JSONResponseKeys.Website] as! String
        latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as! Int
        longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as! Int
    }
    
    static func studentInfoFromResults(_ results: [[String:AnyObject]]) -> [StudentInformations] {
        
        var studentInfoDictionary = [StudentInformations]()
        
        // iterate through array of dictionaries, each StudentInfo is a dictionary
        for result in results {
            studentInfoDictionary.append(StudentInformations(dictionary: result))
        }
        
        return studentInfoDictionary
    }

}

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
    //var objectId: String!
    //var uniqueKey: String!
    var firstName = ""
    var lastName = ""
    var location = ""
    var website = ""
    var latitude = 0.0
    var longitude = 0.0
    
    // MARK: Initializers
    init(dictionary: [String:AnyObject]) {
        //objectId = dictionary[ParseClient.JSONResponseKeys.ObjectId] as? String
        //uniqueKey = dictionary[ParseClient.JSONResponseKeys.UniqueKey] as? String
        if let first = dictionary[ParseClient.JSONResponseKeys.FirstName] as? String {
            firstName = first
        }
        if let last = dictionary[ParseClient.JSONResponseKeys.LastName] as? String {
            lastName = last
        }
        if let mapString = dictionary[ParseClient.JSONResponseKeys.Location] as? String {
            location = mapString
        }
        if let mediaURL = dictionary[ParseClient.JSONResponseKeys.Website] as? String {
            website = mediaURL
        }
        if let lat = dictionary[ParseClient.JSONResponseKeys.Latitude] as? Double {
            latitude = lat
        }
        if let lon = dictionary[ParseClient.JSONResponseKeys.Longitude] as? Double {
            longitude = lon
        }
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

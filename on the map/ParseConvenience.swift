//
//  ParseConvenience.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/10/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit

extension ParseClient {
    
    // MARK: GET Convenience Methods
    
    func getStudentLocation(_ completionHandlerForStudentLocation: @escaping (_ result: [StudentInformations]?, _ error: NSError?) -> Void) {
        let methodParameters = [
            ParameterKeys.Limit : 100
        ]
        /* Make the request */
        let urlString = Constants.StudentLocationURL + escapedParameters(methodParameters as [String:AnyObject])
        let request = NSMutableURLRequest(url:URL(string:urlString)!)
        
        request.httpMethod = "GET"
        request.addValue(parseAppID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let _ = taskForGETMethod(request as URLRequest, parameters: methodParameters as [String:AnyObject]) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForStudentLocation(nil, error)
            } else {
                if let results = results?[JSONResponseKeys.Results] as? [[String:AnyObject]] {
                    // Creates a student object array from results
                    let studentInfo = StudentInformations.studentInfoFromResults(results)
                    completionHandlerForStudentLocation(studentInfo, nil)
                } else {
                    completionHandlerForStudentLocation(nil, NSError(domain: "getStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocation"]))
                }
            }
        }
    }
    
    // MARK: POST Convenience Methods
    
    func postNewLocation(_ completionHandlerForPostNew: @escaping (_ result: String?, _ error: NSError?) -> Void) {
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */

//        let jsonBody = [
//            JSONResponseKeys.UniqueKey: StudentDataModel.accountKey,
//            JSONResponseKeys.FirstName: StudentDataModel.firstName,
//            JSONResponseKeys.LastName: StudentDataModel.lastName,
//            JSONResponseKeys.Location: StudentDataModel.mapString,
//            JSONResponseKeys.Website: StudentDataModel.website,
//            JSONResponseKeys.Latitude: StudentDataModel.latitude,
//            JSONResponseKeys.Longitude: StudentDataModel.longitude
//        ]
        let urlString = Constants.StudentLocationURL
        let headerFields = [
            "X-Parse-Application-Id": parseAppID,
            "X-Parse-REST-API-Key": apiKey,
            "Content-Type": "application/json"
            ]
        let jsonBody = "{\"uniqueKey\": \"\(StudentDataModel.accountKey)\", \"firstName\": \"\(StudentDataModel.firstName)\", \"lastName\": \"\(StudentDataModel.lastName)\",\"mapString\": \"\(StudentDataModel.mapString)\", \"mediaURL\": \"\(StudentDataModel.website)\",\"latitude\":\(StudentDataModel.latitude), \"longitude\": \(StudentDataModel.longitude)}"
        print(jsonBody)
        /* 2. Make the request */
        let _ = taskForPOSTMethod(urlString: urlString, headerFields: headerFields, jsonBody: jsonBody) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForPostNew(nil, error)
            } else {
                if let objectId = results?[JSONResponseKeys.ObjectId] as? String {
                    completionHandlerForPostNew(objectId, nil)
                } else {
                    completionHandlerForPostNew(nil, NSError(domain: "postNewStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postNewStudentLocation"]))
                }
            }
        }
    }
    
}

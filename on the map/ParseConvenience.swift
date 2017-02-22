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
    
//    func postNewStudentLocation(_ studentInfo: StudentInformations, completionHandlerForFavorite: @escaping (_ result: Int?, _ error: NSError?) -> Void) {
//        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
//        let methodParameters = [
//        
//        ]
//        let jsonBody = "{\"\(JSONResponseKeys.UniqueKey)\": \"\(1234)\", \"\(JSONResponseKeys.FirstName)\": \"John\", \"\(JSONResponseKeys.LastName)\": \"Doe\",\"\(JSONResponseKeys.Location)\": \"Mountain View, CA\", \"\(JSONResponseKeys.Website)\": \"https://udacity.com\",\"\(JSONResponseKeys.Latitude)\": 37.386052, \"\(JSONResponseKeys.Longitude)\": -122.083851}"
//        
//        /* 2. Make the request */
//        let _ = taskForPOSTMethod(parameters: methodParameters as [String:AnyObject], jsonBody: jsonBody) { (results, error) in
//            
//            /* 3. Send the desired value(s) to completion handler */
//            if let error = error {
//                completionHandlerForFavorite(nil, error)
//            } else {
//                if let results = results?[TMDBClient.JSONResponseKeys.StatusCode] as? Int {
//                    completionHandlerForFavorite(results, nil)
//                } else {
//                    completionHandlerForFavorite(nil, NSError(domain: "postToFavoritesList parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postToFavoritesList"]))
//                }
//            }
//        }
//    }
    
}

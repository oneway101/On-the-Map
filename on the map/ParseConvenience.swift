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
            ParameterKeys.Limit : 50
        ]
        /* 2. Make the request */
        let _ = taskForGETMethod(parameters: methodParameters as [String:AnyObject]) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForStudentLocation(nil, error)
            } else {
                if let results = results?[JSONResponseKeys.Results] as? [[String:AnyObject]] {
                    let studentInfo = StudentInformations.studentInfoFromResults(results)
                    completionHandlerForStudentLocation(studentInfo, nil)
                } else {
                    completionHandlerForStudentLocation(nil, NSError(domain: "getStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocation"]))
                }
            }
        }
    }
    
    // MARK: POST Convenience Methods
    
    func postStudentLocation(_ movie: StudentInformations, completionHandlerForFavorite: @escaping (_ result: Int?, _ error: NSError?) -> Void) {
    }
}

//
//  ParseClient.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/10/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit

class ParseClient: NSObject {
    
    // MARK: Properties
    var session = URLSession.shared
    let parseAppID:String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    let apiKey:String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
    // MARK: Constants
    struct Constants {
        static let StudentLocationURL = "https://parse.udacity.com/parse/classes/StudentLocation"
    }
    
    // MARK: Parameter Keys
    struct ParameterKeys {
        static let Where = "where"
        static let Limit = "limit"
        static let Skip = "skip"
        static let Order = "order"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        static let Results = "results"
        static let ObjectId = "objectId"
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let Location = "mapString"
        static let Website = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
    }
    
    // MARK: Helpers
        func taskForGETMethod(parameters: [String:AnyObject], completionHandlerForGET: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
            /* 1. Set the parameters */
            
            /* 2/3. Build the URL, Configure the request */
            let urlString = Constants.StudentLocationURL + escapedParameters(parameters as [String:AnyObject])
            let request = NSMutableURLRequest(url:URL(string:urlString)!)
            
            request.httpMethod = "GET"
            request.addValue(parseAppID, forHTTPHeaderField: "X-Parse-Application-Id")
            request.addValue(apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
            
            /* 4. Make the request */
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
                
                func sendError(_ error: String) {
                    print(error)
                    let userInfo = [NSLocalizedDescriptionKey : error]
                    completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
                }
                
                /* GUARD: Was there an error? */
                guard (error == nil) else {
                    sendError("There was an error with your request: \(error)")
                    return
                }
                
                /* GUARD: Did we get a successful 2XX response? */
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                    sendError("Your request returned a status code other than 2xx!")
                    return
                }
                
                /* GUARD: Was there any data returned? */
                guard let data = data else {
                    sendError("No data was returned by the request!")
                    return
                }
                
                /* 5/6. Parse the data and use the data (happens in completion handler) */
                self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
            }
            
            /* 7. Start the request */
            task.resume()
            
            return task
        }
    
        func taskForPOSTMethod(parameters: [String:AnyObject], jsonBody: String, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
            /* 1. Set the parameters */
            
            /* 2/3. Build the URL, Configure the request */
            let urlString = Constants.StudentLocationURL + escapedParameters(parameters as [String:AnyObject])
            let request = NSMutableURLRequest(url:URL(string:urlString)!)
            
            request.httpMethod = "POST"
            request.addValue(parseAppID, forHTTPHeaderField: "X-Parse-Application-Id")
            request.addValue(apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonBody.data(using: String.Encoding.utf8)
            
            /* 4. Make the request */
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
                
                func sendError(_ error: String) {
                    print(error)
                    let userInfo = [NSLocalizedDescriptionKey : error]
                    completionHandlerForPOST(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
                }
                
                /* GUARD: Was there an error? */
                guard (error == nil) else {
                    sendError("There was an error with your request: \(error)")
                    return
                }
                
                /* GUARD: Did we get a successful 2XX response? */
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                    sendError("Your request returned a status code other than 2xx!")
                    return
                }
                
                /* GUARD: Was there any data returned? */
                guard let data = data else {
                    sendError("No data was returned by the request!")
                    return
                }
                
                /* 5/6. Parse the data and use the data (happens in completion handler) */
                self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForPOST)
                
                print(NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)
            }
            
            /* 7. Start the request */
            task.resume()
            
            return task

        }
    
    // given raw JSON, return a usable Foundation object
        private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
            
            var parsedResult: AnyObject! = nil
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            } catch {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
                completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
            }
            
            completionHandlerForConvertData(parsedResult, nil)
        }
    
    private func escapedParameters(_ parameters: [String:AnyObject]) -> String {
        
        if parameters.isEmpty {
            return ""
        } else {
            var keyValuePairs = [String]()
            
            for (key, value) in parameters {
                
                // make sure that it is a string value
                let stringValue = "\(value)"
                
                // escape it
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                // append it
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
                
            }
            
            return "?\(keyValuePairs.joined(separator: "&"))"
        }
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }

}

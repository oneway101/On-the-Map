//
//  Helpers.swift
//  on-the-map
//
//  Created by Ha Na Gill on 3/7/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func displayAlert(title:String, message:String?) {

        if let message = message {
            let alert = UIAlertController(title: title, message: "\(message)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}

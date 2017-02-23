//
//  LoginViewController.swift
//  on the map
//
//  Created by Ha Na Gill on 2/9/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var worldMapImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var debugTextLabel: UILabel!
    
    // MARK: Login
    
    @IBAction func loginPressed(_ sender: AnyObject) {
        
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            self.displayError("Username or Password is empty")
        } else {
            UdacityClient.sharedInstance().udacityLogin(username: usernameTextField.text!, password: passwordTextField.text!, completionHandlerForSession: { (success, errorString) in
                
                performUIUpdatesOnMain {
                    if success{
                        self.completeLogin()
                        print("successfully logged in!")
                    }else if errorString != nil {
                        self.displayError(errorString)
                    }
                    else{
                        self.displayError("Invalid Username or Password")
                    }
                }
                
            })
        }
    }
    
    private func completeLogin() {
        performUIUpdatesOnMain {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavMainView")
            self.present(controller, animated: true, completion: nil)
            
        }
    }
    
    func displayError(_ errorString: String?) {
        if let errorString = errorString {
            let alert = UIAlertController(title: "Login Failed", message: "\(errorString)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

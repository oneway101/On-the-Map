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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var debugTextLabel: UILabel!
    
    // MARK: Login
    
    @IBAction func loginPressed(_ sender: AnyObject) {
        
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            debugTextLabel.text = "Username or Password Empty."
        } else {
            UdacityClient.sharedInstance().udacityLogin(username: usernameTextField.text!, password: passwordTextField.text!, completionHandlerForSession: { (success, errorString) in
                
                performUIUpdatesOnMain {
                    if success{
                        self.completeLogin()
                        print("successfully logged in!")
                    }else{
                        self.debugTextLabel.text = "Could not Log in."
                        self.displayError(errorString)
                    }
                }
                
            })
        }
    }
    
    private func completeLogin() {
        performUIUpdatesOnMain {
            self.debugTextLabel.text = ""
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavMainView")
            self.present(controller, animated: true, completion: nil)
            
        }
    }
    
    func displayError(_ errorString: String?) {
        if let errorString = errorString {
            debugTextLabel.text = errorString
        }
    }
}

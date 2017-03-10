//
//  LoginViewController.swift
//  on the map
//
//  Created by Ha Na Gill on 2/9/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var worldMapImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var debugTextLabel: UILabel!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        
        view.frame.origin.y = -(getKeyboardHeight(notification))
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        //textField.resignFirstResponder()
        return true;
    }
    
    // MARK: Login
    
    @IBAction func loginPressed(_ sender: AnyObject) {
        
        //Show Activity Indicator
        showActivityIndicator(activityIndicator)
        
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            displayAlert(title: "Login Failed", message: "Username or Password is empty")
        } else {
            UdacityClient.sharedInstance().udacityLogin(username: usernameTextField.text!, password: passwordTextField.text!) { (success, errorString) in
                performUIUpdatesOnMain {
                    
                    //Hide Activity Indicator
                    self.hideActivityIndicator(self.activityIndicator)
                    
                    if success{
                        performUIUpdatesOnMain {
                            self.completeLogin()
                            print("successfully logged in!")
                        }
                    }else if errorString != nil {
                        performUIUpdatesOnMain {
                            self.displayAlert(title: "Login Failed", message: errorString)
                        }
                    }
                    else{
                        performUIUpdatesOnMain {
                            self.displayAlert(title: "Login Failed", message: "Invalid Username or Password")
                        }
                        
                    }
                }
                
            }
        }
    }
    
    private func completeLogin() {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavMainView")
            self.present(controller, animated: true, completion: nil)
    }
    
}

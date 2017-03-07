//
//  AddLocationViewController.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/10/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBookUI


class AddLocationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var enterLocation: UITextField!
    @IBOutlet weak var enterWebsite: UITextField!
    @IBOutlet weak var findLocation: UIButton!
    
    // MARK: Properties
    var address = ""
    var website = ""
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        //enterLocation.text = "New York"
        //enterWebsite.text = "http://www.udacity.com"
        self.enterLocation.delegate = self
        self.enterWebsite.delegate = self
        getUserName()
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
    
    //Find location button
    @IBAction func findLocation(_ sender: Any) {
        if enterLocation.text!.isEmpty{
            self.displayAlert("Must Enter a Location")
        }else if enterWebsite.text!.isEmpty{
            self.displayAlert("Must Enter a Website")
        }else{
            address = enterLocation.text!
            StudentDataModel.mapString = enterLocation.text!
            StudentDataModel.website = enterWebsite.text!
            forwardGeocoding(address)
        }
    }
    
    // Geocode Address String
    func forwardGeocoding(_ address: String) {
        // Activity Indicator
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = .gray
        view.addSubview(activityIndicator)
        self.activityIndicator.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        guard (error == nil) else {
            print("Unable to Forward Geocode Address (\(error))")
            displayAlert("Unable to Forward Geocode Address")
            return
        }
        
        if let placemarks = placemarks, placemarks.count > 0 {
            let placemark = placemarks[0]
            if let location = placemark.location {
                let coordinate = location.coordinate
                print("*** coordinate ***")
                print(placemark)
                
                StudentDataModel.latitude = coordinate.latitude
                StudentDataModel.longitude = coordinate.longitude
                
                if (placemark.locality != nil && placemark.administrativeArea != nil){
                StudentDataModel.mapString = ("\(placemark.locality!),\(placemark.administrativeArea!)")
                }
                presentSubmitLocationView()
            } else {
                displayAlert("No Matching Location Found")
            }
        }
        
    }
    
    func getUserName(){
        UdacityClient.sharedInstance().getUserData { (success, error) in
            guard (error == nil) else{
                self.displayAlert("Could not get a public user name.")
                print(error)
                return
            }
        }
    }
    
    private func displayAlert(_ errorString: String?) {
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        
        if let errorString = errorString {
            let alert = UIAlertController(title: "Location Not Found", message: "\(errorString)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func presentSubmitLocationView(){
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "submitLocationView")
        self.present(controller, animated: true, completion: nil)
    }
    
}

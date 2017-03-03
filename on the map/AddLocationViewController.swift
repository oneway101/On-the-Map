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


class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var enterLocation: UITextField!
    @IBOutlet weak var enterWebsite: UITextField!
    @IBOutlet weak var findLocation: UIButton!
    
    // MARK: Properties
    var address = ""
    var website = ""
    
    override func viewDidLoad() {
        //enterLocation.text = "New York"
        //enterWebsite.text = "http://www.udacity.com"
        getUserName()
    }
    
    //Found location button
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
                
                //Q: How to safely unwrap mapString?
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
        if let errorString = errorString {
            let alert = UIAlertController(title: "Location Not Found", message: "\(errorString)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func presentSubmitLocationView(){
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "submitLocationView")
        self.present(controller, animated: true, completion: nil)
    }
    
}

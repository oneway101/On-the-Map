//
//  AddLocationViewController.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/10/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AddressBookUI


class AddLocationViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var enterLocation: UITextField!
    @IBOutlet weak var enterWebsite: UITextField!
    @IBOutlet weak var findLocation: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: Properties
    var address = ""
    var website = ""
    //var mapString = ""
    //var lat = 0.0
    //var lon = 0.0
    
    override func viewDidLoad() {
        //enterLocation.text = "New York"
        //enterWebsite.text = "http://www.udacity.com"
    }
    
    //Found location button
    @IBAction func findLocation(_ sender: Any) {
        if enterLocation.text!.isEmpty{
            self.displayAlert("Must Enter a Location")
        }else if enterWebsite.text!.isEmpty{
            self.displayAlert("Must Enter a Website")
        }else{
            address = enterLocation.text!
            website = enterWebsite.text!
            forwardGeocoding(address)
        }
        presentSubmitLocationView()
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
                StudentDataModel.mapString = ("\(placemark.locality),\(placemark.administrativeArea)")
                self.populateMapView()
                
            } else {
                displayAlert("No Matching Location Found")
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
        performSegue(withIdentifier: "submitLocation", sender: self)
        //populateMapView()
    }
    
    private func populateMapView(){
        var annotations = [MKPointAnnotation]()
            let lat = CLLocationDegrees(StudentDataModel.latitude)
            let lon = CLLocationDegrees(StudentDataModel.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(StudentDataModel.firstName) \(StudentDataModel.lastName)"
            annotation.subtitle = website
            annotations.append(annotation)
        print("*** annotations ***")
        print(annotations)

        performUIUpdatesOnMain {
            self.mapView.addAnnotations(annotations)
            print("new location added to the map view.")
        }
    }

    
    @IBAction func submitLocation(_ sender: Any) {
        ParseClient.sharedInstance().postNewLocation { (results, error) in
            if error != nil {
                print("*** submit error ***")
                print(error)
            } else {
                print("*** objectId ***")
                print(results)
            }
        }

    }

    
    
}

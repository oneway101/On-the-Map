//
//  SubmitLocationViewController.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/28/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AddressBookUI


class submitLocationViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        populateMapView()
    }

    
    private func populateMapView(){
        var annotations = [MKPointAnnotation]()
        let lat = CLLocationDegrees(StudentDataModel.latitude)
        let lon = CLLocationDegrees(StudentDataModel.longitude)
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(StudentDataModel.firstName) \(StudentDataModel.lastName)"
        annotation.subtitle = StudentDataModel.website
        annotations.append(annotation)
        
        performUIUpdatesOnMain {
            self.mapView.addAnnotations(annotations)
            print("new location added to the map view.")
        }
    }
    
    
    @IBAction func submitLocation(_ sender: Any) {
        ParseClient.sharedInstance().postNewLocation { (results, error) in
            
            if error != nil {
                self.displayAlert("Could not complete your request")
                print(error)
            } else {
                if let objectId = results {
                    StudentDataModel.objectId = objectId
                //self.displayAlert("Successfully posted a new location!")
                }
            }
        }
        self.presentMainView()
    }
    
    private func presentMainView(){
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavMainView")
        self.present(controller, animated: true, completion: nil)
    }
    
    private func displayAlert(_ errorString: String?) {
        if let errorString = errorString {
            let alert = UIAlertController(title: "Submit Location", message: "\(errorString)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
}


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
        
        //zoom into an appropriate region
        let span = MKCoordinateSpanMake(1, 1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        performUIUpdatesOnMain {
            self.mapView.addAnnotations(annotations)
            self.mapView.setRegion(region, animated: true)
            print("new location added to the map view.")
        }
    }
    
    
    @IBAction func submitLocation(_ sender: Any) {
        ParseClient.sharedInstance().postNewLocation { (results, error) in
            
            if (error != nil) {
                self.dismiss(animated: true, completion: nil)
                performUIUpdatesOnMain {
                    self.displayAlert(title: "Submission Error", message: "Could not complete your request")
                }
                print(error)
            } else {
                if let objectId = results {
                    StudentDataModel.objectId = objectId
                    self.presentMainView()
                }
            }
        }
    }
    
    private func presentMainView(){
        
        performUIUpdatesOnMain {
            let alert = UIAlertController(title: "New location Added", message: "Successfully submitted a new location!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
                (action) -> Void in self.performSegue(withIdentifier: "showMapView", sender: self)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelSubmitLocation(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}



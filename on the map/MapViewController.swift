//
//  MapViewController.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/10/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var studentInfoDictionary = [StudentInformations]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        mapView.delegate = self
        getStudentInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func getStudentInfo(){
        ParseClient.sharedInstance().getStudentLocation { (studentInfo, error) in
            if let studentInfo = studentInfo {
                StudentDataModel.studentLocations = studentInfo
                self.populateMapView()
            }else{
                print(error)
                self.displayAlert(title: "Invalid Link", message: "Could not get student locations.")
            }
        }
    }

    func populateMapView(){
        var annotations = [MKPointAnnotation]()
        for student in StudentDataModel.studentLocations {
            let lat = CLLocationDegrees(student.latitude)
            let long = CLLocationDegrees(student.longitude)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(student.firstName) \(student.lastName)"
            annotation.subtitle = student.website
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
            
        }

        performUIUpdatesOnMain {
            // When the array is complete, we add the annotations to the map.
            self.mapView.addAnnotations(annotations)
            print("annotations added to the map view.")
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            
            let app = UIApplication.shared
            if let annotation = view.annotation, let urlString = annotation.subtitle {
                let url = URL(string: urlString!)
                if app.canOpenURL(url) {
                    app.open(url, options: [:], completionHandler: nil)
                }else{
                    displayAlert(title: "Invalid Link", message: "Selected web link could not be opened.")
                }
            }

            
            
        }
    }
    
//    func displayAlert(_ errorString: String?) {
//        if let errorString = errorString {
//            let alert = UIAlertController(title: "Map View", message: "\(errorString)", preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
    
}

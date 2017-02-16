//
//  LocationMapViewController.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/10/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit
import MapKit

class LocationMapViewController: UIViewController, MKMapViewDelegate,UINavigationControllerDelegate{
    
    var studentInfoArray: [StudentInformations] = [StudentInformations]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pinLocationsOnMapView()
    }
    func pinLocationsOnMapView(){
        ParseClient.sharedInstance().getStudentLocation { (results, error) in
            if let studentInfoResult = results {
                self.studentInfoArray = studentInfoResult
                var annotations = [MKPointAnnotation]()
                performUIUpdatesOnMain {
                    for student in self.studentInfoArray {
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
                    // When the array is complete, we add the annotations to the map.
                    self.mapView.addAnnotations(annotations)
                }
            } else {
                print(error)
            }
        }
    }
}

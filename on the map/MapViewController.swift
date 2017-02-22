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
        getStudentInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func getStudentInfo(){
        ParseClient.sharedInstance().getStudentLocation { (studentInfo, error) in
            // Q: Should I use `if let studentInfo = studentInfo as? [[String: AnyObject]]`
            if let studentInfo = studentInfo {
                self.studentInfoDictionary = studentInfo
                self.populateMapView()
            }else{
                print(error)
            }
        }
    }

    func populateMapView(){
        var annotations = [MKPointAnnotation]()
        for student in self.studentInfoDictionary {
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
        // Q: perfromUIUpdatesOnMain - shoud it include annotaions?
        performUIUpdatesOnMain {
            // When the array is complete, we add the annotations to the map.
            self.mapView.addAnnotations(annotations)
            print("annotations added to the map view.")
        }
    }
    
}

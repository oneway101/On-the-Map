//
//  MapViewController.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/10/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: MapTabBarController, MKMapViewDelegate {
    
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
            if let studentInfo = studentInfo{
                self.studentInfoDictionary = studentInfo
                self.populateMapView()
            }else{
                print(error)
            }
        }
        
    }

    func populateMapView(){
        print("*** popuateMapView ***")
        print(self.studentInfoDictionary)
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
        print("*** annotations ***")
        print(annotations)
        // Q: perfromUIUpdatesOnMain - shoud it include annotaions?
        performUIUpdatesOnMain {
            // When the array is complete, we add the annotations to the map.
            let mapView = self.mapView?.addAnnotations(annotations)
            print("*** mapView ***")
            print(mapView)
            print("annotations added to the map view.")
        }
    }
    
}

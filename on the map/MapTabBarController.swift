//
//  MapTabBarController.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/20/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit

class MapTabBarController: UITabBarController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addLocation(_ sender: Any) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddLocation")
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func refreshLocations(_ sender: Any) {
        ParseClient.sharedInstance().getStudentLocation { (studentInfo, error) in
            if let studentInfo = studentInfo {
                StudentDataModel.studentLocations = studentInfo
                print("refreshed student info!")
            }else{
                print(error)
            }
        }
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        UdacityClient.sharedInstance().udacityLogout { (success, errorString) in
            if success {
                let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginView")
                self.present(controller, animated: true, completion: nil)
            }else{
                print(errorString)
            }
        }
    }
    
}

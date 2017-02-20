//
//  MapTabBarController.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/20/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit

class MapTabBarController: UITabBarController, UINavigationControllerDelegate {

    @IBOutlet weak var refreshMap: UIBarButtonItem!
    @IBOutlet weak var addLocation: UIBarButtonItem!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var mapViewTabBarItem: UITabBarItem!
    @IBOutlet weak var listViewTabBarIem: UITabBarItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

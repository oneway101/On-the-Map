//
//  MapTableViewController.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/20/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit

class MapTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(StudentDataModel.studentLocations.count)
        return StudentDataModel.studentLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "locationCell"
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellID) as! MapTableViewCell
        let student = StudentDataModel.studentLocations[(indexPath as NSIndexPath).row]
        cell.studentNameLabel.text = "\(student.firstName) \(student.lastName)"
        cell.studentLinkLabel.text = "\(student.website)"
        //print("*** cell ***")
        //print(cell)
        return cell
    }
    

}

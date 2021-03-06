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
        print("number of student locations: \(StudentDataModel.studentLocations.count)")
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = StudentDataModel.studentLocations[indexPath.row]
        if let url = URL(string: selectedCell.website) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }else{
                performUIUpdatesOnMain {
                    self.displayAlert(title: "Invalid Link", message: "Selected web link could not be opened.")
                }
            }
        }else{
            performUIUpdatesOnMain {
                self.displayAlert(title: "Invalid Link", message: "Not a valid web link.")
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }    

}

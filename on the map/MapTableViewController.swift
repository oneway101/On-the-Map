//
//  MapTableViewController.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/20/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit

class MapTableViewController: UITableViewController {
    
    var studentInfoDictionary = [StudentInformations]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStudentInfo()
        print(studentInfoDictionary)
    }
    
    private func getStudentInfo(){
        ParseClient.sharedInstance().getStudentLocation { (studentInfo, error) in
            if let studentInfo = studentInfo {
                self.studentInfoDictionary = studentInfo
            }else{
                print(error)
            }
        }
        
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(studentInfoDictionary.count)
        return studentInfoDictionary.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "locationCell"
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellID) as! MapTableViewCell
        let student = self.studentInfoDictionary[(indexPath as NSIndexPath).row]
        cell.studentNameLabel.text = "\(student.firstName) \(student.lastName)"
        cell.studentLinkLabel.text = "\(student.website)"
        print("*** cell ***")
        print(cell)
        return cell
    }
    

}

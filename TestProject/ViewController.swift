//
//  ViewController.swift
//  TestProject
//
//  Created by Angel on 2/28/18.
//  Copyright © 2018 Angel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    weak var delegate:AppointmentServiceDelegate?
    
    var allPastAppointments = [Appointment]()
    var allFutureAppointments = [Appointment]()
    var pastAsthmaApps = [Appointment]()
    var futurAsthmaApps = [Appointment]()
    var future = [Appointment]()
    var past = [Appointment]()
    var pastSegmentSelection = 0
    var futureSegmentSelection = 0
   
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp(){
        
        let nib = UINib(nibName: AppointmentTableViewCell.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: AppointmentTableViewCell.nibName)
        let headerNib = UINib(nibName: HeaderTableViewCell.nibName, bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: HeaderTableViewCell.nibName)
        let imageNib = UINib(nibName: ImageTableViewCell.nibName, bundle: nil)
        tableView.register(imageNib, forCellReuseIdentifier: ImageTableViewCell.nibName)
        
        tableView.allowsSelection = false
        
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0.1961, blue: 0.4078, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.foregroundColor: UIColor.white]
        title = "Brianna's Appointments"
        
        
        let apps = AppointmentService.getInstance()
        apps.delegate = self
        apps.getAppointments()
    }
    
    func filter(segIndex:Int,section:Int){

        if section == 1{
            futureSegmentSelection = segIndex
            
            switch segIndex {
            case 0:
                future = futurAsthmaApps
            case 1:
                future = allFutureAppointments
            default:
                break
            }
        }
        if section == 2{
            pastSegmentSelection = segIndex
            
            switch segIndex {
            case 0:
                past = pastAsthmaApps
            case 1:
                past = allPastAppointments
            default:
                break
            }
        }
        tableView.reloadData()
    }

}

extension ViewController: AppointmentServiceDelegate {
    func appointmentsRetrieved(pastAppointmentArray: [Appointment], futureAppointmentArray: [Appointment]) {
        
        for app in pastAppointmentArray{
            allPastAppointments.append(app)
            if app.isAsthmaAppointment == true{
                pastAsthmaApps.append(app)
            }
        }
        
        for app in futureAppointmentArray{
            allFutureAppointments.append(app)
            if app.isAsthmaAppointment == true{
                futurAsthmaApps.append(app)
            }
        }
        future = futurAsthmaApps
        past = pastAsthmaApps
    }
}



extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
            
        }
        else if section == 1{
            return future.count+1
        }
        else {
            return past.count+1
        }
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier:ImageTableViewCell.nibName) as! ImageTableViewCell
            cell.headerImageView.image = UIImage(named: "appointments-hero")
            return cell
        } else {
            if indexPath.row == 0 {
                
                let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.nibName) as! HeaderTableViewCell
                headerCell.delegate = self
                headerCell.section = indexPath.section
                
                
                if headerCell.section == 1 {
                    headerCell.segControl.selectedSegmentIndex = futureSegmentSelection
                    headerCell.visitsLabel.text = "UPCOMING VISITS"
                } else {
                    headerCell.segControl.selectedSegmentIndex = pastSegmentSelection
                    headerCell.visitsLabel.text = "PAST VISITS"
                }
                
                return headerCell
                
            } else {
   
                
                let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentTableViewCell.nibName) as! AppointmentTableViewCell
                cell.accessoryType = .disclosureIndicator
                

                if indexPath.section == 1 {
                    cell.populateCell(appointment: future[indexPath.row-1])
                } else {
                    cell.populateCell(appointment: past[indexPath.row-1])
                }
                
    
                return cell
            }
        }
    }

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        

        if indexPath.section == 0 {
            return 200
        } else if indexPath.row == 0 {
            return 105
        } else {
            return 150
        }
    }
}

extension ViewController: SegControlDelegate{
    
    func segTapped(index: Int,section:Int) {
        self.filter(segIndex: index,section:section)
    }
    
}



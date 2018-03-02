//
//  AppointmentTableViewCell.swift
//  TestProject
//
//  Created by Angel on 2/28/18.
//  Copyright © 2018 Angel. All rights reserved.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {
    static let nibName = "AppointmentTableViewCell"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var docImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            let inset: CGFloat = 15
            var frame = newFrame
            frame.origin.x += inset
            frame.size.width -= 2 * inset
            super.frame = frame
        }
    }
    
    
    func populateCell(appointment:Appointment){
        docImageView.layer.cornerRadius = docImageView.frame.size.width/2
        docImageView.layer.masksToBounds = true
        if let firstName = appointment.providerFirstName{
            docImageView.image = UIImage(named: firstName)
            if let lastName = appointment.providerLastName{
                nameLabel.text = "\(firstName) \(lastName)"
            }
        }else{
            nameLabel.text = "No Name"
        }
        
        if let dateTime = appointment.dateAndTime{
            
            let formatter = DateFormatter()
            formatter.dateStyle = DateFormatter.Style.medium
            formatter.timeStyle = .short
            
            dateTimeLabel.text = formatter.string(from: dateTime)
        }else{
            dateTimeLabel.text = "No Date or Time"
        }
        
        if let specialty = appointment.providerSpecialty{
            if specialty == "Specialist A"{
                specialtyLabel.text = "Allergy Specialist"
            }else{
                specialtyLabel.text = "Plumonogolist"
            }
            
        }else{
            specialtyLabel.text = "No Speciality"
        }
        
        if let address = appointment.address{
            addressLabel.text = "\(address)"
        }
    }
}

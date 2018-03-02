//
//  HeaderTableViewCell.swift
//  TestProject
//
//  Created by Angel on 2/28/18.
//  Copyright © 2018 Angel All rights reserved.
//

import UIKit


protocol SegControlDelegate: class {
    func segTapped(index: Int,section:Int)
}
class HeaderTableViewCell: UITableViewCell {
    static let nibName = "HeaderTableViewCell"
    @IBOutlet weak var visitsLabel: UILabel!
    @IBOutlet weak var segControl: UISegmentedControl!
    
    weak var delegate:SegControlDelegate?
    var section = 0
    
    override func awakeFromNib() {
        
        let font = UIFont.boldSystemFont(ofSize: 20)
        segControl.setTitleTextAttributes([NSAttributedStringKey.font: font],
                                                for: .normal)
        segControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], for: .normal)
        segControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], for: .selected)

        segControl.layer.borderColor = UIColor.gray.cgColor
        segControl.layer.borderWidth = CGFloat(1)

    }

    @IBAction func segControlTapped(_ sender: AnyObject){

        switch segControl.selectedSegmentIndex
        {
        case 0:
            delegate?.segTapped(index:0, section:section)
        case 1:
            delegate?.segTapped(index:1, section:section)
        default:
            break
        }
    }
    
}

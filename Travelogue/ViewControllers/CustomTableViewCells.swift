//
//  CustomTableViewCells.swift
//  Travelogue
//
//  Created by Miki Hodel on 11/13/20.
//

import UIKit

class LogCustomCell: UITableViewCell {
    
    //Note: When you create a custom UITableViewCell, remember to set the cell's class to this class!
    
    @IBOutlet weak var LabelTitle: UILabel!
    @IBOutlet weak var LabelDate: UILabel!
   
    
}

class TripCustomCell: UITableViewCell {
    
    @IBOutlet weak var LabelOne: UILabel!
    
}

//
//  VenueTableViewCell.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/29/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import UIKit

class VenueTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var venue: JSONVenue? {
        didSet {
            nameLabel.text = venue?.name
            dateLabel.text = venue?.date
        }
    }
    
    
}

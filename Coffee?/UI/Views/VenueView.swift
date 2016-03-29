//
//  VenueView.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/27/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import UIKit

class VenueView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    
    // MARK: - Properties
    var view: UIView!
    
    init(frame: CGRect, venue: RealmVenue) {
        super.init(frame: frame)
        xibSetup(venue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Linking
    func xibSetup(venue: RealmVenue) {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        setupVenue(venue)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "VenueView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    private func setupVenue(venue: RealmVenue) {
        addressLabel.text = venue.address
        ratingLabel.text = "Rating: " + String(venue.rating)
        tipLabel.text = venue.tip
    }
}

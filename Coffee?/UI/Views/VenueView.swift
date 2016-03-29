//
//  VenueView.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/27/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import UIKit

/**
 We put a little bit more business logic in this view in order to avoid cluttering of the file system. The only extra bit that this view contains is the check in system.
 */
class VenueView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var checkInButton: UIButton!
    @IBAction func checkInButtonTapped(sender: UIButton) {
        checkInButton.enabled = false
        checkInButton.alpha = 0.25
        viewModel.checkInUser()
    }
    
    // MARK: - Properties
    var view: UIView!
    var viewModel = VenueViewModel()
    
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
    
    func setupVenue(venue: RealmVenue) {
        addressLabel.text = venue.address
        ratingLabel.text = "Rating: " + String(venue.rating)
        tipLabel.text = venue.tip
        viewModel.venue = venue
    }
}

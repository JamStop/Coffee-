//
//  JSONVenue.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/27/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import Gloss

/**
 JSON class for Foursquare nearby venue response. 
 Converts the location and contact information into JSONLocation and JSONContact respectively.
 */
struct JSONVenue: Decodable {
    
    // MARK: Properties
    
    let id: String?
    let name: String?
    let location: JSONLocation?
    let contact: JSONContact?
    let verified: Bool?
    let url: String?
    let rating: Double?
    let ratingColor: String?
    
    init?(json: JSON) {
        self.id = "id" <~~ json
        self.name = "name" <~~ json
        self.location = "location" <~~ json
        self.contact = "contact" <~~ json
        self.verified = "verified" <~~ json
        self.url = "url" <~~ json
        self.rating = "rating" <~~ json
        self.ratingColor = "ratingColor" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.id,
            "name" ~~> self.name,
            "location" ~~> self.location,
            "contact" ~~> self.contact,
            "verified" ~~> self.verified,
            "url" ~~> self.url,
            "rating" ~~> self.rating,
            "ratingColor" ~~> self.ratingColor
            ])
    }
}


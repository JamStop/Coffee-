//
//  JSONLocation.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/27/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import Gloss

/**
 JSONLocation class used by JSONVenue
 */
struct JSONLocation: Decodable {
    
    // MARK: Properties
    
    let formattedAddress: [String]? // NOTE: - FourSquare's formatted address, in which the first item is always the full address
    let lat: Float?
    let lng: Float?
    let distance: Int?
    
    init?(json: JSON) {
        self.formattedAddress = "formattedAddress" <~~ json
        self.lat = "lat" <~~ json
        self.lng = "lng" <~~ json
        self.distance = "distance" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "formattedAddress" ~~> self.formattedAddress,
            "lat" ~~> self.lat,
            "lng" ~~> self.lng,
            "distance" ~~> self.distance
            ])
    }
}


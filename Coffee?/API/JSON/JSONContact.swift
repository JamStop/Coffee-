//
//  JSONContact.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/27/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import Gloss

/**
 JSONContact class used by JSONVenue
 */
struct JSONContact: Decodable {
    
    // MARK: Properties
    
    let formattedPhone: String? // NOTE: - FourSquare's formatted phone number, in standard formatted
    let twitter: String?
    
    init?(json: JSON) {
        self.formattedPhone = "formattedPhone" <~~ json
        self.twitter = "twitter" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "formattedPhone" ~~> self.formattedPhone,
            "twitter" ~~> self.twitter
            ])
    }
}

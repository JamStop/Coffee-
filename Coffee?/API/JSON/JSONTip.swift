//
//  JSONTip.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/29/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import Gloss

/**
 JSONTip struct that gets consolidated into RealmVenue
 */
struct JSONTip: Decodable {
    
    // MARK: Properties
    
    let text: String?
    
    init?(json: JSON) {
        self.text = "text" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "text" ~~> self.text,
            ])
    }
}

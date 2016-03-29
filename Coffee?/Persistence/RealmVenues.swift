//
//  RealmVenues.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/27/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import RealmSwift

class RealmVenues: Object {
    dynamic var id = 0
    let venues = List<RealmVenue>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

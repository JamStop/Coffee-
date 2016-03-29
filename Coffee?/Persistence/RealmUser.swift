//
//  RealmUser.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/28/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    dynamic var uid = ""
    dynamic var venues: RealmVenues?
    
}

class RealmCurrentUser: Object {
    dynamic var user: RealmUser?
    dynamic var id = 0
    override static func primaryKey() -> String? {
        return "id"
    }
}

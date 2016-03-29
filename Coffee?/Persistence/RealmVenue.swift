//
//  RealmVenue.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/27/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import RealmSwift

class RealmVenue: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var address = ""
    dynamic var lng = 0.0
    dynamic var lat = 0.0
    dynamic var phone = ""
    dynamic var verified = false
    dynamic var url = ""
    dynamic var rating = 0.0
    dynamic var ratingColor = ""
    dynamic var tip = ""
}

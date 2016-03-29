//
//  VenueViewModel.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/29/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import RealmSwift

struct VenueViewModel {
    
    // MARK: - Properties
    let realm = try! Realm()
    let api = FirebaseAPI()
    var venue: RealmVenue!
    
    // MARK: - Functions
    func checkInUser() {

        let currentUser = realm.objects(RealmCurrentUser)
        if currentUser.count == 0 { fatalError("Failed to retrieve current user") }

        api.checkIntoVenue(currentUser[0].user!.uid, venue: venue)
    }
}

//
//  FirebaseAPI.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/29/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

struct FirebaseAPI {
    
    let ref = Firebase(url: "https://coffeeios.firebaseIO.com/")
    
    /**
     Update Firebase Database
     */
    func checkIntoVenue(userID: String, venue: RealmVenue) {
        let newVenue = [
            "name": venue.name,
            "address": venue.address,
            "rating": venue.rating
        ]
        ref.childByAppendingPath("users").childByAppendingPath(userID).childByAppendingPath("venues").childByAppendingPath(venue.id).updateChildValues(newVenue as [NSObject : AnyObject])
    }
    
    /**
     */
    func rx_userIsCheckedIntoVenue(userID: String, venue: String) {
        
    }
}

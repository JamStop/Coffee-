//
//  RealmHelper.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/27/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class RealmHelper {
    
    typealias JSON = [String:AnyObject]
    
    enum RealmError: ErrorType {
        case ErrorDownloadingImage(error: NSError)
        case ErrorParsingJSON(message: String)
        case UnexpectedError(message: String)
    }
    
    // MARK: - Properties
    let realm = try! Realm()
    let disposeBag = DisposeBag()
    
    // MARK: - Public helper function
    func setNearbyVenuesWithJSONItems(items: [JSON]) -> RealmVenues {
        let venues = JSONItemsArrayToRealmVenues(items)
        try! realm.write({
            realm.add(venues, update: true)
        })
        return venues
    }
    
    // MARK: - JSON Conversion
    private func JSONItemsArrayToRealmVenues(items: [JSON]) -> RealmVenues {
        let venues = RealmVenues()
        venues.id = 0
        for item in items {
            guard let venue = item["venue"] else { fatalError("Failed to retrieve venue") }
            guard let tips = item["tips"] as? [AnyObject] else { fatalError("Failed to retrieve tips") }
            guard let venueJson = JSONVenue(json: venue as! [String:AnyObject]) else { fatalError("Failed to parse venue") }
            guard let tipJson = JSONTip(json: tips[0] as! [String:AnyObject]) else { fatalError("Failed to parse tips") }
            
            // "Unsafe" block. However, any failure would have occured in the JSONVenue casting, so these unwraps are safe.
            let newVenue = RealmVenue()
            newVenue.id = venueJson.id!
            newVenue.name = venueJson.name!
            newVenue.address = venueJson.location!.formattedAddress![0]
            newVenue.lng = venueJson.location!.lng!
            newVenue.lat = venueJson.location!.lat!
//            newVenue.phone = venueJson.contact!.formattedPhone ?? ""
            newVenue.verified = venueJson.verified!
//            newVenue.url = venueJson.url!
            newVenue.rating = venueJson.rating!
            newVenue.ratingColor = venueJson.ratingColor ?? "000000"
            newVenue.tip = tipJson.text!
            
            venues.venues.append(newVenue)
        }
        
        return venues
    }
}

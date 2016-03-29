//
//  ProfileViewModel.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/29/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class ProfileViewModel {
    
    // MARK: - Properties
    let realm = try! Realm()
    let user: RealmUser!
    let disposeBag = DisposeBag()
    let api = FirebaseAPI()
    var checkedInVenues: [JSONVenue]!
    typealias JSON = [String: AnyObject]
    
    init() {
        let currentUser = realm.objects(RealmCurrentUser)
        if currentUser.count == 0 { fatalError("Failed to retrieve current user") }
        user = currentUser[0].user
    }
    
    func getCheckIns(handler: (succeeded: Bool) -> Void) {
        api.rx_getUsersCheckIns(user.uid).map { jsonResp -> [JSONVenue] in
            var venues: [JSONVenue] = []
            for item in jsonResp.values {
                guard let venue = JSONVenue(json: item as! JSON) else { fatalError("Failed to parse venue") }
                venues.append(venue)
            }
            
            return venues
            
            }.subscribe (
                onNext: { (venues) -> Void in
                    self.checkedInVenues = venues
                    handler(succeeded: true)
                }
            )
            .addDisposableTo(disposeBag)
    }
}

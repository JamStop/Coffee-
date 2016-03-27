//
//  MapViewModel.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/20/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import RxSwift
import CoreLocation

protocol MapViewModelDelegate: class {
    func MapViewModel(didFinishLoadingNearbyVenues nearbyVenues: [JSONVenue])
}

class MapViewModel {
    
    typealias JSON = [String: AnyObject]
    
    // MARK: - Properties
    let FSApi = FoursquareAPI()
    let disposeBag = DisposeBag()
    weak var delegate: MapViewModelDelegate!
    
    // MARK: - Models
    var nearbyVenues: [JSONVenue]!
    
    var location: CLLocation! {
        didSet {
            if nearbyVenues != nil { return }
            nearbyVenues = []
            FSApi.rx_getNearbyVenues(location).subscribe (
                onNext: { (items) -> Void in
                    self.parseResponseItems(items)
                },
                onError: { (error) -> Void in
                    print(error)
                },
                onCompleted: { () -> Void in
                    print("Completed")
                },
                onDisposed: { () -> Void in
                    
            })
            .addDisposableTo(disposeBag)
        }
    }
    
    // MARK: - Model Loading
    private func parseResponseItems(items: [JSON]) {
        let venues = items.map { item in JSONVenue(json: item["venue"] as! JSON)! }
        nearbyVenues = venues
        delegate.MapViewModel(didFinishLoadingNearbyVenues: venues)
    }

    
}


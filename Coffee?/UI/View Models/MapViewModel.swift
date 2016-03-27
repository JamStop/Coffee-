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
    func mapViewModel(didFinishLoadingNearbyVenues nearbyVenues: RealmVenues)
}

class MapViewModel {
    
    typealias JSON = [String: AnyObject]
    
    // MARK: - Properties
    let FSApi = FoursquareAPI()
    let disposeBag = DisposeBag()
    weak var delegate: MapViewModelDelegate!
    let realmHelper = RealmHelper()
    
    // MARK: - Models
    var nearbyVenues: RealmVenues!
    
    var location: CLLocation! {
        didSet {
            if nearbyVenues != nil { return }
            nearbyVenues = RealmVenues()
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
        nearbyVenues = realmHelper.setNearbyVenuesWithJSONItems(items)
        delegate.mapViewModel(didFinishLoadingNearbyVenues: nearbyVenues)
    }

    
}


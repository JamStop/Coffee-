//
//  FoursquareAPI.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/20/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import QuadratTouch
import CoreLocation
import RxSwift

class FoursquareAPI {
    
    enum FSError: ErrorType {
        case NoResponse
        case ErrorParsingJSON
        case ResponseError(message: String?, error: String?)
        case UnexpectedError(message: String)
    }
    
    typealias JSON = [String: AnyObject]
    
    func rx_getNearbyVenues(location: CLLocation) -> Observable<[JSON]> {
        let parameters = location.parameters()
        
        return Observable.create { observer in
            let task = Session.sharedSession().venues.explore(parameters) { (result) -> Void in
                
                // Unwrapping the response.
                guard let response = result.response else {
                    observer.onError(FSError.ErrorParsingJSON)
                    return
                }
                guard let groups = response["groups"] as? [JSON] else {
                    observer.onError(FSError.ErrorParsingJSON)
                    return
                }
                for group in groups {
                    guard let items = group["items"] as? [JSON] else {
                        observer.onError(FSError.ErrorParsingJSON)
                        return
                    }
                    observer.onNext(items)
                }
                observer.onCompleted()
            }
            task.start()
            return NopDisposable.instance
        }
    }

    
}

extension CLLocation {
    func parameters() -> Parameters {
        let ll      = "\(self.coordinate.latitude),\(self.coordinate.longitude)"
        let llAcc   = "\(self.horizontalAccuracy)"
        let alt     = "\(self.altitude)"
        let altAcc  = "\(self.verticalAccuracy)"
        let query = "coffee"
        let parameters = [
            Parameter.ll:ll,
            Parameter.llAcc:llAcc,
            Parameter.alt:alt,
            Parameter.altAcc:altAcc,
            Parameter.query:query
        ]
        return parameters
    }
}

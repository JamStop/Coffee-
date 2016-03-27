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
    
    enum RealmError: ErrorType {
        case ErrorDownloadingImage(error: NSError)
        case ErrorParsingJSON(message: String)
        case UnexpectedError(message: String)
    }
    
    // MARK: - Properties
    let realm = try! Realm()
    let disposeBag = DisposeBag()
    
    // MARK: - Public helper function
    
    // MARK: - JSON Conversion
    private func JSONVenueArrayToRealmVenues
}

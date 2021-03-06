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
import Alamofire

/**
 In this class, I demonstrate both Firebase's RESTful capabilities, as well as its realtime/socket capabilities.
 */
struct FirebaseAPI {
    
    typealias Tags = [String]
    typealias JSON = [String: AnyObject]
    typealias CompletionHandler = (response: JSON? , error: APIError?) -> Void
    
    enum APIError: ErrorType {
        case NoResponse
        case ErrorParsingJSON
        case ResponseError(message: String?, error: String?)
        case UnexpectedError(message: String)
    }
    
    let ref = Firebase(url: "https://coffeeios.firebaseIO.com/")
    let baseURL = "https://coffeeios.firebaseIO.com/"
    
    /**
     Update Firebase Database
     */
    func checkIntoVenue(userID: String, venue: RealmVenue) {
        let newVenue = [
            "name": venue.name,
            "address": venue.address,
            "rating": venue.rating,
            "date": String(NSDate().formatted)
        ]
        ref.childByAppendingPath("users").childByAppendingPath(userID).childByAppendingPath("venues").childByAutoId().updateChildValues(newVenue as [NSObject : AnyObject])
    }
    
    /**
     Retrieve current user's venues
     */
    func rx_getUsersCheckIns(userID: String) -> Observable<JSON> {
        return get("users/" + userID + "/venues", parameters: nil)
    }
    
    // MARK: - Basic HTTP Functions (RESTful TechCrunch)
    
    /**
     * A method that executes a HTTP GET.
     *
     * - parameter endpoint: The endpoint e.g. `users.get`.
     * - parameter parameters: The parameters in JSON (refer to the documentation).
     * - returns: An observable JSON.
     */
    private func get(endpoint: String, parameters: JSON?) -> Observable<JSON> {
        
        return request(.GET, endpoint: endpoint, parameters: parameters)
        
    }
    
    /**
     * A method that executes a HTTP POST.
     *
     * - parameter endpoint: The endpoint e.g. `user.posts`.
     * - parameter parameters: The parameters in JSON (refer to the documentation).
     * - returns: An observable JSON.
     */
    private func post(endpoint: String, parameters: JSON?) -> Observable<JSON> {
        
        return request(.POST, endpoint: endpoint, parameters: parameters)
        
    }
    
    /**
     * Basic Request
     * Convenience method to support the GET and POST methods.
     *
     * - parameter method: The HTTP method e.g. `.GET`.
     * - parameter endpoint: The endpoint e.g. `user.posts` (refer to the documentation)
     * - parameter parameters: A dictionary of parameters e.g. `["url": "www.google.com"]`.
     * - returns: An observable JSON.
     */
    
    private func request(method: Alamofire.Method, endpoint: String, parameters: [String:AnyObject]?) -> Observable<JSON> {
        
        // .GET or .POST encoding
        let encoding: Alamofire.ParameterEncoding = method == Alamofire.Method.GET ? .URL : .JSON
        
        return Observable.create { observer in
            Alamofire.request(method, self.baseURL + endpoint + ".json", parameters: parameters, encoding: encoding, headers: nil).responseJSON(options: .AllowFragments) { (resp) -> Void in
                guard let response = resp.response else {
                    observer.onError(APIError.NoResponse)
                    return
                }
                
                if (response.statusCode == 200) {
                    guard let responseJSON = resp.result.value as? JSON else {
                        observer.onError(
                            APIError.UnexpectedError(
                                message: "Error getting result value from JSON response"))
                        return
                    }
                    
                    if let error = responseJSON["error"] {
                        // error fetching data
                        let message = responseJSON["message"] as? String
                        observer.onError(APIError.ResponseError(
                            message: message, error: String(error)))
                    } else {
                        // no errors
                        // print(responseJSON)
                        observer.onNext(responseJSON)
                    }
                } else {
                    observer.onError(APIError.UnexpectedError(message: "Status code not 200"))
                }
            }
            
            return NopDisposable.instance
        }
        
        
    }
}

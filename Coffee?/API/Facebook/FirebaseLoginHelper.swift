//
//  FirebaseLoginHelper.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/28/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit
import RealmSwift


class FirebaseLoginHelper {
    var ref: Firebase!
    
    let facebookLogin = FBSDKLoginManager()
    
    let realm = try! Realm()
    
    func login(viewController: UIViewController, completion: (Bool) -> Void) {
        ref = Firebase(url: "https://coffeeios.firebaseIO.com/")
        
        facebookLogin.logInWithReadPermissions(["public_profile"], fromViewController: viewController, handler: {
            (facebookResult, facebookError) -> Void in
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else if facebookResult.isCancelled {
                print("Facebook login was cancelled.")
                completion(false)
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print(facebookResult)
                self.ref.authWithOAuthProvider("facebook", token: accessToken,
                    withCompletionBlock: { error, authData in
                        if error != nil {
                            print("Login failed. \(error)")
                            completion(false)
                            return
                        } else {
                            print("Logged in! \(authData)")
                            print(authData.provider)
                            self.getFBUserData(completion)
                        }
                })
            }
        })
    }
    
    
    func getFBUserData(completion: (Bool) -> Void) {
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if error != nil {
                    completion(false)
                }
                else {
                    guard let userData : NSDictionary = result as? NSDictionary else { return }
                    guard let uid = userData["id"] as? String else { return }
                    
                    let userInfo = [
                        "name": userData["name"]!
                    ]
                    
                    self.ref.childByAppendingPath("users").childByAppendingPath(uid).updateChildValues(userInfo)
                    
                    let newUser = RealmUser(value: ["uid": uid])
                    let newCurrentUser = RealmCurrentUser(value: [newUser, 0])
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        try! self.realm.write {
                            self.realm.add(newCurrentUser, update: true)
                            completion(true)
                        }
                    })
                    
                }
            })
        }
    }
    
    
    
}

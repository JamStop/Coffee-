//
//  AppDelegate.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/19/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import QuadratTouch
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /**
     Typically used for session setups, and other global application property sets. However, this particular method can get particularly loaded if relied on too much, and there are often better places to set these kinds of properties.
    */
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Facebook Setup
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Foursquare Setup
        setupFoursquareSession()
        
        // Check Current User
        let realm = try! Realm()
        let currentUser = realm.objects(RealmCurrentUser)
        
        if currentUser.count > 0 {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc = mainStoryboard.instantiateInitialViewController()
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        
        // Realm Migration Block
//        Realm.Configuration.defaultConfiguration = Realm.Configuration(
//            schemaVersion: 0,
//            migrationBlock: { migration, oldSchemaVersion in
//                if (oldSchemaVersion < 0) {
//                    // The enumerate(_:_:) method iterates
//                }
//        })
    
        return true
    }
    
    /**
     Activates the Facebook SDK app events upon application launch or switch to.
     This probably has to do with internal authentication
    */
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    /**
     Check whether the url to be opened should be done through Foursquare or Facebook. If both are false, then iOS will handle the url.
    */
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
//        let delegateUrlToThirdParty = FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation) || Session.sharedSession().handleURL(url)
        
        if url.scheme.isEqual("fb1564778950516704") {
            return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation) || Session.sharedSession().handleURL(url)
        }
        else if url.scheme.isEqual("iOSCoffee") {
            return Session.sharedSession().handleURL(url)
        }
        
        return false
    }
    
    /**
     Retrieves the Foursquare keys from Config.plist (In actual production, my Config.plist keys will not be publically available on Github. Instead, it would be replaced with a Config.plist with empty keys
    */
    private func setupFoursquareSession() {
        
        // During debug, I want to crash under the scenerio of unwrapping failures.
        guard let plistPath = NSBundle.mainBundle().pathForResource("Config", ofType: "plist") else {
            fatalError("Failed to access/unwrap the Config plist path")
        }
        guard let config = NSDictionary.init(contentsOfFile: plistPath) else {
            fatalError("Failed to convert plistPath into valid NSDictionary")
        }
        guard let foursquareKeys = config["FoursquareAPI"] else {
            fatalError("Failed to access FoursquareAPI key")
        }
        
        // These are OK to force unwrap. After the above unwrap passes, there should be no scenerio in which these are nil
        let clientId = foursquareKeys["ClientID"] as! String
        let clientSecret = foursquareKeys["ClientSecret"] as! String
        
        // Rest of Foursquare setup
        let client = Client(
            clientID: clientId,
            clientSecret: clientSecret,
            redirectURL: "iOSCoffee://"
        )
        
        var configuration = Configuration(client: client)
        configuration.mode = "foursquare"
        configuration.shouldControllNetworkActivityIndicator = true
        Session.setupSharedSessionWithConfiguration(configuration)
        
    }
    
    func escapeToLogin() {
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        
        let mainStoryboard = UIStoryboard(name: "Login", bundle: NSBundle.mainBundle())
        let vc = mainStoryboard.instantiateInitialViewController()
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }


}


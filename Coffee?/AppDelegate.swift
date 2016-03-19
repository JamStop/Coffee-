//
//  AppDelegate.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/19/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import UIKit
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    /**
     Typically used for session setups, and other global application property sets. However, this particular method can get particularly loaded if relied on too much, and there are often better places to set these kinds of properties.
    */
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    
        return true
    }
    
    
    /**
     Activates the Facebook SDK app events upon application launch or switch to.
     This probably has to do with internal authentication
    */
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }


}


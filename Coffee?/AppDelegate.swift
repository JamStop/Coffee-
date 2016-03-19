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


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    /**
     Activates the Facebook SDK app events upon application launch or switch to.
     This probably has to do with internal authentication
    */
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }


}


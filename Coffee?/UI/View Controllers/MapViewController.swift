//
//  MapViewController.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/20/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import UIKit
import CoreLocation

class MapViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = MapViewModel()
    let locationManager = CLLocationManager()
    @IBOutlet weak var mainView: MapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocationManager()
    }
    
    // MARK: - Alert Presentations
    private func showNoPermissionsAlert() {
        let alertController = UIAlertController(title: "No permission",
            message: "In order to work, app needs your location", preferredStyle: .Alert)
        let openSettings = UIAlertAction(title: "Open settings", style: .Default, handler: {
            (action) -> Void in
            let URL = NSURL(string: UIApplicationOpenSettingsURLString)
            UIApplication.sharedApplication().openURL(URL!)
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(openSettings)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func showErrorAlert(error: NSError) {
        let alertController = UIAlertController(title: "Error",
            message:error.localizedDescription, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: {
            (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        let status = CLLocationManager.authorizationStatus()
        if status == .NotDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        } else if status == CLAuthorizationStatus.AuthorizedWhenInUse
            || status == CLAuthorizationStatus.AuthorizedAlways {
                self.locationManager.startUpdatingLocation()
        } else {
            showNoPermissionsAlert()
        }
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
    }

}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .Denied || status == .Restricted {
            showNoPermissionsAlert()
        } else {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        showErrorAlert(error)
    }
    
    func locationManager(manager: CLLocationManager,
        didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
            viewModel.location = newLocation
    }

}

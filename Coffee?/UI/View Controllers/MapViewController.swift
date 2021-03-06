//
//  MapViewController.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/20/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import RealmSwift

class MapViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = MapViewModel()
    let locationManager = CLLocationManager()
    @IBOutlet weak var mainView: MapView!
    let api = FirebaseAPI()

    // MARK: - Functionality
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocationManager()
        delegateSetups()
    }
    
    @IBAction func profileButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("viewProfile", sender: sender)
    }
    
    @IBAction func signOut(sender: AnyObject) {
        // Wipe the current user
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        
        // Login screen
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.escapeToLogin()
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
    
    // MARK: - Delegate Setups
    private func setupLocationManager() {
        locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
        mainView.mapView.showsUserLocation = true
    }
    
    private func delegateSetups() {
        mainView.mapView.delegate = self
        viewModel.delegate = self
    }

}

// MARK: - CLLocationManagerDelegate
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
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        mainView.goToLocation(location)
        viewModel.location = location
        self.locationManager.stopUpdatingLocation()
    }

}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
    
        guard let location = userLocation.location else { fatalError("Could not parse user location") }
        viewModel.location = location
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        guard let venueAnnotation = annotation as? VenuePointAnnotation else { return nil }
        let venue = venueAnnotation.venue
        
        let annotationView = MKPinAnnotationView(annotation: venueAnnotation, reuseIdentifier: venue.id)
        let detailButton = UIButton(type: UIButtonType.DetailDisclosure)
        
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = detailButton
//        annotationView.pinTintColor = UIColor(rgba: "#" + venue.ratingColor)
        annotationView.animatesDrop = true
        
        let rating = venue.rating
        if rating >= 8.5 {
            annotationView.pinTintColor = UIColor.greenColor()
        }
        else if rating >= 7.5 {
            annotationView.pinTintColor = UIColor.yellowColor()
        }
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? VenuePointAnnotation else { return }
        let venue = annotation.venue
        
        let vc = UIViewController()
        vc.view = VenueView(frame: vc.view.frame, venue: venue)
        vc.navigationItem.title = venue.name
        
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
}

// MARK: - MapViewModelDelegate
extension MapViewController: MapViewModelDelegate {
    func mapViewModel(didFinishLoadingNearbyVenues nearbyVenues: RealmVenues) {
        mainView.pinVenuesOnMap(nearbyVenues)
    }
}

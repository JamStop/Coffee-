//
//  MapView.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/20/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView {

    // MARK: - View Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - View Functionalities
    func goToLocation(location: CLLocation) {
        let longitude = location.coordinate.longitude
        let latitude = location.coordinate.latitude
        
        // Early out for invalid coordinates
        if latitude < -90 || latitude > 90 || longitude < -180 || longitude > 180 { return }
        
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
    }
    
    func pinVenuesOnMap(venues: RealmVenues) {
        venues.venues.forEach { venue in
            let coordinate = CLLocationCoordinate2D(latitude: venue.lat, longitude: venue.lng)
            let point = VenuePointAnnotation()
            point.coordinate = coordinate
            point.title = venue.name + ", Rating: " + String(venue.rating)
            point.subtitle = venue.address
            point.venue = venue
            
            self.mapView.addAnnotation(point)
        }
    }

}

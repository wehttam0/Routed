//
//  MapsViewController.swift
//  cityride
//
//  Created by Matthew Attou on 5/21/16.
//  Copyright © 2016 Matthew Attou. All rights reserved.
//

import UIKit
import GoogleMaps

class MapsViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var path = GMSMutablePath()
    
    var halfwayCord = CLLocationCoordinate2D()
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        self.mapView.camera = GMSCameraPosition.cameraWithLatitude(halfwayCord.latitude,
                                                          longitude:halfwayCord.longitude,
                                                            zoom:10)
        
        let rectangle = GMSPolyline(path: self.path)
        rectangle.map = mapView
        rectangle.strokeColor = UIColor.greenColor()
        rectangle.strokeWidth = 3
//        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
//        
//        let marker = GMSMarker()
//        marker.position = camera.target
//        marker.snippet = "Hello World"
//        marker.appearAnimation = kGMSMarkerAnimationPop
//        marker.map = mapView
//        
//        self.view = mapView
    }
    
//    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//
//        if status == .AuthorizedAlways {
//            
//            locationManager.startUpdatingLocation()
//            
//            self.mapView.myLocationEnabled = true
//            self.mapView.settings.myLocationButton = true
//        }
//    }
//
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        if let location = locations.first {
//            
//            self.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
//            
//            locationManager.stopUpdatingLocation()
//    }
//  }
}

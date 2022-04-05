//
//  MapViewController.swift
//  ParkLocation
//
//  Created by Jin younkyum on 2022/04/04.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var MyMap: MKMapView!
    
    var locationManager: CLLocationManager!
        
    
    // MARK: - ViewdidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    
    // MARK: - Actions
    
    
    
    // MARK: - Helpers (Methods)

    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            getLocationUsagePermission()
        case .restricted:
            getLocationUsagePermission()
        case .denied:
            getLocationUsagePermission()
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
        case .authorized:
            self.locationManager.startUpdatingLocation()
        default:
            print("GPS DEFAULT")
        }
    }
    
    func getLocationUsagePermission() {
        print("GPS request regected")
    }
}

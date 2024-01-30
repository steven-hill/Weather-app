//
//  LocationManager.swift
//  Weather app
//
//  Created by Steven Hill on 01/01/2024.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    var locationManager: CLLocationManager { get set }
}

class LocationService: NSObject, CLLocationManagerDelegate, LocationServiceProtocol, ObservableObject {
    
    var isUpdatingLocations: Bool = false
    var locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        isUpdatingLocations = true
        guard (locations.last?.coordinate) != nil else { return }
        locationManager.stopUpdatingLocation()
        isUpdatingLocations = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .notDetermined:
            authorizationStatus = .notDetermined
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            authorizationStatus = .restricted
            break
        case .denied:
            authorizationStatus = .denied
            break
        case .authorizedAlways:
            authorizationStatus = .authorizedAlways
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            authorizationStatus = .authorizedWhenInUse
            locationManager.startUpdatingLocation()
        @unknown default:
            fatalError()
        }
    }
}

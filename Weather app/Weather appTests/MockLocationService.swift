//
//  MockLocationService.swift
//  Weather appTests
//
//  Created by Steven Hill on 15/01/2024.
//

import Foundation
@testable import Weather_app
import CoreLocation

class MockLocationService: LocationServiceProtocol {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    var locationManager = CLLocationManager()
}

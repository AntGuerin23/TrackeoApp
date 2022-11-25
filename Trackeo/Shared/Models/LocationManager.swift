import UIKit
import MapKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var region = MKCoordinateRegion()
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.distanceFilter = kCLDistanceFilterNone
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}

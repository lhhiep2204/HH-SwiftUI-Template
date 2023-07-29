//___FILEHEADER___

import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func locationManager(didUpdateLocations location: CLLocation)
    func locationManager(didFailWithError error: Error)
    func locationManager(didChangeAuthorization status: CLAuthorizationStatus)
}

extension LocationManagerDelegate {
    func locationManager(didUpdateLocations location: CLLocation) { }
    func locationManager(didFailWithError error: Error) { }
    func locationManager(didChangeAuthorization status: CLAuthorizationStatus) { }
}

enum LocationPermissionType {
    case always, whenInUse
}

class LocationManager: NSObject {
    
    // MARK: - Properties
    static let shared = LocationManager()
    
    private var manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    weak var delegate: LocationManagerDelegate?
    
    // MARK: - Constructors
    override init() {
        super.init()
        manager.delegate = self
    }
    
}

// MARK: - Methods
extension LocationManager {
    
    var authorizationStatus: CLAuthorizationStatus {
        return manager.authorizationStatus
    }
    
    func requestPermission(_ type: LocationPermissionType) {
        switch type {
        case .always:
            manager.requestAlwaysAuthorization()
        case .whenInUse:
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func startUpdateLocation() {
        manager.startUpdatingLocation()
    }
    
    func stopUpdateLocation() {
        manager.stopUpdatingLocation()
    }
    
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("LocationManager didUpdateLocations: \(location.coordinate)")
        
        delegate?.locationManager(didUpdateLocations: location)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("LocationManager didFailWithError: \(error.localizedDescription)")
        
        delegate?.locationManager(didFailWithError: error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("LocationManager didChangeAuthorization: \(manager.authorizationStatus)")
        
        delegate?.locationManager(didChangeAuthorization: manager.authorizationStatus)
    }
    
}

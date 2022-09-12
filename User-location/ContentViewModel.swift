//
//  ContentViewModel.swift
//  User-location
//
//  Created by ipeerless on 12/09/2022.
//
import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
}

final class ContentViewModel:NSObject, ObservableObject,CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation,
                                               span: MapDetails.defaultSpan)
    var locationManager: CLLocationManager?
    func checkIfLocationServiceIsEnabled () {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager ()
            locationManager!.delegate = self
      
        } else {
            print("show alert you are off")
        }
        
    }
     private func checkLocationAuthorization () {
        
        guard let locationManager = locationManager else {return}
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center:
                                            locationManager.location!.coordinate,
                                        span: MapDetails.defaultSpan)
        @unknown default:
            break
        }
        
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}


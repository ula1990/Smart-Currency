//
//  NavigationVC.swift
//  EURCurrencyConverter
//
//  Created by Ulad Daratsiuk-Demchuk on 2018-01-27.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NavigationVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let manager = CLLocationManager()
    let request = MKLocalSearchRequest()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy =   kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    

    }


}
//MARK: CONFIGURATION OF MAPVIEW

extension NavigationVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1 )
        let userLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(userLocation, span)
        mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
        
        request.naturalLanguageQuery = "currency exchange"
        request.region = mapView.region
        let activeSearch = MKLocalSearch(request: request)
        activeSearch.start { (response, error) in
            
            guard let response = response else {
                return
            }
            
            for item in response.mapItems {
                print(response.mapItems)
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                
                DispatchQueue.main.async {
                    self.mapView.addAnnotation(annotation)
                }
                
            }
            
        }
        
}
}



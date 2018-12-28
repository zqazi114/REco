//
//  Map.swift
//  REco
//
//  Created by Dev Macbook on 12/24/18.
//  Copyright © 2018 Dumbass Inc. All rights reserved.
//

import UIKit
import MapKit
import MapKitGoogleStyler

class Map: MKMapView, MKMapViewDelegate {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.delegate = self
        configureTileOverlay()
        setMapCamera()
        setCompass()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configureTileOverlay() {
        
        guard let overlayFileURLString = Bundle.main.path(forResource: "overlay", ofType: "json") else {
            print("ERROR: cannot find JSON overlay")
            return
        }
        
        let overlayFileURL = URL(fileURLWithPath: overlayFileURLString)
        
        guard let tileOverlay = try? MapKitGoogleStyler.buildOverlay(with: overlayFileURL) else {
            print("ERROR: couldn't build tile overlay")
            return
        }
        
        self.addOverlay(tileOverlay)
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if let tileOverlay = overlay as? MKTileOverlay {
            return MKTileOverlayRenderer(tileOverlay: tileOverlay)
        } else {
            return MKOverlayRenderer(overlay: overlay)
        }
        
    }
    
    func setMapCamera() {
        
        let center = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: 40.807487)!, longitude: CLLocationDegrees(exactly: -73.962541)!)
        let eyeCoord = center
        let eyeAlt = 1000.0
        
        let mapCam = MKMapCamera(lookingAtCenter: center, fromEyeCoordinate: eyeCoord, eyeAltitude: eyeAlt)
        
        self.camera = mapCam
        
    }
    
    func setCompass() {
        
        let compassSize = 100.0
        let compassFrame = CGRect(x: WIDTH - SPACING - compassSize/2,
                                  y: HEIGHT - SPACING - compassSize/2,
                                  width: compassSize,
                                  height: compassSize)
        
        let compass = MKCompassButton(mapView: self)
        compass.compassVisibility = .visible
        compass.frame = compassFrame
        
        self.addSubview(compass)
        
    }
    
    func addAnnotationsForRestaurants(restaurants: ArraySlice<YelpRestaurant>) {
        
        for restaurant in restaurants {
            
            let annotation = MKPointAnnotation()
            annotation.title = restaurant.name
            
            let address1 = restaurant.location["address1"] as! String
            let city = restaurant.location["city"] as! String
            let address = address1 + " " + city
            
            let geolocator = CLGeocoder()
            geolocator.geocodeAddressString(address) { (placemarks, error) in
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    
                } else if let placemarks = placemarks {
                    
                    annotation.coordinate = placemarks[0].location!.coordinate
                    
                    self.addAnnotation(annotation)
                    
                }
                
            }
            
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else {
            return nil
        }
        
        let identifier = "Annotation"
        
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView.canShowCallout = true
        
        return annotationView
        
    }
    
}

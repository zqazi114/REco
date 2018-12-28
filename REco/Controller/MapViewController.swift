//
//  MapViewController.swift
//  REco
//
//  Created by Dev Macbook on 12/24/18.
//  Copyright © 2018 Dumbass Inc. All rights reserved.
//

import UIKit
import MapKit
import MapKitGoogleStyler

class MapViewController: ViewController {
    
    var mapModel: MapModel?
    var mapView: MapView?
    
    func restaurantsRetrievedNotification() {
        
        let res = mapModel!.yelpManager.restaurants
        var redRes = res[0..<res.count]
        
        if res.count > 10 {
            
            redRes = res[0..<10]
            
        }
        
        mapView!.updateMap(with: redRes)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.mapModel = MapModel(controller: self)
        self.mapView = MapView(controller: self, mainView: self.view)
        
    }

}

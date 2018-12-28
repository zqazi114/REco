//
//  MapModel.swift
//  REco
//
//  Created by Dev Macbook on 12/24/18.
//  Copyright © 2018 Dumbass Inc. All rights reserved.
//

import UIKit

class MapModel: NSObject {

    var mapController: MapViewController
    var yelpManager: YelpManager
    
    init(controller: MapViewController) {
        
        self.mapController = controller
        self.yelpManager = YelpManager(controller: controller, type: .map)
        
        super.init()
        
        TESTcreateBusinesses()
        
    }
    
    func TESTcreateBusinesses() {
        
        
        
    }
    
}

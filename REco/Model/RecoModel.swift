//
//  RecoModel.swift
//  REco
//
//  Created by Dev Macbook on 12/27/18.
//  Copyright © 2018 Dumbass Inc. All rights reserved.
//

import UIKit

class RecoModel: NSObject {

    var recoController: RecoViewController
    
    init(controller: RecoViewController) {
        
        self.recoController = controller
        
        super.init()
        
    }
    
}

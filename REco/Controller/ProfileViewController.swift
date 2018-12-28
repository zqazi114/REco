//
//  ProfileViewController.swift
//  REco
//
//  Created by Dev Macbook on 12/27/18.
//  Copyright © 2018 Dumbass Inc. All rights reserved.
//

import UIKit

class ProfileViewController: ViewController {

    var profileModel: ProfileModel?
    var profileView: ProfileView?
    
    func updateProfile() {
        
        profileView!.profile = profileModel!.profile
        
    }
    
    override func viewDidLoad() {
        
        profileModel = ProfileModel(controller: self)
        profileView = ProfileView(controller: self, mainView: self.view, profile: profileModel!.profile)
        
    }
    
}

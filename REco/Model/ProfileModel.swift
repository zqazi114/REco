//
//  ProfileModel.swift
//  REco
//
//  Created by Dev Macbook on 12/27/18.
//  Copyright © 2018 Dumbass Inc. All rights reserved.
//

import UIKit

struct Profile {
    var name: String
    var title: String
    var location: String
    var imageURL: String
    var dateJoined: String
}

class ProfileModel: NSObject {
    
    var profileController: ProfileViewController
    
    var profile: Profile?
    
    init(controller: ProfileViewController) {
        
        self.profileController = controller
        
        super.init()
        
        TESTcreateProfile()
        
    }
    
    func TESTcreateProfile() {
        
        profile = Profile(name: "Rachel Jordan", title: "Senior Solutions Architect", location: "New York, NY", imageURL: "rachel", dateJoined: "Dec, 2018")
        
    }

}

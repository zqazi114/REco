//
//  ProfileView.swift
//  REco
//
//  Created by Dev Macbook on 12/27/18.
//  Copyright © 2018 Dumbass Inc. All rights reserved.
//

import UIKit

class ProfileView: UIView {

    var profileController: ProfileViewController
    var mainView: UIView
    
    var scrollContainer: UIScrollView?
    var infoContainer: UIView?
    var detailContainer: UIView?
    var name: UILabel?
    var title: UILabel?
    var location: UILabel?
    var image: UIImageView?
    var date: UILabel?
    var activity: UILabel?
    var analytics: UILabel?
    var analysis: UIImageView?
    var analysisText: UILabel?
    
    var margin: CGFloat?
    var infoYPos: CGFloat?
    var infoHeight: CGFloat?
    var detailYPos: CGFloat?
    var detailHeight: CGFloat?
    
    var imageYPos: CGFloat?
    var imageHeight: CGFloat?
    var nameYPos: CGFloat?
    var nameHeight: CGFloat?
    var titleYPos: CGFloat?
    var titleHeight: CGFloat?
    var locationYPos: CGFloat?
    var locationHeight: CGFloat?
    var dateYPos: CGFloat?
    var dateHeight: CGFloat?
    
    var categoryYPos: CGFloat?
    var categoryHeight: CGFloat?
    var analysisYPos: CGFloat?
    var analysisHeight: CGFloat?
    var analysisTextYPos: CGFloat?
    var analysisTextHeight: CGFloat?
    
    var profile: Profile?
    
    init(controller: ProfileViewController, mainView: UIView, profile: Profile?) {
        
        self.profileController = controller
        self.mainView = mainView
        self.profile = profile
        
        super.init(frame: mainView.frame)
        
        setYPosAndHeights()
        
        initializeContainers()
        initializeInfo()
        initializeDetail()
        
        self.mainView.addSubview(self)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.profileController = ProfileViewController()
        self.mainView = UIView()
        super.init(coder: aDecoder)
    }
    
    func setYPosAndHeights() {
        
        margin = 20.0
        
        infoYPos = 0.0
        infoHeight = SHEIGHT/3
        
        detailYPos = infoYPos! + infoHeight!
        detailHeight = SHEIGHT - detailYPos!
        
        nameYPos = 50.0
        nameHeight = 25.0
        
        titleYPos = nameYPos! + nameHeight!
        titleHeight = 20.0
        
        locationYPos = titleYPos! + titleHeight! + 5.0
        locationHeight = 20.0
        
        imageYPos = locationYPos! + locationHeight! + margin!
        imageHeight = 100.0
        
        dateHeight = 20.0
        dateYPos = detailYPos! - dateHeight!
        
        categoryYPos = 0
        categoryHeight = 50.0
        
        analysisYPos = categoryYPos! + categoryHeight! + margin!
        analysisHeight = 300.0
        
        analysisTextYPos = analysisYPos! + analysisHeight! + margin!
        analysisTextHeight = 50.0
        
    }
    
    func initializeContainers() {
        
        let frame = CGRect(x: 0, y: 0, width: SWIDTH, height: SHEIGHT)
        let infoFrame = CGRect(x: 0.0, y: infoYPos!, width: SWIDTH, height: infoHeight!)
        let detailFrame = CGRect(x: 0.0, y: detailYPos!, width: SWIDTH, height: detailHeight!)
        
        infoContainer = UIView(frame: infoFrame)
        infoContainer!.backgroundColor = BLUE
        
        detailContainer = UIView(frame: detailFrame)
        detailContainer!.backgroundColor = UIColor.white
        
        scrollContainer = UIScrollView(frame: frame)
        scrollContainer!.contentSize = CGSize(width: SWIDTH, height: SHEIGHT)
        scrollContainer!.addSubview(infoContainer!)
        scrollContainer!.addSubview(detailContainer!)
        
        self.addSubview(scrollContainer!)
        
    }
    
    func initializeInfo() {
        
        let nameFrame = CGRect(x: 0.0, y: nameYPos!, width: SWIDTH, height: nameHeight!)
        let titleFrame = CGRect(x: 0.0, y: titleYPos!, width: SWIDTH, height: titleHeight!)
        let locationFrame = CGRect(x: (SWIDTH-200)/2, y: locationYPos!, width: 200.0, height: locationHeight!)
        let imageFrame = CGRect(x: (SWIDTH-imageHeight!)/2, y: imageYPos!, width: imageHeight!, height: imageHeight!)
        let medalFrame = CGRect(x: SWIDTH/2+imageHeight!/2+margin!,
                                y: imageYPos!,
                                width: 50.0,
                                height: 50.0)
        let dateJoinedFrame = CGRect(x: 0.0, y: dateYPos!, width: SWIDTH, height: dateHeight!)
        
        name = UILabel(frame: nameFrame)
        name!.font = UIFont(name: "GillSans-Bold", size: 25.0)
        name!.textAlignment = .center
        name!.textColor = UIColor.white
        name!.text = profile!.name
        
        title = UILabel(frame: titleFrame)
        title!.font = UIFont(name: "GillSans", size: 20.0)
        title!.textAlignment = .center
        title!.textColor = UIColor.white
        title!.text = profile!.title
        
        location = UILabel(frame: locationFrame)
        location!.font = UIFont(name: "GillSans", size: 20.0)
        location!.textAlignment = .center
        location!.textColor = UIColor.white
        location!.text = profile!.location
        
        image = UIImageView(frame: imageFrame)
        image!.contentMode = .scaleToFill
        image!.clipsToBounds = true
        image!.layer.cornerRadius = imageHeight!/2
        image!.image = UIImage(named: profile!.imageURL)
        
        let medal = UIImageView(frame: medalFrame)
        medal.contentMode = .scaleAspectFit
        medal.image = UIImage(named: "silver")
        
        date = UILabel(frame: dateJoinedFrame)
        date!.font = UIFont(name: "GillSans", size: 15.0)
        date!.textAlignment = .right
        date!.textColor = UIColor.white
        date!.text = "Member since " + profile!.dateJoined + "  "
        
        self.infoContainer!.addSubview(name!)
        self.infoContainer!.addSubview(title!)
        self.infoContainer!.addSubview(location!)
        self.infoContainer!.addSubview(image!)
        self.infoContainer!.addSubview(medal)
        self.infoContainer!.addSubview(date!)
        
    }
    
    func initializeDetail() {
        
        let categoryFrame = CGRect(x: 0.0, y: categoryYPos!, width: SWIDTH, height: categoryHeight!)
        let activityFrame = CGRect(x: 1, y: 2, width: SWIDTH/2-1, height: categoryHeight!-4)
        let analyticsFrame = CGRect(x: SWIDTH/2+0.5, y: 2, width: SWIDTH/2-1, height: categoryHeight!-4)
        let analysisFrame = CGRect(x: (SWIDTH-analysisHeight!)/2, y: analysisYPos!, width: analysisHeight!, height: analysisHeight!)
        let analysisTextFrame = CGRect(x: 10.0, y: analysisTextYPos!, width: SWIDTH-20.0, height: analysisTextHeight!)
        
        activity = UILabel(frame: activityFrame)
        activity!.backgroundColor = UIColor.white
        activity!.font = UIFont(name: "GillSans-Bold", size: 25.0)
        activity!.textAlignment = .center
        activity!.textColor = BLUE
        activity!.text = "Activity"
        
        analytics = UILabel(frame: analyticsFrame)
        analytics!.backgroundColor = BLUE
        analytics!.font = UIFont(name: "GillSans-Bold", size: 25.0)
        analytics!.textAlignment = .center
        analytics!.textColor = UIColor.white
        analytics!.text = "Analytics"
        
        let categoryContainer = UIView(frame: categoryFrame)
        categoryContainer.backgroundColor = BLUE
        categoryContainer.addSubview(activity!)
        categoryContainer.addSubview(analytics!)
        
        analysis = UIImageView(frame: analysisFrame)
        analysis!.contentMode = .scaleAspectFit
        analysis!.image = UIImage(named: "data")
        
        analysisText = UILabel(frame: analysisTextFrame)
        analysisText!.backgroundColor = UIColor.white
        analysisText!.font = UIFont(name: "Cochin", size: 17.0)
        analysisText!.textAlignment = .left
        analysisText!.numberOfLines = 0
        analysisText!.text = "You reduced your trash production by 7.4% this month\n\nIf you begin composting, you can gain credits at the following merchants: Sweetgreen, Dig Inn\n\n"
        analysisText!.sizeToFit()
        
        detailContainer!.addSubview(categoryContainer)
        detailContainer!.addSubview(analysis!)
        detailContainer!.addSubview(analysisText!)
        
    }
    
}

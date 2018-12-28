//
//  TabBarController.swift
//  REco
//
//  Created by Dev Macbook on 12/27/18.
//  Copyright © 2018 Dumbass Inc. All rights reserved.
//

import UIKit
import SwiftyGif

class TabBarController: UITabBarController, SwiftyGifDelegate {

    var logoView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = BLUE
        animateLogo()
        
    }
    
    func animateLogo() {
        
        let gif = UIImage(gifName: "logo.gif")
        
        let logoGif = UIImageView(gifImage: gif)
        logoGif.loopCount = 1
        logoGif.frame = CGRect(x: (SWIDTH-300)/2, y: (SHEIGHT-300)/2, width: 300.0, height: 300.0)
        logoGif.contentMode = .scaleAspectFit
        logoGif.image = UIImage(named: "logo")
        logoGif.delegate = self
        
        let logoTitle = UIImageView(frame: CGRect(x: (SWIDTH-300)/2, y: 778, width: 300, height: 100))
        logoTitle.contentMode = .scaleAspectFit
        logoTitle.image = UIImage(named: "logo1")
        
        logoView = UIView(frame: CGRect(x: 0, y: 0, width: SWIDTH, height: SHEIGHT))
        logoView!.backgroundColor = UIColor(red: 36/255, green: 49/255, blue: 85/255, alpha: 1.0)
        logoView!.addSubview(logoGif)
        logoView!.addSubview(logoTitle)
        
        self.view.addSubview(logoView!)
        
    }
    
    func gifDidStop(sender: UIImageView) {
        
        UIView.animate(withDuration: 1.0, animations: {
            self.logoView!.alpha = 0.0
        }) { (completed) in
            self.logoView!.isHidden = true
            self.logoView = nil
        }
        
    }

}

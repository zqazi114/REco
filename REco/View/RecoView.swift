//
//  RecoView.swift
//  REco
//
//  Created by Dev Macbook on 12/27/18.
//  Copyright © 2018 Dumbass Inc. All rights reserved.
//

import UIKit

class RecoView: UIView {

    var recoController: RecoViewController
    var mainView: UIView
    
    var scrollContainer: UIScrollView?
    var catView: UIView?
    var tipsView: UIView?
    var recoButton: UIView?
    var recoLabel: UILabel?
    var recoImage: UIImageView?
    var recoImage2: UIImageView?
    
    var margin: CGFloat?
    var catTitleYPos: CGFloat?
    var catYPos: CGFloat?
    var catHeight: CGFloat?
    var tipsTitleYPos: CGFloat?
    var tipsYPos: CGFloat?
    var tipsHeight: CGFloat?
    var recoTitleYPos: CGFloat?
    var recoYPos: CGFloat?
    var recoHeight: CGFloat?
    var recoImageYPos: CGFloat?
    var recoImageHeight: CGFloat?
    var recoImage2YPos: CGFloat?
    var recoImage2Height: CGFloat?
    
    init(controller: RecoViewController, mainView: UIView) {
        
        self.recoController = controller
        self.mainView = mainView
        
        super.init(frame: mainView.bounds)
        
        setYPosAndHeights()
        
        initializeScrollContainer()
        initializeCatView()
        initializeTipsView()
        initializeRecoView()
        
        self.mainView.addSubview(self)
        
    }
    
    func setYPosAndHeights() {
        
        margin = 20.0
        
        catTitleYPos = margin!
        catYPos = catTitleYPos! + HEADERHEIGHT
        catHeight = 100.0
        
        tipsTitleYPos = catYPos! + catHeight! + margin!
        tipsYPos = tipsTitleYPos! + HEADERHEIGHT
        tipsHeight = SHEIGHT/3
        
        recoTitleYPos = tipsYPos! + tipsHeight! + margin!
        recoYPos = recoTitleYPos! + HEADERHEIGHT
        recoHeight = 50.0
        
        recoImageYPos = recoYPos! + recoHeight! + margin!
        recoImageHeight = 300.0
        
        recoImage2YPos = recoImageYPos! + recoImageHeight! + margin!
        recoImage2Height = 300.0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.recoController = RecoViewController()
        self.mainView = UIView()
        super.init(coder: aDecoder)
    }
    
    func initializeScrollContainer() {
        
        let frame = CGRect(x: 0, y: 0, width: SWIDTH, height: SHEIGHT)
        
        scrollContainer = UIScrollView(frame: frame)
        scrollContainer!.backgroundColor = UIColor.white
        scrollContainer!.contentSize = CGSize(width: SWIDTH, height: 2*SHEIGHT)
        
        self.addSubview(scrollContainer!)
        
    }
    
    func initializeCatView() {
        
        let header = self.makeHeader(with: "Cheat Sheet", y: catTitleYPos!)
        
        let margin = CGFloat(40.0)
        let size = catHeight! - 30.0
        let textSize = size + 30.0
        let frame1 = CGRect(x: margin, y: catYPos!, width: size, height: size)
        let frame12 = CGRect(x: margin, y: catYPos!+size, width: textSize, height: 20.0)
        let frame2 = CGRect(x: (SWIDTH - size)/2, y: catYPos!, width: size, height: size)
        let frame22 = CGRect(x: (SWIDTH - size)/2, y: catYPos!+size, width: textSize, height: 20.0)
        let frame3 = CGRect(x: SWIDTH - size - margin, y: catYPos!, width: size, height: size)
        let frame32 = CGRect(x: SWIDTH - size - margin, y: catYPos!+size, width: textSize, height: 20.0)
        
        let icon1 = UIImageView(frame: frame1)
        icon1.contentMode = .scaleAspectFit
        icon1.image = UIImage(named: "plastic")
        
        let icon2 = UIImageView(frame: frame2)
        icon2.contentMode = .scaleAspectFit
        icon2.image = UIImage(named: "compost")
        
        let icon3 = UIImageView(frame: frame3)
        icon3.contentMode = .scaleAspectFit
        icon3.image = UIImage(named: "trash")
        
        let label1 = UILabel(frame: frame12)
        label1.font = UIFont(name: "GillSans", size: 20.0)
        label1.textAlignment = .center
        label1.textColor = UIColor.lightGray
        label1.text = "recycle"
        
        let label2 = UILabel(frame: frame22)
        label2.font = UIFont(name: "GillSans", size: 20.0)
        label2.textAlignment = .center
        label2.textColor = UIColor.lightGray
        label2.text = "compost"
        
        let label3 = UILabel(frame: frame32)
        label3.font = UIFont(name: "GillSans", size: 20.0)
        label3.textAlignment = .center
        label3.textColor = UIColor.lightGray
        label3.text = "trash"
        
        scrollContainer!.addSubview(header)
        scrollContainer!.addSubview(icon1)
        scrollContainer!.addSubview(icon2)
        scrollContainer!.addSubview(icon3)
        scrollContainer!.addSubview(label1)
        scrollContainer!.addSubview(label2)
        scrollContainer!.addSubview(label3)
        
    }
    
    func initializeTipsView() {
        
        let header = self.makeHeader(with: "Tips", y: tipsTitleYPos!)
        
        let frame = CGRect(x: 40.0, y: tipsYPos!, width: SWIDTH-60.0, height: tipsHeight!)
        
        let tips = UILabel(frame: frame)
        tips.font = UIFont(name: "Cochin", size: 20.0)
        tips.numberOfLines = 0
        tips.text = "1. Avoid using plastic forks and spoons\n\n 2. Use paper straws\n\n 3. Keep three bins (Compost, Recycling, Trash)\n\n 4. Turn shower off while shampooing\n\n 5. Keep your lights off during the day\n\n 6. Install insulating windows to reduce heating costs"
        tips.sizeToFit()
        
        scrollContainer!.addSubview(header)
        scrollContainer!.addSubview(tips)
        
    }
    
    func initializeRecoView() {
        
        let header = self.makeHeader(with: "REco Vision Engine", y: recoTitleYPos!)
        
        let width = CGFloat(200.0)
        let frame = CGRect(x: (SWIDTH-width)/2, y: recoYPos!, width: width, height: recoHeight!)
        let textFrame = CGRect(x: 0, y: 0, width: width, height: recoHeight!)
        let imageFrame = CGRect(x: (SWIDTH-recoImageHeight!)/2, y: recoImageYPos!, width: recoImageHeight!, height: recoImageHeight!)
        let imageFrame2 = CGRect(x: (SWIDTH-recoImage2Height!)/2, y: recoImage2YPos!, width: recoImage2Height!, height: recoImage2Height!)
        
        recoLabel = UILabel(frame: textFrame)
        recoLabel!.font = UIFont(name: "GillSans-Bold", size: 25.0)
        recoLabel!.backgroundColor = UIColor.clear
        recoLabel!.textAlignment = .center
        recoLabel!.textColor = UIColor.white
        recoLabel!.text = "REco it"
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.recoTapped(gestureRecognizer:)))
        
        recoButton = UIView(frame: frame)
        recoButton!.backgroundColor = BLUE
        recoButton!.layer.cornerRadius = recoHeight!/2
        recoButton!.clipsToBounds = true
        recoButton!.isUserInteractionEnabled = true
        recoButton!.addSubview(recoLabel!)
        recoButton!.addGestureRecognizer(tapGR)
        
        recoImage = UIImageView(frame: imageFrame)
        recoImage!.contentMode = .scaleAspectFill
        recoImage!.clipsToBounds = true
        recoImage!.image = UIImage(named: "image")
        
        recoImage2 = UIImageView(frame: imageFrame2)
        recoImage2!.contentMode = .scaleAspectFill
        recoImage2!.clipsToBounds = true
        recoImage2!.image = UIImage(named: "result")
        recoImage2!.isHidden = true
        
        scrollContainer!.addSubview(header)
        scrollContainer!.addSubview(recoButton!)
        scrollContainer!.addSubview(recoImage!)
        scrollContainer!.addSubview(recoImage2!)
        
    }
    
    @objc func recoTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        if gestureRecognizer.view == recoButton {
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.recoButton!.backgroundColor = UIColor.lightGray
                self.recoLabel!.textColor = BLUE
                
            }) { (completed) in
                
                self.scrollContainer!.setContentOffset(CGPoint(x: 0.0, y: self.recoTitleYPos! - 50.0), animated: true)
                self.recoController.performReco()
                
            }
            
        }
        
    }
    
    func updateImage(image: UIImage) {
        
        self.recoImage!.image = image
        self.recoImage2!.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.recoButton!.backgroundColor = BLUE
            self.recoLabel!.textColor = UIColor.white
            
        }) { (completed) in
            
        }
        
    }

}

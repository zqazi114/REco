//
//  ErrorView.swift
//  Chivalry
//
//  Created by Dev Macbook on 7/15/18.
//  Copyright © 2018 Dumbass Inc. All rights reserved.
//

import UIKit

class ErrorView: UIView {

    var errorBubble: UIView?
    
    static func displayError(mainView: UIView, message: String) {
        
        let size = 100.0
        let center = CGPoint(x: size/2, y: size/2)
        let frame = CGRect(x: 0.0, y: 0.0, width: WIDTH, height: HEIGHT - 70.0)
        let timerFrame = CGRect(x: (WIDTH - size)/2, y: HEIGHT - 200, width: size, height: size)
        let messageFrame = CGRect(x: 50.0, y: 100.0, width: (WIDTH - 100.0), height: 200.0)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.bounds = frame
        blurView.center = CGPoint(x: SWIDTH/2, y: SHEIGHT/2 + 70.0 - 30.0)
        blurView.alpha = 0.0
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.dismissTapped(gestureRecognizer:)))
        
        let timerPath = UIBezierPath(arcCenter: center, radius: CGFloat(size/2), startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        
        let timerLayer = CAShapeLayer()
        timerLayer.frame = CGRect(x: 0, y: 0, width: size, height: size)
        timerLayer.path = timerPath.cgPath
        timerLayer.strokeColor = UIColor.white.cgColor
        timerLayer.lineWidth = 10.0
        timerLayer.fillColor = nil
        timerLayer.opacity = 0.0
        timerLayer.strokeEnd = 1.0
        
        let timerView = UIView(frame: timerFrame)
        timerView.layer.addSublayer(timerLayer)
        timerView.alpha = 0.0
        //timerView.addGestureRecognizer(tapGR)
        
        let messageView = UILabel(frame: messageFrame)
        //messageView.font = UIFont(name: BODYFONT, size: BODY)
        //messageView.textColor = WHITE
        messageView.textAlignment = .center
        messageView.numberOfLines = 10
        messageView.text = message
        messageView.alpha = 0.0
        
        mainView.addSubview(blurView)
        mainView.addSubview(timerView)
        mainView.addSubview(messageView)
        
        animateAppear(mainView: mainView, blurView: blurView, timerView: timerView, timerLayer: timerLayer, messageView: messageView)
        
    }
    
    static func animateAppear(mainView: UIView, blurView: UIVisualEffectView, timerView: UIView, timerLayer: CAShapeLayer, messageView: UILabel) {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            blurView.alpha = 1.0
            timerView.alpha = 1.0
            timerLayer.opacity = 1.0
            messageView.alpha = 1.0
            
        }) { (completed) in
            
            animateCountdown(mainView: mainView, blurView: blurView, timerView: timerView, timerLayer: timerLayer, messageView: messageView)
            
        }
        
    }
    
    static func animateCountdown(mainView: UIView, blurView: UIVisualEffectView, timerView: UIView, timerLayer: CAShapeLayer, messageView: UILabel) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            
            animateDisappear(mainView: mainView, blurView: blurView, timerView: timerView, messageView: messageView)
            
        }
        
        let size = 100.0
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 5.0
        animation.fillMode = CAMediaTimingFillMode.forwards
        //animation.isCumulative = true
        animation.isRemovedOnCompletion = false
        
        timerLayer.add(animation, forKey: "strokeEnd")
        
        CATransaction.commit()
        
    }
    
    static func animateDisappear(mainView: UIView, blurView: UIVisualEffectView, timerView: UIView, messageView: UILabel) {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            blurView.alpha = 0.0
            timerView.alpha = 0.0
            messageView.alpha = 0.0
            
        }) { (completed) in
            
            blurView.removeFromSuperview()
            timerView.removeFromSuperview()
            
        }
        
    }
    
    @objc func dismissTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        print("Dismiss tapped")
        
    }

}

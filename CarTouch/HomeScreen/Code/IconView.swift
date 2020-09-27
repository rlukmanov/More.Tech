//
//  IconView.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 26.09.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class IconView: UIView {
    
    var rotateDuration = 1.0
    
    @IBOutlet var circleOneImageView: [UIImageView]!
    @IBOutlet var circleTwoImageView: [UIImageView]!
    @IBOutlet var circleThreeImageView: [UIImageView]!
    @IBOutlet var circleFourImageView: [UIImageView]!
    
    @IBAction func startRotate(_ sender: Any) {
        
        self.rotateCircleOne()
    }
    
    @IBAction func clear(_ sender: Any) {
        circleOneImageView.first!.layer.removeAllAnimations()
        circleTwoImageView.first!.layer.removeAllAnimations()
        circleThreeImageView.first!.layer.removeAllAnimations()
        circleFourImageView.first!.layer.removeAllAnimations()
    }
    
    @objc
    func rotateCircleOne() {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.rotateCircleTwo()
        })

        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = 2 * CGFloat.pi
        rotationAnimation.duration = rotateDuration
        
        self.circleOneImageView.first!.layer.add(rotationAnimation, forKey: nil)
        CATransaction.commit()
    }
    
    func rotateCircleTwo() {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.rotateCircleThree()
        })
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = -CGFloat.pi * 3 / 2
        rotationAnimation.duration = rotateDuration / 4 * 3
        rotationAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotationAnimation.isRemovedOnCompletion = false
        
        self.circleTwoImageView.first!.layer.add(rotationAnimation, forKey: nil)
        CATransaction.commit()
    }
    
    func rotateCircleThree() {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.rotateCircleFour()
        })
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = CGFloat.pi
        rotationAnimation.duration = rotateDuration / 2
        rotationAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotationAnimation.isRemovedOnCompletion = false
        
        self.circleThreeImageView.first!.layer.add(rotationAnimation, forKey: nil)
        CATransaction.commit()
    }
    
    func rotateCircleFour() {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            //self.rotateCircleThree()
        })
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = -CGFloat.pi / 2
        rotationAnimation.duration = rotateDuration / 4
        rotationAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotationAnimation.isRemovedOnCompletion = false
        
        self.circleFourImageView.first!.layer.add(rotationAnimation, forKey: nil)
        CATransaction.commit()
    }
 
}

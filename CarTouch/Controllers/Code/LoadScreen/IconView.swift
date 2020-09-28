//
//  IconView.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 26.09.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class IconView: UIView {
    
    var rotateDuration = 2.0
    var scaleAntTranslationDuration = 2.0
    
    @IBOutlet var circleOneImageView: [UIImageView]!
    @IBOutlet var circleTwoImageView: [UIImageView]!
    @IBOutlet var circleThreeImageView: [UIImageView]!
    @IBOutlet var circleFourImageView: [UIImageView]!
    
    var delegate: TitleAnimationProtocol?
    var delegateHome: ToHomeProtocol?
    
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
    
    private func rotateCircleTwo() {
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
    
    private func rotateCircleThree() {
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
    
    private func rotateCircleFour() {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.scaleAndTranslateAnimation()
            self.delegate?.startAnimation()
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
    
    private func scaleAndTranslateAnimation() {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.delegateHome?.toHomeScreen()
        })
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.toValue = 92.0 / 200.0
        scaleAnimation.duration = scaleAntTranslationDuration
        scaleAnimation.fillMode = CAMediaTimingFillMode.forwards
        scaleAnimation.isRemovedOnCompletion = false
        
        let translationAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        translationAnimation.toValue = -110
        translationAnimation.duration = scaleAntTranslationDuration
        translationAnimation.fillMode = CAMediaTimingFillMode.forwards
        translationAnimation.isRemovedOnCompletion = false
        
        self.layer.add(scaleAnimation, forKey: nil)
        self.layer.add(translationAnimation, forKey: nil)
        CATransaction.commit()
    }
}

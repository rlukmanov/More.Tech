//
//  IconView.swift
//  CarTouch
//
//  Created by Ruslan Lukmanov on 26.09.2020.
//  Copyright © 2020 GangBank. All rights reserved.
//

import UIKit

class IconView: UIView {
    
    // MARK: - Properties
    
    private var rotateDuration = 2.0
    private var scaleAntTranslationDuration = 4.0
    private var leadingConstraint = NSLayoutConstraint()
    
    @IBOutlet var circleOneImageView: [UIImageView]!
    @IBOutlet var circleTwoImageView: [UIImageView]!
    @IBOutlet var circleThreeImageView: [UIImageView]!
    @IBOutlet var circleFourImageView: [UIImageView]!
    
    // MARK: - Delegates
    
    var delegate: TitleAnimationProtocol?
    var delegateHome: ToHomeProtocol?
    
    // MARK: - Configurate Function
    
    func configurate(withMultiplier multiplier: Double) {
        rotateDuration *= multiplier
        scaleAntTranslationDuration *= multiplier
    }
    
    // MARK: - Rotate Animations
    
    func doRotation() {
        rotateCircleOne()
        rotateCircleTwo()
        rotateCircleThree()
        rotateCircleFour()
    }
    
    private func rotateCircleOne() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = 2 * CGFloat.pi
        rotationAnimation.duration = rotateDuration
        
        self.circleOneImageView.first!.layer.add(rotationAnimation, forKey: nil)
    }
    
    private func rotateCircleTwo() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = -CGFloat.pi * 3 / 2
        rotationAnimation.duration = rotateDuration // / 4 * 3
        rotationAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotationAnimation.isRemovedOnCompletion = false
        
        self.circleTwoImageView.first!.layer.add(rotationAnimation, forKey: nil)
    }
    
    private func rotateCircleThree() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = CGFloat.pi
        rotationAnimation.duration = rotateDuration // / 2
        rotationAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotationAnimation.isRemovedOnCompletion = false
        
        self.circleThreeImageView.first!.layer.add(rotationAnimation, forKey: nil)
    }
    
    private func rotateCircleFour() {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.translateAndScaleAnimation()
            self.delegate?.startAnimation()
        })
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = -CGFloat.pi / 2
        rotationAnimation.duration = rotateDuration // / 4
        rotationAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotationAnimation.isRemovedOnCompletion = false
        
        self.circleFourImageView.first!.layer.add(rotationAnimation, forKey: nil)
        CATransaction.commit()
    }
    
    // MARK: - Scale & Translate Animations
    
    private func scaleAnimation(circleImageView: UIImageView) {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.toValue = 92.0 / 200.0
        scaleAnimation.duration = scaleAntTranslationDuration
        scaleAnimation.fillMode = CAMediaTimingFillMode.forwards
        scaleAnimation.isRemovedOnCompletion = false
        
        circleImageView.layer.add(scaleAnimation, forKey: nil)
    }
    
    private func translateAndScaleAnimation() {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.delegateHome?.toHomeScreen()
        })
        
        guard let superview = superview else {
            return
        }
        
        UIView.animate(withDuration: scaleAntTranslationDuration, delay: 0.0, options: .curveEaseOut, animations: {
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 32).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -(32 + 209 + 11)).isActive = true // 32 - offset from left, 209 - width title, 11 - between icon and title
            superview.layoutIfNeeded()
        }, completion: nil)
        
        CATransaction.commit()
    }
}
